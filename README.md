<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=12&height=200&section=header&text=Preet%20Mendpara&fontSize=60&fontColor=ffffff&animation=fadeIn&fontAlignY=38" alt="Preet Mendpara" width="100%">
</p>

<p align="center">
  <a href="https://preetmendpara.qzz.io"><img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&duration=3000&pause=900&color=F5A623&center=true&vCenter=true&width=640&lines=Pixel-art+portfolio;Full-stack+developer;Built+with+React+%2B+PixiJS;Deployed+on+Cloudflare+Pages" alt="Pixel-art portfolio"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=white" alt="React">
  <img src="https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript">
  <img src="https://img.shields.io/badge/PixiJS-E91E63?style=for-the-badge&logo=pixijs&logoColor=white" alt="PixiJS">
  <img src="https://img.shields.io/badge/GSAP-88CE02?style=for-the-badge&logo=greensock&logoColor=white" alt="GSAP">
  <img src="https://img.shields.io/badge/Cloudflare%20Pages-F38020?style=for-the-badge&logo=cloudflarepages&logoColor=white" alt="Cloudflare Pages">
</p>

<p align="center">
  <a href="https://preetmendpara.qzz.io"><b>Live site</b></a> &nbsp;·&nbsp; <a href="https://github.com/preetmendpara"><b>GitHub</b></a>
</p>

Live: https://preetmendpara.qzz.io (also https://preet-mendpara-portfolio.pages.dev)

Static site hosted on Cloudflare Pages. Everything served to the browser lives in `public/`.

## Deploy

Cloudflare Pages is connected to this repository: every push to `main` deploys
`public/` automatically (no build command, output directory `public`).

After editing `overrides.css` or `enhancements.js`, run `bump-version.ps1` before
committing so the `?v=` cache-buster changes (see the notes below).

`deploy.bat` still works for a manual deploy with wrangler.

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

---

<p align="center">
  Built by <a href="https://github.com/preetmendpara"><b>Preet Mendpara</b></a> · <a href="https://preetmendpara.qzz.io">Portfolio</a>
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=12&height=110&section=footer" width="100%" alt="">
</p>
