#! /bin/bash

install_uv() {
  # renovate: datasource=github-releases depName=astral-sh/uv
  UV_VERSION="0.8.19"
  UV_INSTALL_BIN="${LOCAL_INSTALL_DIR}/uv"

  require_command curl

  install_start "uv" "${POETRY_VERSION}"

  run_cmd "curl -LsSf https://astral.sh/uv/${UV_VERSION}/install.sh | sh"

  install_end "uv" "${UV_INSTALL_BIN} --version"
}
