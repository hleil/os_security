#!/bin/bash

# ------------------------------------
# Source script lib
# ------------------------------------
. "$(dirname $0)/lib/ngx-script-lib.sh"

# ------------------------------------
# Only install when you choose to install "OWASP" rules
# ------------------------------------
[[ "${PARAM_WAF_RULES}" != "OWASP" ]] && eval "${SKIP_SCRIPT}"

# ------------------------------------
# Define and check app version
# ------------------------------------
# App version
# PARAM_OWASP_CRS_VER : defined in cfg file

# Check app version
check_app "owasp-crs" "${PARAM_OWASP_CRS_VER}"
check_app_run  # Comment this line, to avoid check app version , always execute this script

# ------------------------------------

start_script
# ***********************************************************************************************************
# ------------------------------------
# Start
# ------------------------------------

# Install SpiderLabs/owasp-modsecurity-crs....
# OWASP CRS info
OWASP_CRS_URL="https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/${PARAM_OWASP_CRS_VER}.tar.gz"
OWASP_CRS_PATH="${THIS_PATH_TMP}/owasp-modsecurity-crs-*/rules"

# Start to setup owasp rules
wget $OWASP_CRS_URL -O - | tar -xz

echo 
echo ">>>>>>>>>>>>>>>"
echo "rm -f ${PARAM_OWASP_RULES_PATH}/* ....!"
echo 
rm -f ${PARAM_OWASP_RULES_PATH}/*

echo 
echo ">>>>>>>>>>>>>>>"
echo "Copy owasp-modsecurity-crs-*/rules/* ---> ${PARAM_OWASP_RULES_PATH}/ ....!"
echo 
\cp -f ${OWASP_CRS_PATH}/* ${PARAM_OWASP_RULES_PATH}/

echo "Done ...!"
echo 

# ***********************************************************************************************************

# ------------------------------------
# Stop
# ------------------------------------
stop_script