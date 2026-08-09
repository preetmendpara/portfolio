#!/usr/bin/env bash
# Deploy public/ to Cloudflare Pages, then check the live site actually serves.
#   ./deploy.sh        deploy
#   ./deploy.sh -b     bump ?v= on overrides.css / enhancements.js first
#                      (do this whenever you edit them, or the edge serves the old file)
set -euo pipefail

cd "$(dirname "$0")"

PROJECT=preet-mendpara-portfolio
SITE=https://preetmendpara.qzz.io
export CLOUDFLARE_ACCOUNT_ID=5b48ce2ce927599a4374e91dfeb21fac

if [[ "${1:-}" == "-b" ]]; then
  for f in overrides.css enhancements.js; do
    cur=$(grep -oE "$f\?v=[0-9]+" public/index.html | head -1 | grep -oE '[0-9]+$')
    next=$((cur + 1))
    sed -i "s|$f?v=$cur|$f?v=$next|g" public/index.html public/404.html
    echo "bumped $f -> v=$next"
  done
fi

npx --yes wrangler@latest pages deploy public \
  --project-name="$PROJECT" --branch=main --commit-dirty=true

echo
fail=0
while read -r path; do
  code=$(curl -s -o /dev/null -w '%{http_code}' "$SITE$path")
  [[ "$code" == 200 ]] || { echo "FAIL $code $path"; fail=1; }
done <<'PATHS'
/
/overrides.css
/enhancements.js
/gsap.min.js
/assets/spa-index-BbxwJ9Tg.js
/favicon.ico
PATHS

if [[ $fail -eq 0 ]]; then
  echo "live OK: $SITE"
else
  echo "live check FAILED (edge cache may lag ~30s; re-run to confirm)" >&2
  exit 1
fi
