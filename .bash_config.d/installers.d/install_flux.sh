#! /bin/bash

install_flux() {
  # renovate: datasource=github-releases depName=fluxcd/flux2
  FLUX_VERSION="2.6.4"
  FLUX_TMP_TAR="/tmp/flux_${FLUX_VERSION}_linux_amd64.tar.gz"
  FLUX_TMP_BIN="/tmp/flux"
  FLUX_INSTALL_PATH="${LOCAL_INSTALL_DIR}/flux"

  require_command curl
  require_command tar
  require_command mv
  require_command rm

  install_start "Flux" "${FLUX_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${FLUX_TMP_TAR}\" \"https://github.com/fluxcd/flux2/releases/download/v${FLUX_VERSION}/flux_${FLUX_VERSION}_linux_amd64.tar.gz\""
  run_cmd "tar -zxvf \"${FLUX_TMP_TAR}\" -C /tmp"
  run_cmd "mv \"${FLUX_TMP_BIN}\" \"${FLUX_INSTALL_PATH}\""
  run_cmd "rm -rf \"${FLUX_TMP_TAR}\""

  install_end "Flux" "${FLUX_INSTALL_PATH} --version"

  # Install bash completion if possible
  if [[ -n "${LOCAL_COMPLETION_DIR}" && -d "${LOCAL_COMPLETION_DIR}" ]]; then
    "${FLUX_INSTALL_PATH}" completion bash >"${LOCAL_COMPLETION_DIR}/flux"
  fi
}
