#! /bin/bash

install_sops() {
  # renovate: datasource=github-releases depName=getsops/sops
  SOPS_VERSION="v3.10.2"
  SOPS_BIN_NAME="sops-${SOPS_VERSION}.linux.amd64"
  SOPS_TMP_PATH="/tmp/${SOPS_BIN_NAME}"
  SOPS_INSTALL_PATH="${LOCAL_INSTALL_DIR}/sops"

  require_command curl
  require_command mv
  require_command chmod

  install_start "SOPS" "${SOPS_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${SOPS_TMP_PATH}\" \"https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/${SOPS_BIN_NAME}\""
  run_cmd "mv \"${SOPS_TMP_PATH}\" \"${SOPS_INSTALL_PATH}\""
  run_cmd "chmod +x \"${SOPS_INSTALL_PATH}\""

  install_end "SOPS" "${SOPS_INSTALL_PATH} --version --check-for-updates"
}
