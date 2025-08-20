#! /bin/bash

install_task() {
  # renovate: datasource=github-tags depName=go-task/task
  TASK_VERSION="v3.44.1"
  TASK_TMP_TAR="/tmp/task.tar.gz"
  TASK_TMP_DIR="/tmp/task"
  TASK_INSTALL_BIN="${LOCAL_INSTALL_DIR}/task"

  require_command curl
  require_command tar
  require_command mv
  require_command chmod
  require_command rm
  require_command mkdir

  install_start "task" "${TASK_VERSION}"

  run_cmd "curl --silent --fail -Lo \"${TASK_TMP_TAR}\" \"https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz\""
  run_cmd "mkdir -p \"${TASK_TMP_DIR}\""
  run_cmd "tar -zxvf \"${TASK_TMP_TAR}\" -C \"${TASK_TMP_DIR}\""
  run_cmd "mv \"${TASK_TMP_DIR}/task\" \"${TASK_INSTALL_BIN}\""
  run_cmd "chmod +x \"${TASK_INSTALL_BIN}\""
  run_cmd "rm -rf \"${TASK_TMP_TAR}\" \"${TASK_TMP_DIR}\""

  install_end "task" "${TASK_INSTALL_BIN} --version"

  run_cmd "mkdir -p \"${LOCAL_COMPLETION_DIR}\""
  run_cmd "${TASK_INSTALL_BIN} --completion bash > \"${LOCAL_COMPLETION_DIR}/task\""
}
