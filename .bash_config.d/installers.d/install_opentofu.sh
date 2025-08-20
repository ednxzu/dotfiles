#! /bin/bash

install_opentofu() {
  require_command curl
  require_command chmod

  # renovate: datasource=github-releases depName=opentofu/opentofu
  OPENTOFU_VERSION=v1.10.3
  OPENTOFU_VERSION_STRIPPED=${OPENTOFU_VERSION#v}

  install_start "opentofu" "${OPENTOFU_VERSION}"

  run_cmd "curl --silent --fail -Lo /tmp/install-opentofu.sh https://get.opentofu.org/install-opentofu.sh"
  run_cmd "chmod +x /tmp/install-opentofu.sh"

  run_cmd "/tmp/install-opentofu.sh --install-method standalone --opentofu-version ${OPENTOFU_VERSION_STRIPPED} --symlink-path ${GLOBAL_INSTALL_DIR}"

  rm -rf /tmp/install-opentofu.sh /tmp/tmp.*
  install_end "OpenTofu" "${GLOBAL_INSTALL_DIR}/tofu --version"

  if [[ -n "${USER_HOME}" && -d "${USER_HOME}" ]]; then
    echo "complete -C ${GLOBAL_INSTALL_DIR}/tofu tofu" > "${LOCAL_COMPLETION_DIR}/tofu"
  fi
}
