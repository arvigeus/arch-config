---
description: Generate a Conventional Commits–style message from the current git diff using our team spec, then commit
argument-hint: "[optional summary or scope]"
model: claude-haiku-4-5-20251001
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(git add:*)
---

# Context (auto-collected)

- Current branch: !`git branch --show-current`
- Recent commits (last 5): !`git log --oneline -5`
- Git status: !`git status --porcelain=v1`
- Diff vs HEAD (staged & unstaged): !`git diff HEAD`

# Task

1. Using the context above, generate a commit message following the **Commit Message Spec** below
2. Stage all changes with `git add -A`
3. Commit with the generated message

If `$ARGUMENTS` are provided, treat them as hints for `scope` and/or the short summary.

Prefer one clear commit over many. If multiple logical changes are detected, warn the user but proceed with the best single commit message possible.

---

## Commit Message Spec (enforced)

### 1) Format

    <type>(<scope>)!?: <Imperative summary, ≤50 chars>

    [Body: what & why, wrapped at 72 chars]

    [Footer(s): metadata like issues, BREAKING CHANGE]

- **type** (one): feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- **scope** (optional, kebab-case): e.g. auth, api, ui, deps, infra
- **!** (optional): indicates a breaking change in the subject line

### 2) Subject (Top Line)

- Imperative mood ("Add", not "Added"/"Adds")
- ≤50 chars, capitalized, no trailing period
- One blank line after the subject

### 3) Body (Explain What & Why)

- Wrap at 72 chars
- Focus on **what changed** and **why** (not the how)
- Mention user impact, trade-offs, and relevant context
- Include migration notes if behavior changes

**Body checklist**

- Motivation / context
- What changed at a high level
- Impact / risks / rollback notes

### 4) Footers (Metadata)

- Closes #123 / Fixes #123 / Refs #123
- BREAKING CHANGE: <details + migration>
- Co-authored-by: Name <email>
- Signed-off-by: Name <email> (if DCO)

**Breaking changes**

- Use **!** in the subject **or** a BREAKING CHANGE: footer (or both)
- State what breaks and how to migrate

### 5) SemVer Mapping

- **feat** → **minor**
- **fix** → **patch**
- **feat!** or **BREAKING CHANGE** → **major**

### 6) Examples

Good:

    feat(auth): add password reset endpoint

    Adds POST /reset-password to allow email-based token resets.
    Sends time-limited tokens and invalidates on use.

    Closes #482

---

    fix(ui): prevent sidebar overflow on Safari 17

    Use flex-basis and min-width to avoid text clipping on narrow
    viewports.

    Refs #519

---

    docs(readme): add installation instructions for pnpm

---

    feat(api)!: require auth token for all POST routes

    All POST routes now validate JWTs. Anonymous writes removed.

    BREAKING CHANGE: Clients must include Authorization: Bearer <jwt>.

Revert:

    revert: feat(auth): add password reset endpoint

    Reverts commit abc1234 due to regression in SSO flow.

---

## Heuristics the assistant should apply

- Infer **type** from changes (tests → test, perf-sensitive code → perf, only deps → build or chore(deps))
- Prefer a concrete **scope** when files cluster clearly (e.g., directory or package name)
- If diff shows widespread API changes, consider ! and describe migration in the body/footer
- Keep subject ≤50 chars; if longer, tighten language without losing meaning
- If an issue key like #123 appears in diff, include a footer reference

---

## Execution Steps

After generating the commit message:

1. Execute: git add -A
2. Execute: git commit -m "<generated message>"
4. Show the commit message that was used and report success/failure of each step

