#! /bin/bash

install_age() {
  # renovate: datasource=github-tags depName=FiloSottile/age
  AGE_VERSION="v1.2.1"
  AGE_TMP_TAR="/tmp/age.tar.gz"
  AGE_TMP_DIR="/tmp/age"
  AGE_BIN_PATH="${LOCAL_INSTALL_DIR}/age"
  AGE_KEYGEN_PATH="${LOCAL_INSTALL_DIR}/age-keygen"

  require_command curl
  require_command tar
  require_command mv
  require_command chmod
  require_command rm

  install_start "age" "${AGE_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${AGE_TMP_TAR}\" \"https://dl.filippo.io/age/${AGE_VERSION}?for=linux/amd64\""
  run_cmd "tar -zxvf \"${AGE_TMP_TAR}\" -C /tmp"
  run_cmd "mv \"${AGE_TMP_DIR}/age\" \"${AGE_BIN_PATH}\""
  run_cmd "mv \"${AGE_TMP_DIR}/age-keygen\" \"${AGE_KEYGEN_PATH}\""
  run_cmd "chmod +x \"${AGE_BIN_PATH}\""
  run_cmd "chmod +x \"${AGE_KEYGEN_PATH}\""
  run_cmd "rm -rf \"${AGE_TMP_TAR}\" \"${AGE_TMP_DIR}\""

  install_end "age" "${AGE_BIN_PATH} --version"
  install_end "age-keygen" "${AGE_KEYGEN_PATH} --version"
}
