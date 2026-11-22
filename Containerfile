# Customised Hermes sandbox: the upstream desktop image plus the tools the
# sessions actually needed. No Hermes code, no credentials.
ARG UPSTREAM_REF=docker.io/nousresearch/hermes-sandbox:desktop
FROM ${UPSTREAM_REF}

ARG UPSTREAM_DIGEST=unknown

LABEL org.opencontainers.image.title="hermes-sandbox-image"
LABEL org.opencontainers.image.source="https://github.com/slopervisor/hermes-sandbox-image"
LABEL org.opencontainers.image.base.name="docker.io/nousresearch/hermes-sandbox:desktop"
LABEL org.opencontainers.image.base.digest="${UPSTREAM_DIGEST}"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      gh ffmpeg poppler-utils sqlite3 shellcheck age zstd cmake pandoc \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir \
      pytest ruff mypy pymupdf cairosvg

COPY smoke.sh /usr/local/bin/sandbox-selfcheck
RUN chmod 0755 /usr/local/bin/sandbox-selfcheck

# No USER or ENTRYPOINT change: the upstream entrypoint and the pn user (uid 1000)
# stay exactly as the base built them.
