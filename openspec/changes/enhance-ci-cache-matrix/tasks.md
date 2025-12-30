## 1. Implementation
- [ ] Modify `.github/workflows/ci.yml` to add `actions/cache` for `renv` library.
- [ ] Add macOS runner to the job matrix and optionally multiple R versions.
- [ ] Validate cache keys use `renv.lock` hash to invalidate properly.

## 2. Review
- [ ] Monitor CI runtimes and ensure cache hits improve speed.
