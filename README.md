# MacPad family website

Official static website for [MacPad](https://github.com/anvilfilbert/MacPad)
and [MacPad Mobile](https://github.com/anvilfilbert/MacPad-Mobile), published at
<https://anvilfilbert.github.io/>.

Product capabilities, releases, installation instructions, support guidance,
and security policies remain canonical in the individual application
repositories. This site provides a concise shared introduction and links to
those sources.

## Local preview

Validate the repository:

```sh
./scripts/validate-site.sh
```

Serve it locally:

```sh
python3 -m http.server 8000
```

Then open <http://localhost:8000/>.

## License

Site source code and documentation are licensed under the
[Apache License 2.0](LICENSE), unless a file states otherwise.

The license does not cover the MacPad or MacPad Mobile names, logos, app icons,
screenshots, social-preview artwork, or other branding and artwork. Those
assets remain all rights reserved unless separately licensed. Apache-2.0 does
not grant trademark rights.
