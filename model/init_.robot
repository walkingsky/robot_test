*** Settings ***
Documentation     初始化文件(该文件变量作用范围理解的有问题，无法正常使用)
Resource          ../config/env_conf.robot
Resource          ../config/test_conf.robot

*** Keywords ***
打开浏览器
    [Arguments]    ${url}
    Log    ${url}
    Run Keyword If    ${USE_HEADLESS} == 1    打开无窗口模式浏览器    ${url}
    ...    ELSE    打开窗口模式浏览器    ${url}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Run Keyword If    ${USE_DEV} == 1    设置hb_dev_host
    [Teardown]    Close Browser

打开窗口模式浏览器
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}

打开无窗口模式浏览器
    [Arguments]    ${url}
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    ${options}=    Call Method    ${chrome_options}    to_capabilities
    #
    Open Browser    ${url}    ${BROWSER}    desired_capabilities=${options}

设置hb_dev_host
    sleep    ${SLEEP_TIME_SHORT}
    #打开http://devteam.huoban.com 设置cookie
    Click Element    id=hostPre-${hb_dev_host}
    Click Button    tag:button
    sleep    ${SLEEP_TIME_SHORT}
    #新开窗口
    Execute JavaScript    window.open('${DEV_SERVER}');
