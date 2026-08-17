#!/bin/bash

set -euo pipefail

fail() {
    printf '%s\n' "$1" >&2
    exit 1
}

readonly required_files=(
    "index.html"
    "styles.css"
    "assets/macpad-logo.png"
    "assets/macpad-desktop.png"
    "assets/macpad-mobile-icon.png"
    "assets/macpad-mobile-iphone.png"
    "assets/macpad-mobile-ipad.png"
)

for required_file in "${required_files[@]}"; do
    if [[ ! -f "$required_file" ]]; then
        fail "Required site file is missing: $required_file"
    fi
done

if find . -type f -name '*.js' -print -quit | grep -q '.'; then
    fail 'JavaScript files are not allowed.'
fi

if grep -Eni '<script|<iframe|<object|<embed' index.html; then
    fail 'Remote or executable embeds are not allowed.'
fi

if grep -Eni '<(img|link)[^>]+(src|href)="https?://' index.html; then
    fail 'Images and stylesheets must be served locally.'
fi

if grep -Eni 'google-analytics|googletagmanager|segment\.com|mixpanel|cookie banner' index.html styles.css; then
    fail 'Analytics and cookie integrations are not allowed.'
fi

if grep -En '/Users/|file://|DEVELOPMENT_TEAM|PROVISIONING_PROFILE|[A-Z0-9]{10}' index.html styles.css README.md; then
    fail 'Personal paths or signing identifiers are not allowed.'
fi

grep -Eq '<main[ >]' index.html || fail 'A semantic main landmark is required.'
grep -Eq '<h1[ >]' index.html || fail 'A page-level heading is required.'
grep -Fq 'href="#main-content"' index.html || fail 'A skip link is required.'
grep -Eq 'alt="[^"].*"' index.html || fail 'Descriptive image alternatives are required.'
grep -Fq 'https://github.com/anvilfilbert/MacPad/releases/latest' index.html || fail 'MacPad release link is missing.'
grep -Fq 'https://github.com/anvilfilbert/MacPad-Mobile#install-locally-with-xcode' index.html || fail 'MacPad Mobile installation link is missing.'
grep -Fq ':focus-visible' styles.css || fail 'Visible keyboard focus styling is required.'
grep -Fq 'prefers-reduced-motion' styles.css || fail 'Reduced-motion styling is required.'

printf 'MacPad family site validation passed.\n'
