/* GSAP progressive-enhancement layer for the compiled portfolio SPA.
 *
 * The app already fades whole sections in (.fade-section -> .visible, 1.2s);
 * this layer adds what it lacks: per-item stagger reveals inside those
 * sections. Rules learned the hard way on this site:
 *  - never leave inline transforms behind on elements whose CSS :hover uses
 *    transform (.quest-card, .connect-link) -> always clearProps on complete
 *  - the app mounts asynchronously into #root -> wait for targets to exist
 *  - respect prefers-reduced-motion via gsap.matchMedia()
 */
(function () {
  'use strict';
  if (!window.gsap || !window.ScrollTrigger) return;
  gsap.registerPlugin(ScrollTrigger);

  var GROUPS = [
    { sel: '.quest-card',          y: 26, stagger: 0.10 }, // featured project cards
    { sel: '.skills-section li',   y: 14, stagger: 0.05 }, // skill list items
    { sel: '.projects-section li', y: 14, stagger: 0.06 }, // personal projects list
    { sel: '.connect-link',        y: 18, stagger: 0.09 }  // footer buttons
  ];

  function setup() {
    var mm = gsap.matchMedia();
    mm.add(
      {
        motionOK: '(prefers-reduced-motion: no-preference)',
        reduceMotion: '(prefers-reduced-motion: reduce)'
      },
      function (context) {
        if (context.conditions.reduceMotion) return; // leave the site exactly as-is

        GROUPS.forEach(function (g) {
          var els = gsap.utils.toArray(g.sel);
          if (!els.length) return;
          gsap.set(els, { opacity: 0, y: g.y });
          ScrollTrigger.batch(els, {
            start: 'top 88%',
            once: true,
            onEnter: function (batch) {
              gsap.to(batch, {
                opacity: 1,
                y: 0,
                duration: 0.55,
                ease: 'power2.out',
                stagger: g.stagger,
                overwrite: true,
                // hand styling back to the app so CSS :hover transforms work
                onComplete: function () { gsap.set(batch, { clearProps: 'all' }); }
              });
            }
          });
        });

        // safety net: anything still hidden after load settles (e.g. items
        // already past their trigger) gets revealed
        setTimeout(function () { ScrollTrigger.refresh(); }, 1500);
      }
    );
  }

  // Wait for the SPA to mount its content, then set up once.
  function whenReady(tries) {
    if (document.querySelector('.quest-card, .connect-link')) { setup(); return; }
    if (tries <= 0) return; // app never mounted targets; do nothing
    setTimeout(function () { whenReady(tries - 1); }, 250);
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function () { whenReady(60); });
  } else {
    whenReady(60);
  }
})();
