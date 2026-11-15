#!/usr/bin/env bash
# Publishes the committed site on main to jackevans.uk behind the holding page's pigeon latch.
# The live branch (checked out in ../jackevans-live) holds the holding page at / and a copy of main in site/.
# Only what is committed on main is published, so commit first.
set -euo pipefail
SITE="$(cd "$(dirname "$0")/.." && pwd)"
LIVE="$SITE/../jackevans-live"
DIR=site

cd "$LIVE"
[ "$(git branch --show-current)" = live ] || { echo "$LIVE is not on the live branch" >&2; exit 1; }
MAIN="$(git rev-parse main)"          # same repository as $SITE, so main is visible here

# Swap the old copy for the new one in git's index, then make the working folder match the index.
git rm -r -q --cached "$DIR" >/dev/null 2>&1 || true
git read-tree --prefix="$DIR/" "$MAIN"
for f in CNAME .nojekyll .gitignore; do git rm -q --cached "$DIR/$f" >/dev/null 2>&1 || true; done
git rm -r -q --cached "$DIR/tools" >/dev/null 2>&1 || true
git ls-files -z "$DIR" | git checkout-index -f -z --stdin   # write the new copy's files
git clean -q -fd "$DIR"                                      # drop files main no longer has
cp "$DIR/favicon.ico" .
mkdir -p images && cp "$DIR"/images/favicon-*.png "$DIR"/images/apple-touch-icon.png images/
git add -A

if git diff --cached --quiet; then echo "Live copy already matches main."; exit 0; fi
git commit -q -m "Site copy from main ${MAIN:0:7}" -m "Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>"
git push -q origin live
echo "Pushed. GitHub Pages rebuilds in about a minute."
