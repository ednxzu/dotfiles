#! /bin/bash

install_trufflehog() {
  # renovate: datasource=github-tags depName=trufflesecurity/trufflehog
  TRUFFLEHOG_VERSION="3.90.2"
  TRUFFLEHOG_TMP_TAR="/tmp/trufflehog.tar.gz"
  TRUFFLEHOG_TMP_DIR="/tmp/trufflehog"
  TRUFFLEHOG_INSTALL_BIN="${LOCAL_INSTALL_DIR}/trufflehog"

  require_command curl
  require_command tar
  require_command mv
  require_command chmod
  require_command rm
  require_command mkdir

  install_start "trufflehog" "${TRUFFLEHOG_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${TRUFFLEHOG_TMP_TAR}\" \
    \"https://github.com/trufflesecurity/trufflehog/releases/download/v${TRUFFLEHOG_VERSION}/trufflehog_${TRUFFLEHOG_VERSION}_linux_amd64.tar.gz\""
  run_cmd "mkdir -p \"${TRUFFLEHOG_TMP_DIR}\""
  run_cmd "tar -zxvf \"${TRUFFLEHOG_TMP_TAR}\" -C \"${TRUFFLEHOG_TMP_DIR}\""
  run_cmd "mv \"${TRUFFLEHOG_TMP_DIR}/trufflehog\" \"${TRUFFLEHOG_INSTALL_BIN}\""
  run_cmd "chmod +x \"${TRUFFLEHOG_INSTALL_BIN}\""
  run_cmd "rm -rf \"${TRUFFLEHOG_TMP_TAR}\" \"${TRUFFLEHOG_TMP_DIR}\""

  install_end "trufflehog" "${TRUFFLEHOG_INSTALL_BIN} --version"
}
