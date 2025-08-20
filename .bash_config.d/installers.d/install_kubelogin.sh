#! /bin/bash

install_kubelogin() {
  # renovate: datasource=github-releases depName=int128/kubelogin
  KUBELOGIN_VERSION="v1.34.1"
  KUBELOGIN_TMP_DIR="/tmp/kubelogin"
  KUBELOGIN_TMP_ZIP="${KUBELOGIN_TMP_DIR}/kubelogin.zip"
  KUBELOGIN_URL="https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin_linux_amd64.zip"
  KUBELOGIN_INSTALL_PATH="${LOCAL_INSTALL_DIR}/kubectl-oidc_login"

  require_command curl
  require_command unzip
  require_command mv
  require_command chmod
  require_command rm
  require_command mkdir

  install_start "kubelogin" "${KUBELOGIN_VERSION}"

  run_cmd "mkdir -p \"${KUBELOGIN_TMP_DIR}\""
  run_cmd "curl --silent --fail -Lo \"${KUBELOGIN_TMP_ZIP}\" \"${KUBELOGIN_URL}\""
  run_cmd "unzip -q \"${KUBELOGIN_TMP_ZIP}\" -d \"${KUBELOGIN_TMP_DIR}\""
  run_cmd "mv \"${KUBELOGIN_TMP_DIR}/kubelogin\" \"${KUBELOGIN_INSTALL_PATH}\""
  run_cmd "chmod +x \"${KUBELOGIN_INSTALL_PATH}\""
  run_cmd "rm -rf \"${KUBELOGIN_TMP_DIR}\""

  install_end "kubelogin" "${KUBELOGIN_INSTALL_PATH} --version"
}
