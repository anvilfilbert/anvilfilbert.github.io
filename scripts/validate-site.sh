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

if find . -type f -name '*.js' -print -quit | rg -q '.'; then
    fail 'JavaScript files are not allowed.'
fi

if rg -n -i '<script|<iframe|<object|<embed' index.html; then
    fail 'Remote or executable embeds are not allowed.'
fi

if rg -n -i '<(img|link)[^>]+(src|href)="https?://' index.html; then
    fail 'Images and stylesheets must be served locally.'
fi

if rg -n -i 'google-analytics|googletagmanager|segment\.com|mixpanel|cookie banner' index.html styles.css; then
    fail 'Analytics and cookie integrations are not allowed.'
fi

if rg -n '/Users/|file://|DEVELOPMENT_TEAM|PROVISIONING_PROFILE|[A-Z0-9]{10}' index.html styles.css README.md; then
    fail 'Personal paths or signing identifiers are not allowed.'
fi

rg -q '<main[ >]' index.html || fail 'A semantic main landmark is required.'
rg -q '<h1[ >]' index.html || fail 'A page-level heading is required.'
rg -q 'href="#main-content"' index.html || fail 'A skip link is required.'
rg -q 'alt="[^"].*"' index.html || fail 'Descriptive image alternatives are required.'
rg -q 'https://github.com/anvilfilbert/MacPad/releases/latest' index.html || fail 'MacPad release link is missing.'
rg -q 'https://github.com/anvilfilbert/MacPad-Mobile#install-locally-with-xcode' index.html || fail 'MacPad Mobile installation link is missing.'
rg -q ':focus-visible' styles.css || fail 'Visible keyboard focus styling is required.'
rg -q 'prefers-reduced-motion' styles.css || fail 'Reduced-motion styling is required.'

printf 'MacPad family site validation passed.\n'
