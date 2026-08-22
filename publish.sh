#!/usr/bin/env bash
# publish.sh — create the repository and publish the site on GitHub Pages.
#
#   Run it from inside the folder that holds index.html:
#     cd "/Volumes/ADATA HD710 PRO/CV_Repo"
#     bash publish.sh
#
# Requires: git, and the GitHub CLI (gh). Install gh with:  brew install gh
# Authenticate once with:  gh auth login      (never paste a token into a file)

set -euo pipefail

GH_USER="PabloTadeo"
REPO="${GH_USER}.github.io"

say() { printf "\n\033[1m%s\033[0m\n" "$1"; }
die() { printf "\n\033[31mERROR: %s\033[0m\n" "$1" >&2; exit 1; }

# ---------------------------------------------------------------- checks
say "1/6  Checking the folder"

[ -f index.html ] || die "index.html not found. Run this from the folder that contains it."

MISSING=0
for f in \
  index.html \
  README.md \
  CLAUDE.md \
  .gitignore \
  assets/portrait.jpg \
  assets/media/marching-band.jpg \
  assets/figures/skin-results.jpg \
  assets/figures/skin-setup-a.jpg \
  assets/figures/skin-setup-b.jpg \
  assets/figures/skin-colorimetry.jpg \
  assets/figures/mpees-icc-between.jpg \
  assets/figures/mpees-icc-within.jpg \
  assets/figures/mpees-setup.jpg
do
  if [ -f "$f" ]; then
    printf "      ok    %s\n" "$f"
  else
    printf "      MISSING  %s\n" "$f"
    MISSING=$((MISSING+1))
  fi
done
[ "$MISSING" -eq 0 ] || die "$MISSING file(s) missing. Fix the folder structure and run again."

# ---------------------------------------------------------------- secrets
say "2/6  Scanning for credentials"

if grep -rIlE 'ghp_[A-Za-z0-9]{20,}|github_pat_|-----BEGIN [A-Z ]*PRIVATE KEY-----' . \
     --exclude-dir=.git --exclude=publish.sh 2>/dev/null | grep . ; then
  die "Possible credential found in the files listed above. Remove it before publishing."
fi
printf "      clean\n"

# ---------------------------------------------------------------- tools
say "3/6  Checking tools"

command -v git >/dev/null || die "git is not installed."
command -v gh  >/dev/null || die "GitHub CLI not installed. Run: brew install gh"
gh auth status >/dev/null 2>&1 || die "Not signed in to GitHub. Run: gh auth login"
printf "      git and gh ready\n"

# ---------------------------------------------------------------- git
say "4/6  Preparing the local repository"

if [ ! -d .git ]; then
  git init -q
  printf "      initialised\n"
else
  printf "      already a git repository\n"
fi

git add -A
if git diff --cached --quiet 2>/dev/null; then
  printf "      nothing new to commit\n"
else
  git commit -q -m "Publish academic portfolio: EN/ES site, selected work figures, AI ecosystem"
  printf "      committed\n"
fi
git branch -M main

# ---------------------------------------------------------------- remote
say "5/6  Creating and pushing the repository"

if gh repo view "${GH_USER}/${REPO}" >/dev/null 2>&1; then
  printf "      %s already exists on GitHub\n" "$REPO"
  git remote get-url origin >/dev/null 2>&1 || \
    git remote add origin "https://github.com/${GH_USER}/${REPO}.git"
else
  gh repo create "${REPO}" --public --source=. --remote=origin --description \
    "Academic portfolio of Pablo Tadeo Rios-Gallardo, PhD"
  printf "      created\n"
fi

git push -u origin main
printf "      pushed\n"

# ---------------------------------------------------------------- pages
say "6/6  Enabling GitHub Pages"

if gh api "repos/${GH_USER}/${REPO}/pages" >/dev/null 2>&1; then
  printf "      Pages already enabled\n"
else
  gh api -X POST "repos/${GH_USER}/${REPO}/pages" \
    -f "source[branch]=main" -f "source[path]=/" >/dev/null \
    && printf "      enabled\n" \
    || printf "      could not enable automatically. Do it in Settings > Pages: main / root\n"
fi

say "Done."
printf "Your site will be live in a couple of minutes at:\n  https://%s\n\n" "$REPO"
printf "From now on, to publish any change:\n  git add . && git commit -m \"your message\" && git push\n\n"
