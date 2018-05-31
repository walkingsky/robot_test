*** Settings ***
Documentation     按照test suite来分配测试用例（较合理的方案）
Suite Setup       
Suite Teardown    Close Browser
Test Setup
Test Teardown
Resource          ../model/init.robot
Resource          ../model/login.robot
Resource          ../model/工作区操作.robot

*** Test Cases ***
初始化
    打开登录页

测试1（登录）
    用户名密码登录    username    password
    #检查系统弹层通知
    Sleep    5
    检查系统弹层通知    True

测试2（获取当前企业数量）
    展开工作区列表
    ${count}=    获取当前用户企业数量
    Log    获取当前用户企业数量${count}

测试3（获取企业工作区 数量）
    ${count2}=    获取当前用户企业工作区数量
    Log    获取当前用户企业工作区数量${count2}

测试4（获取当前用户工作区数量）
    ${count3}=   获取当前用户工作区数量
    Log    获取当前用户工作区数量${count3}

测试5（进入源数据表格工作区）
    按工作区名称点击进入    源数据表格

#测试6（遍历工作区）
#    遍历所有工作区

测试7（退出登录）
    收起工作区列表
    Sleep    ${SLEEP_TIME_LONG}
    退出登录