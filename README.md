# hermes-sandbox-image

Customised sandbox image for the Hermes agent on rpi5-0.

The image adds the tools the agent reaches for from a shell to the upstream
`nousresearch/hermes-sandbox:desktop` image, pinned by its arm64 digest.

The repo and package currently live under `slopervisor`; they move to `maciej-makowski`
in a later transfer.

## What it adds

- Debian packages: gh, ffmpeg, poppler-utils, sqlite3, shellcheck, age, zstd, cmake, pandoc.
- Python packages: pytest, ruff, mypy, pymupdf, cairosvg.
- A self-check at `/usr/local/bin/sandbox-selfcheck`.

The upstream entrypoint, the `pn` user (uid 1000), and the display stack are unchanged.
No credentials live in the image. `gh` reads its auth from `~/.config/gh` on the mounted home.

## Build locally

```bash
podman build --platform linux/arm64 \
  --build-arg UPSTREAM_REF=docker.io/nousresearch/hermes-sandbox@<arm64 digest> \
  --build-arg UPSTREAM_DIGEST=<arm64 digest> \
  -t localhost/hermes-sandbox:test .
podman run -d --name sbx localhost/hermes-sandbox:test
podman exec -u pn sbx sandbox-selfcheck
podman rm -f sbx
```

The digest is the arm64 child of the Docker Hub `desktop` tag, not the manifest-list digest.

## Publish

The workflow builds on `ubuntu-24.04-arm`, reads the Docker Hub arm64 digest, builds only
when it moves, runs the self-check, and moves `latest` only after the check passes.
Tags: `latest`, `sha-<12>`, `date-YYYYMMDD`, `upstream-<digest12>`.

The GHCR package must be public once, or the Pi cannot pull it anonymously.

## Use on rpi5-0

`terminal.docker_image` points at the image digest. The Pi timer
(`hermes-sandbox-update.timer`) pulls `latest`, runs the self-check, pins the digest,
restarts the gateway, and rolls back if the gateway does not come up.

## Roll back

Read `~/.hermes/sandbox-image.state`. Set `terminal.docker_image` to `previous`, or to
`active` when `previous` is empty, then restart the gateway.

## Licence

MIT. See `LICENSE`.
