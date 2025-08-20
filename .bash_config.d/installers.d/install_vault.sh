#! /bin/bash

install_vault() {
  # renovate: datasource=github-releases depName=hashicorp/vault
  VAULT_VERSION="v1.20.1"
  VAULT_VERSION_STRIPPED="${VAULT_VERSION#v}"
  VAULT_TMP_ZIP="/tmp/vault_${VAULT_VERSION_STRIPPED}_linux_amd64.zip"
  VAULT_TMP_DIR="/tmp/vault"
  VAULT_INSTALL_BIN="${LOCAL_INSTALL_DIR}/vault"

  require_command curl
  require_command unzip
  require_command mv
  require_command chmod
  require_command rm
  require_command mkdir

  install_start "vault" "${VAULT_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${VAULT_TMP_ZIP}\" \
    \"https://releases.hashicorp.com/vault/${VAULT_VERSION_STRIPPED}/vault_${VAULT_VERSION_STRIPPED}_linux_amd64.zip\""
  run_cmd "mkdir -p \"${VAULT_TMP_DIR}\""
  run_cmd "unzip -q \"${VAULT_TMP_ZIP}\" -d \"${VAULT_TMP_DIR}\""
  run_cmd "mv \"${VAULT_TMP_DIR}/vault\" \"${VAULT_INSTALL_BIN}\""
  run_cmd "chmod +x \"${VAULT_INSTALL_BIN}\""
  run_cmd "rm -rf \"${VAULT_TMP_ZIP}\" \"${VAULT_TMP_DIR}\""

  install_end "vault" "${VAULT_INSTALL_BIN} --version"

  if [[ -n "${USER_HOME}" && -d "${USER_HOME}" ]]; then
    echo "complete -C \"${VAULT_INSTALL_BIN}\" vault" >>"${USER_HOME}/.bashrc"
  fi
}
