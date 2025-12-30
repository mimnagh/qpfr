# Change: Enhance CI to cache `renv` and run matrix (macOS + Ubuntu)

## Why
CI currently restores `renv` on every run; caching the package library and adding a macOS runner improves speed and confidence across platforms.

## What Changes
- Add caching for renv package library in GitHub Actions.
- Expand workflow to include macOS runner and optionally R 4.3/4.4 matrix.
- Ensure cached keys include OS and lockfile hash for correctness.

## Impact
- Files: `.github/workflows/ci.yml` (update).
- CI runtime: faster for successive runs, wider platform coverage.
