#! /bin/bash

install_kubectl() {
  # renovate: datasource=github-tags depName=kubernetes/kubernetes
  KUBECTL_VERSION="v1.33.3"
  KUBECTL_TMP_BIN="/tmp/kubectl"
  KUBECTL_INSTALL_PATH="${LOCAL_INSTALL_DIR}/kubectl"
  KUBECTL_COMPLETION_PATH="${LOCAL_COMPLETION_DIR}/kubectl"

  require_command curl
  require_command mv
  require_command chmod

  install_start "kubectl" "${KUBECTL_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${KUBECTL_TMP_BIN}\" \"https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl\""
  run_cmd "mv \"${KUBECTL_TMP_BIN}\" \"${KUBECTL_INSTALL_PATH}\""
  run_cmd "chmod +x \"${KUBECTL_INSTALL_PATH}\""

  install_end "kubectl" "\"${KUBECTL_INSTALL_PATH}\" version --client"

  # Install bash completion to local completion dir
  if [[ -n "${LOCAL_COMPLETION_DIR}" && -d "${LOCAL_COMPLETION_DIR}" ]]; then
    "${KUBECTL_INSTALL_PATH}" completion bash >"${KUBECTL_COMPLETION_PATH}"
  fi
}
