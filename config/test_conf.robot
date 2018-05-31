*** Settings ***
Documentation     环境设置变量设置文档

*** Variables ***
#正式生产环境
${PRODUCTION_SERVER}    https://app.huoban.com/
#开发环境
${DEV_HOST}       116.62.36.163
${DEV_PORT}       8989
${DEV_SERVER}     http://${DEV_HOST}:${DEV_PORT}/
#SERVER
${SERVER}         ${PRODUCTION_SERVER}
${DEVTEAM_PROXY_URL}         http://devteam.huoban.com/proxy.php
${SLEEP_TIME_SHORT}    3
${SLEEP_TIME_LONG}    13