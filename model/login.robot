*** Settings ***
Documentation     登录相关操作
Resource          ../config/env_conf.robot
Resource          ../config/test_conf.robot
Resource          ../pages/登录页.robot

*** Keywords ***
用户名密码登录
    [Arguments]    ${username}    ${password}    # 用户名密码
    Input Text    ${用户名输入框}    ${username}
    Input text    ${密码输入框}    ${password}
    click button    ${登录按钮}
    sleep    ${SLEEP_TIME_SHORT}
    wait until element is not visible    ${登录错误div}    ${SLEEP_TIME_SHORT}    登录错误
    wait until element is visible    ${用户图标}    ${SLEEP_TIME_LONG}
退出登录
    Click Element    ${用户图标}
    Click Link    ${退出按钮}
    Wait Until Element Is Visible    ${用户名输入框}    ${SLEEP_TIME_LONG}