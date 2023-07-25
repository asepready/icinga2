#!/bin/bash
ICINGAWEB_MODULEPATH="/usr/share/icingaweb2/modules"
REPO_URL="https://github.com/icinga/icingaweb2-module-director"
TARGET_DIR="${ICINGAWEB_MODULEPATH}/director"
MODULE_VERSION="1.7.2"
git clone "${REPO_URL}" "${TARGET_DIR}" --branch v${MODULE_VERSION}
MODULE_NAME=incubator
MODULE_VERSION=v0.5.0
REPO="https://github.com/Icinga/icingaweb2-module-${MODULE_NAME}"
MODULES_PATH="/usr/share/icingaweb2/modules"
git clone ${REPO} "${MODULES_PATH}/${MODULE_NAME}" --branch "${MODULE_VERSION}"
icingacli module enable "${MODULE_NAME}"
MODULE_NAME=ipl
MODULE_VERSION=v0.5.0
REPO="https://github.com/Icinga/icingaweb2-module-${MODULE_NAME}"
MODULES_PATH="/usr/share/icingaweb2/modules"
git clone ${REPO} "${MODULES_PATH}/${MODULE_NAME}" --branch "${MODULE_VERSION}"
icingacli module enable "${MODULE_NAME}"
MODULE_NAME=reactbundle
MODULE_VERSION=v0.7.0
REPO="https://github.com/Icinga/icingaweb2-module-${MODULE_NAME}"
MODULES_PATH="/usr/share/icingaweb2/modules"
git clone ${REPO} "${MODULES_PATH}/${MODULE_NAME}" --branch "${MODULE_VERSION}"
icingacli module enable "${MODULE_NAME}"