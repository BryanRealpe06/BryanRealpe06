/* ══════════════════════════════════════════════════════════════════
   Glow Devoto — main.js
   Patrón IIFE clásico (sin ES modules: rompen en file:// y en cache).
   Cada init va envuelto: si uno falla, los demás siguen vivos.
   ══════════════════════════════════════════════════════════════════ */
(function () {
  'use strict';

  document.documentElement.classList.remove('no-js');

  function safe(fn, name) {
    try { fn(); }
    catch (e) { console.warn('[glow] init falló:', name, e); }
  }

  /* ── 3. Reveal al hacer scroll ──────────────────────────────────
     Umbral bajo (0.05) para que dispare apenas asoma, y red de
     seguridad a los 6s: nada puede quedar invisible para siempre. */
  function initReveal() {
    var items = Array.prototype.slice.call(document.querySelectorAll('.reveal'));
    if (!items.length) return;

    function showAll() {
      items.forEach(function (n) { n.classList.add('in'); });
    }

    if (!('IntersectionObserver' in window)) { showAll(); return; }

    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (en) {
        if (!en.isIntersecting) return;
        var n = en.target;
        var sibs = n.parentElement ? Array.prototype.slice.call(n.parentElement.children) : [n];
        var i = Math.max(0, sibs.indexOf(n));
        n.style.transitionDelay = Math.min(i * 70, 350) + 'ms';
        n.classList.add('in');
        io.unobserve(n);
      });
    }, { threshold: 0.05, rootMargin: '0px 0px -8% 0px' });

    items.forEach(function (n) { io.observe(n); });

    setTimeout(showAll, 6000);   // red de seguridad obligatoria
  }

  /* ── 4. Anclas con scroll nativo ────────────────────────────────
     Sin Lenis: es frágil entre configuraciones de Windows.        */
  function initAnchors() {
    document.addEventListener('click', function (e) {
      var a = e.target.closest && e.target.closest('a[href^="#"]');
      if (!a) return;
      var id = a.getAttribute('href');
      if (!id || id === '#') return;
      var t = document.querySelector(id);
      if (!t) return;
      e.preventDefault();
      var top = t.getBoundingClientRect().top + window.pageYOffset - 12;
      window.scrollTo({ top: top, behavior: 'smooth' });
    });
  }

  function boot() {
    safe(initReveal,  'reveal');
    safe(initAnchors, 'anchors');
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', boot);
  } else { boot(); }
})();
