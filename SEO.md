# SEO and Google setup — preetmendpara.in

What the site already does, and the manual steps only you can do.

## Already in the code

| Area | Where |
| --- | --- |
| Title, description, canonical (`https://preetmendpara.in/`), robots | `public/index.html` |
| Open Graph + Twitter/X cards, 1200×630 share image | `public/index.html`, `public/og-image.png` |
| Person + WebSite + ProfilePage + project list JSON-LD, `sameAs` GitHub and LinkedIn | `public/index.html` |
| Crawlable HTML copy of the page (name, about, projects, skills, education) inside `#root`, replaced by the app on load | `public/index.html` |
| Project pages with SoftwareApplication + Breadcrumb JSON-LD | `public/projects/runs-at-dev/`, `public/projects/weblens-ai/` |
| `robots.txt`, `sitemap.xml` | `public/` |
| `404.html` is `noindex` | `public/404.html` |
| `*.pages.dev` is `noindex` (only the official domain gets indexed) | `public/_headers` |

## 1. Connect the domain

1. Cloudflare dashboard → Workers & Pages → your Pages project → **Custom domains** → *Set up a custom domain* → `preetmendpara.in`.
2. Add `www.preetmendpara.in` too.
3. Redirect `www` to the bare domain. In the `preetmendpara.in` zone, go to Rules → **Redirect Rules** → create a rule: hostname equals `www.preetmendpara.in`, redirect dynamically to `concat("https://preetmendpara.in", http.request.uri.path)`, status 301, preserve query string.
4. Open `https://preetmendpara.in/` and `https://preetmendpara.in/projects/weblens-ai/` and check both load.

## 2. Verify in Google Search Console

1. Go to <https://search.google.com/search-console> → **Add property** → **Domain** → `preetmendpara.in`.
2. Google shows a TXT record such as `google-site-verification=...`.
3. Cloudflare → `preetmendpara.in` zone → DNS → **Add record**: Type `TXT`, Name `@`, Content = that value.
4. Back in Search Console, click **Verify**. It usually works within minutes.

A Domain property covers `https`, `http`, `www` and every subdomain, so no HTML file or meta tag is needed.

## 3. Submit the sitemap

Search Console → **Sitemaps** → enter `sitemap.xml` → Submit.

Then **URL Inspection** → `https://preetmendpara.in/` → *Request indexing*. Repeat for both project pages.

## 4. Check structured data

- <https://search.google.com/test/rich-results> → test `https://preetmendpara.in/` and each project page.
- <https://validator.schema.org/> for the full graph.

## 5. The old address

`preetmendpara.qzz.io` still serves the same site. Its pages point Google at `preetmendpara.in` via the canonical tag. Once the new domain is indexed, either stop using the old one or keep it: it will not compete, because of the canonical.

## 6. Strengthen the name signal (outside this repo)

Google decides which results show for "Preet Mendpara" from links pointing at the site:

- LinkedIn → Contact info → Website: `https://preetmendpara.in`.
- GitHub profile → Website: `https://preetmendpara.in`. The profile README and project READMEs should link to it too.
- runs-at.dev and WebLens AI: link "Built by Preet Mendpara" back to `https://preetmendpara.in`.
- Use the same name, photo and one-line bio everywhere.
- Add a real headshot later: put it at `public/preet-mendpara.jpg` and change `"image"` in the Person JSON-LD to that URL.

Expect the site to show for your name within a few days to a few weeks after indexing.
