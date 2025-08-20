#! /bin/bash

install_helm() {
  # renovate: datasource=github-tags depName=helm/helm
  HELM_VERSION="v3.18.4"
  HELM_TMP_TAR="/tmp/helm-${HELM_VERSION}-linux-amd64.tar.gz"
  HELM_TMP_DIR="/tmp/linux-amd64"
  HELM_INSTALL_PATH="${LOCAL_INSTALL_DIR}/helm"
  HELM_COMPLETION_PATH="${LOCAL_COMPLETION_DIR}/helm"

  require_command curl
  require_command tar
  require_command mv
  require_command chmod
  require_command rm

  install_start "Helm" "${HELM_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${HELM_TMP_TAR}\" \"https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz\""
  run_cmd "tar -zxvf \"${HELM_TMP_TAR}\" -C /tmp"
  run_cmd "mv \"${HELM_TMP_DIR}/helm\" \"${HELM_INSTALL_PATH}\""
  run_cmd "chmod +x \"${HELM_INSTALL_PATH}\""
  run_cmd "rm -rf \"${HELM_TMP_TAR}\" \"${HELM_TMP_DIR}\""

  install_end "Helm" "\"${HELM_INSTALL_PATH}\" version --short"

  # Install bash completion to local completion dir
  if [[ -n "${LOCAL_COMPLETION_DIR}" && -d "${LOCAL_COMPLETION_DIR}" ]]; then
    "${HELM_INSTALL_PATH}" completion bash >"${HELM_COMPLETION_PATH}"
  fi
}
