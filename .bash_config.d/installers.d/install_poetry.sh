#! /bin/bash

install_poetry() {
  # renovate: datasource=github-releases depName=python-poetry/poetry
  POETRY_VERSION="2.1.3"
  POETRY_INSTALL_BIN="${LOCAL_INSTALL_DIR}/poetry"

  require_command curl
  require_command python3
  require_command mkdir

  install_start "poetry" "${POETRY_VERSION}"

  run_cmd "curl -sSL https://install.python-poetry.org | python3 - --version \"${POETRY_VERSION}\""
  run_cmd "${POETRY_INSTALL_BIN} completions bash > \"${LOCAL_COMPLETION_DIR}/poetry\""

  install_end "poetry" "${POETRY_INSTALL_BIN} --version"
}
