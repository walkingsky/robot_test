*** Settings ***
Documentation     初始化文件（正式初始化文件）
Resource          ../config/env_conf.robot
Resource          ../config/test_conf.robot
Resource          ../pages/登录页.robot

*** Variables ***
${server_temp}    123123    # server的临时存储
${server_devteam}    'http://devteam.huoban.com/proxy.php'

*** Keywords ***
打开登录页

    Run Keyword If    ${USE_DEV} == 1    修改dev设置
    ...    ELSE    修改生产设置
    Run Keyword If    ${USE_HEADLESS} == 1    打开无窗口模式浏览器    ${server_temp}
    ...    ELSE    打开窗口模式浏览器    ${server_temp}
    Maximize Browser Window    #chrome driver无窗口模式下不起作用
    Set Window Size    1600    800    #特意为webdriver无窗口模式下添加的设置窗口大小操作
    #Capture Page Screenshot 
    Set Selenium Speed    ${DELAY}
    Run Keyword If    ${USE_DEV} == 1    设置hb_dev_host    
    Title Should Be    ${登录页的title}
    Location Should Contain  ${LOGIN PGAE URL}

打开窗口模式浏览器
    [Arguments]    ${url}
    Open Browser    ${url}    ${BROWSER}

打开无窗口模式浏览器
    [Arguments]    ${url}
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    start-maximized
    #Call Method    ${chrome_options}    add_argument    window-size=1600,800
    ${options}=    Call Method    ${chrome_options}    to_capabilities
    #
    Open Browser    ${url}    ${BROWSER}    desired_capabilities=${options}

设置hb_dev_host
    sleep    ${SLEEP_TIME_SHORT}
    #打开http://devteam.huoban.com 设置cookie
    Click Element    id=hostPre-${hb_dev_host}
    Click Button    tag:button
    sleep    ${SLEEP_TIME_LONG}
    #新开窗口
    #Execute JavaScript    window.open('${DEV_SERVER}');
    Goto    ${DEV_SERVER}
    sleep    ${SLEEP_TIME_SHORT}


修改dev设置
    Set Test Variable    ${server_temp}    ${DEVTEAM_PROXY_URL}
    Log    ${server_temp}

修改生产设置
    Set Test Variable    ${server_temp}    ${PRODUCTION_SERVER}
    Log    ${server_temp}