# Preet Mendpara — Portfolio

Live: https://preetmendpara.qzz.io (also https://preet-mendpara-portfolio.pages.dev)

Static site hosted on Cloudflare Pages. Everything served to the browser lives in `public/`.

## Deploy

```bash
npx wrangler pages deploy public --project-name=preet-mendpara-portfolio --branch=main --commit-dirty=true
```

## Layout

```
public/
  index.html          entry page
  404.html            same SPA shell, serves unknown routes
  assets/             compiled app bundle (JS/CSS) + sprites — do not hand-edit
  overrides.css       our CSS on top of the compiled bundle
  enhancements.js     our GSAP scroll reveals
  gsap.min.js         GSAP 3.13 (self-hosted; CSP is script-src 'self')
  ScrollTrigger.min.js
  _headers            Cloudflare security headers + CSP
  sitemap.xml, site.webmanifest, favicons
```

## Editing notes

`assets/` is a compiled build with hashed filenames — the original source project
is not in this repo, so the app itself can't be meaningfully edited here. Our
changes ride on top via `overrides.css` and `enhancements.js`.

- **Bump the `?v=` query on `overrides.css` / `enhancements.js` in both HTML files
  whenever you edit them** — otherwise Cloudflare's edge and browsers keep serving
  the old file.
- Avoid `transform` in hover rules in `overrides.css`. The compiled app positions
  some elements (the theme toggle) with transforms; overriding them makes elements
  jump. `enhancements.js` calls `clearProps` after each reveal for the same reason.
- Editing `_headers`: Cloudflare **combines** same-named headers from every matching
  rule rather than overriding, so keep CSP off the `/*` wildcard to avoid doubling it.
  The inline Google Tag Manager snippet is allowed by a `sha256-` hash in the CSP —
  changing that snippet means recomputing the hash.
