#!/usr/bin/env bash
# -*- coding: utf-8 -*-
#
# File: dev/sphinx/create_docs.sh
# Part of 'UBDCC Dashboard'
# License: MIT
# https://github.com/oliver-zehentleitner/ubdcc-dashboard/blob/master/LICENSE

set -euo pipefail

rm -f dev/sphinx/source/changelog.md
rm -f dev/sphinx/source/code_of_conduct.md
rm -f dev/sphinx/source/contributing.md
rm -f dev/sphinx/source/readme.md
rm -f dev/sphinx/source/security.md

cp CHANGELOG.md dev/sphinx/source/changelog.md
cp CODE_OF_CONDUCT.md dev/sphinx/source/code_of_conduct.md
cp CONTRIBUTING.md dev/sphinx/source/contributing.md
cp README.md dev/sphinx/source/readme.md
cp SECURITY.md dev/sphinx/source/security.md

# Keep the Why: context/ as its own section of the docs, "Why this project is
# built this way" — the topic files and their index, rendered by myst like the
# README. README, AGENTS and CLAUDE are for the folder on GitHub, not pages.
# Build-only copy, ignored by git (dev/sphinx/source/context/ in .gitignore).
rm -rf dev/sphinx/source/context
mkdir -p dev/sphinx/source/context
cp context/*.md dev/sphinx/source/context/
rm -f dev/sphinx/source/context/README.md dev/sphinx/source/context/AGENTS.md dev/sphinx/source/context/CLAUDE.md
# The index's 0-9/A-Z skeleton headings are for the file, not for the docs'
# table of contents: list the page by its title only.
printf -- '---\ntocdepth: 1\n---\n' | cat - dev/sphinx/source/context/index.md > dev/sphinx/source/context/index.md.tmp
mv dev/sphinx/source/context/index.md.tmp dev/sphinx/source/context/index.md

mkdir -p dev/sphinx/build

cd dev/sphinx
rm -f build/html
ln -sf ../../../docs build/html
make html -d
echo "Creating CNAME file for GitHub."
echo "oliver-zehentleitner.github.io" > build/html/CNAME
