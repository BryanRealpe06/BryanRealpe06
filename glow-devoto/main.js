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

  /* ── 1. Título letra por letra ──────────────────────────────────
     El contenido ya está en el HTML; esto solo lo reparte. Si falla,
     el texto queda tal cual (ver .no-js en el CSS).               */
  function initLetters() {
    var el = document.querySelector('[data-letters]');
    if (!el || el.dataset.done === '1') return;     // idempotente
    var text = el.textContent.trim();
    var frag = document.createDocumentFragment();

    text.split('').forEach(function (ch, i) {
      var s = document.createElement('span');
      s.className = 'ltr';
      s.textContent = ch === ' ' ? ' ' : ch;
      s.style.setProperty('--d', (i * 0.045).toFixed(3) + 's');
      frag.appendChild(s);
    });

    el.textContent = '';
    el.appendChild(frag);
    el.dataset.done = '1';
    el.setAttribute('aria-label', text);
  }

  /* ── 2. Resplandor que sigue al cursor ──────────────────────────
     Un solo momento orquestado. Throttled con rAF, desactivado en
     touch (donde el CSS ya ancla el glow).                        */
  function initGlow() {
    var glow = document.querySelector('.hero__glow');
    var hero = document.getElementById('hero');
    if (!glow || !hero) return;
    if (!window.matchMedia('(hover:hover) and (pointer:fine)').matches) return;

    var tx = 0, ty = 0, cx = 0, cy = 0, raf = null;

    function loop() {
      cx += (tx - cx) * 0.085;
      cy += (ty - cy) * 0.085;
      glow.style.setProperty('--mx', cx.toFixed(1) + 'px');
      glow.style.setProperty('--my', cy.toFixed(1) + 'px');
      if (Math.abs(tx - cx) > 0.4 || Math.abs(ty - cy) > 0.4) {
        raf = requestAnimationFrame(loop);
      } else { raf = null; }
    }

    hero.addEventListener('pointermove', function (e) {
      var r = hero.getBoundingClientRect();
      tx = (e.clientX - r.left - r.width / 2) * 0.42;
      ty = (e.clientY - r.top - r.height / 2) * 0.42;
      if (!raf) raf = requestAnimationFrame(loop);
    }, { passive: true });

    hero.addEventListener('pointerleave', function () {
      tx = 0; ty = 0;
      if (!raf) raf = requestAnimationFrame(loop);
    }, { passive: true });
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
    safe(initLetters, 'letters');
    safe(initGlow,    'glow');
    safe(initReveal,  'reveal');
    safe(initAnchors, 'anchors');
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', boot);
  } else { boot(); }
})();
