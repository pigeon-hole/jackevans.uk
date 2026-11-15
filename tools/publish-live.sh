#!/usr/bin/env bash
# Publishes the committed site on main to jackevans.uk behind the holding page's pigeon latch.
# The live branch (checked out in ../jackevans-live) holds the holding page at / and a copy of main in site/.
set -euo pipefail
SITE="$(cd "$(dirname "$0")/.." && pwd)"
LIVE="$SITE/../jackevans-live"
DIR=site

cd "$LIVE"
[ "$(git branch --show-current)" = live ] || { echo "$LIVE is not on the live branch" >&2; exit 1; }
rm -rf "$DIR"; mkdir "$DIR"
git -C "$SITE" archive main | tar -x -C "$DIR"
rm -rf "$DIR/CNAME" "$DIR/.nojekyll" "$DIR/.gitignore" "$DIR/tools"
cp "$DIR/favicon.ico" .
mkdir -p images && cp "$DIR"/images/favicon-*.png "$DIR"/images/apple-touch-icon.png images/

git add -A
if git diff --cached --quiet; then echo "Live copy already matches main."; exit 0; fi
git commit -q -m "Site copy from main $(git -C "$SITE" rev-parse --short main)" -m "Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>"
git push -q origin live
echo "Pushed. GitHub Pages rebuilds in about a minute."
