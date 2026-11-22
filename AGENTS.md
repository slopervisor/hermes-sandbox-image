# Agent rules

- Never push directly to `main`. Branch, push, open a PR.
- The agent may squash-merge its own PRs once the review loop passes and every required check is green. No separate ask-to-merge step.
- The review loop: a dedicated adversarial reviewer checks the diff against the design doc (`hermes-designs/hermes-sandbox-image-pipeline-design-final.md`) and the repo's own files. Fix every finding, including NITs, then re-review until zero.
- No secrets in the repo. The image carries no credentials; `gh` auth lives on the mounted home.
- The repo and package live under `slopervisor` until the planned transfer to `maciej-makowski`.
