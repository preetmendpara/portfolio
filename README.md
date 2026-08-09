# Preet Mendpara — Portfolio

Live: https://preetmendpara.qzz.io (also https://preet-mendpara-portfolio.pages.dev)

Static site hosted on Cloudflare Pages. Everything served to the browser lives in `public/`.

## Deploy

Double-click **`deploy.bat`**. It bumps the cache version, deploys, checks the live
site, and keeps the window open. If it says you're not logged in, run `npx wrangler login`
once — the OAuth token dies after a few weeks of not deploying.

Manual equivalent:

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

- The `?v=` query on `overrides.css` / `enhancements.js` is bumped automatically by
  `deploy.bat`, so edits reach visitors. It's needed because `preetmendpara.qzz.io`
  is a subdomain of DigitalPlat's Cloudflare zone, which overrides our
  `Cache-Control: no-cache` with `max-age=14400`. That zone isn't in this account,
  so the URL itself has to change.
- Avoid `transform` in hover rules in `overrides.css`. The compiled app positions
  some elements (the theme toggle) with transforms; overriding them makes elements
  jump. `enhancements.js` calls `clearProps` after each reveal for the same reason.
- Editing `_headers`: Cloudflare **combines** same-named headers from every matching
  rule rather than overriding, so keep CSP off the `/*` wildcard to avoid doubling it.
  The inline Google Tag Manager snippet is allowed by a `sha256-` hash in the CSP —
  changing that snippet means recomputing the hash.
