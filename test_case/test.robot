*** Settings ***
Documentation     测试
Resource          ../model/init_.robot

*** Variables ***
${url}            ''    # 初始url

*** Test Cases ***
初始化登录页面
    Log    ${url}
    run keyword if    ${USE_DEV}==1    修改dev设置
    ...    ELSE    修改生产设置
    Log    ${url}
    打开浏览器    ${url}
    run keyword if    ${USE_DEV}==1    设置hb_dev_host

*** Keywords ***
修改dev设置
    Set Test Variable    ${url}    ${DEVTEAM_PROXY_URL}
    Log    ${url}

修改生产设置
    Set Test Variable    ${url}    ${PRODUCTION_SERVER}
    Log    ${url}
