#!/usr/bin/env bash
set -euo pipefail

install_uv_tools() {
    echo "[UV-TOOLS] Installing uv tools..."

    uv tool install ansible-lint \
        --with ansible-core

    uv tool install python-openstackclient \
        --with osc-placement \
        --with python-barbicanclient \
        --with python-ceilometerclient \
        --with python-cinderclient \
        --with python-cloudkittyclient \
        --with python-cyborgclient \
        --with python-designateclient \
        --with python-glanceclient \
        --with python-heatclient \
        --with python-ironicclient \
        --with python-keystoneclient \
        --with python-magnumclient \
        --with python-manilaclient \
        --with python-masakariclient \
        --with python-mistralclient \
        --with python-neutronclient \
        --with python-novaclient \
        --with python-octaviaclient \
        --with python-swiftclient \
        --with python-troveclient \
        --with python-zunclient \
        --with openstacksdk \
        --with aodhclient \
        --with gnureadline

    echo "[UV-TOOLS] Done!"
}
