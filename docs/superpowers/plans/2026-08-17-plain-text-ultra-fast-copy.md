# MacPad Family Positioning Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish one accurate positioning promise across MacPad, MacPad Mobile, their GitHub metadata, and the shared website.

**Architecture:** Treat the shared website as the family-level message and each repository as the platform-specific message. Keep operational, availability, privacy, download, and installation copy unchanged; only replace introductory positioning text.

**Tech Stack:** Static HTML, Markdown, shell validation, Git, GitHub CLI, GitHub Pages.

## Global Constraints

- Approved slogan: `Plain text. Ultra fast. No bloat.`
- Do not publish numerical performance claims without benchmark evidence.
- Preserve platform requirements, availability warnings, privacy statements, feature details, download links, and installation instructions.
- Do not imply synchronization between MacPad and MacPad Mobile.
- Use merge commits for pull requests.

---

### Task 1: Shared website positioning

**Files:**
- Modify: `index.html`
- Modify: `scripts/validate-site.sh`

**Interfaces:**
- Consumes: approved family slogan and existing product links.
- Produces: deployed family positioning at `https://anvilfilbert.github.io/`.

- [ ] **Step 1: Tighten the validator**

Add an exact assertion to `scripts/validate-site.sh`:

```sh
grep -Fq 'Plain text. Ultra fast. No bloat.' index.html || fail 'Approved family slogan is missing.'
```

- [ ] **Step 2: Run the validator to verify it fails**

Run: `./scripts/validate-site.sh`

Expected: failure `Approved family slogan is missing.`

- [ ] **Step 3: Update website copy**

Set the hero heading to `Plain text. Ultra fast. No bloat.` Update HTML title,
description, hero introduction, both product introductions, and footer so they
reinforce native plain-text speed without changing factual feature or
availability content.

- [ ] **Step 4: Validate website**

Run: `./scripts/validate-site.sh && git diff --check`

Expected: both commands succeed.

- [ ] **Step 5: Commit**

```sh
git add index.html scripts/validate-site.sh
git commit -m "Refresh MacPad family positioning"
```

### Task 2: MacPad repository positioning

**Files:**
- Modify: `/Users/fbauer/Documents/NotepadMac/README.md`

**Interfaces:**
- Consumes: platform-specific description from approved design.
- Produces: consistent opening copy for MacPad customers.

- [ ] **Step 1: Update README opening**

Replace the first product sentence with:

```markdown
Ultra-fast native plain-text editor for macOS. No bloat.
```

Add the shared website link to the family section if it is not already present.

- [ ] **Step 2: Verify README links and whitespace**

Run:

```sh
rg -n 'Ultra-fast native plain-text editor for macOS\. No bloat\.' README.md
rg -n 'https://anvilfilbert.github.io/' README.md
git diff --check
```

Expected: both phrases are found and diff check succeeds.

- [ ] **Step 3: Commit**

```sh
git add README.md
git commit -m "Refresh MacPad positioning"
```

### Task 3: MacPad Mobile repository positioning

**Files:**
- Modify: `/Users/fbauer/Documents/PhonePad/README.md`

**Interfaces:**
- Consumes: platform-specific description from approved design.
- Produces: consistent opening copy for MacPad Mobile customers.

- [ ] **Step 1: Update README opening**

Replace the first product sentence with:

```markdown
Ultra-fast native plain-text editor for iPhone and iPad. No bloat.
```

Keep the existing local-Xcode and availability sections unchanged.

- [ ] **Step 2: Verify README links and whitespace**

Run:

```sh
rg -n 'Ultra-fast native plain-text editor for iPhone and iPad\. No bloat\.' README.md
rg -n 'https://anvilfilbert.github.io/' README.md
git diff --check
```

Expected: both phrases are found and diff check succeeds.

- [ ] **Step 3: Commit**

```sh
git add README.md
git commit -m "Refresh MacPad Mobile positioning"
```

### Task 4: GitHub repository descriptions

**Files:**
- No repository files.

**Interfaces:**
- Consumes: approved platform descriptions.
- Produces: updated public GitHub About metadata.

- [ ] **Step 1: Update metadata through GitHub CLI**

```sh
gh repo edit anvilfilbert/MacPad --description "Ultra-fast native plain-text editor for macOS. No bloat."
gh repo edit anvilfilbert/MacPad-Mobile --description "Ultra-fast native plain-text editor for iPhone and iPad. No bloat."
```

- [ ] **Step 2: Verify metadata**

```sh
gh repo view anvilfilbert/MacPad --json description,homepageUrl
gh repo view anvilfilbert/MacPad-Mobile --json description,homepageUrl
```

Expected: descriptions match exactly and both homepage URLs are
`https://anvilfilbert.github.io/`.

### Task 5: Publish and clean up

**Files:**
- No additional files.

**Interfaces:**
- Consumes: verified commits from Tasks 1-3.
- Produces: merged repositories, deployed Pages site, and clean local state.

- [ ] **Step 1: Push branches and open pull requests**

Use `git push` and `gh pr create` for each repository. Do not combine unrelated
work or bypass failed checks.

- [ ] **Step 2: Merge green pull requests**

Use `gh pr merge --merge --delete-branch` after required checks pass.

- [ ] **Step 3: Verify deployment**

Run:

```sh
curl -fsSL https://anvilfilbert.github.io/ | rg -n 'Plain text\. Ultra fast\. No bloat\.'
```

Expected: deployed page contains the approved slogan.

- [ ] **Step 4: Clean temporary state**

Remove only clean merged worktrees and branches. Preserve any dirty legacy
worktree unless its recoverable backup is verified before removal.

- [ ] **Step 5: Report external blockers**

Leave paid Apple Developer membership, TestFlight upload, and any credential-
gated SourceForge metadata as explicit external blockers rather than claiming
completion.
