*** Settings ***
Documentation     测试
Test Setup        打开登录页
Test Teardown     Close Browser
Resource          ../model/init.robot
Resource          ../model/login.robot
Resource          ../model/工作区操作.robot

*** Test Cases ***
测试
    用户名密码登录    username    password
    展开工作区列表
    ${count}=    获取当前用户企业数量
    Log    获取当前用户企业数量${count}
    ${count2}=    获取当前用户企业工作区数量
    Log    获取当前用户企业工作区数量${count2}
    ${count3}=   获取当前用户工作区数量
    Log    获取当前用户工作区数量${count3} 
    按工作区名称点击进入    123    
    遍历所有工作区
    收起工作区列表
    Sleep    ${SLEEP_TIME_LONG}
    退出登录