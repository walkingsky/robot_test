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




测试5（进入《仪表盘》工作区）
    Sleep    10
    按工作区名称点击进入    《仪表盘》
    #遍历工作区可见导航
    切换到指定导航    表格与动态

测试6
    ${r}=    Run Keyword    按名称验证表格是否为反向同步表    微信报名
    Log    ${r}
    ${r}=    Run Keyword    按名称验证表格是否为反向同步表    new
    Log    ${r}

测试7
    ${r}=    Run Keyword    按名称验证表格是否存在或可见    asdfsdf
    Log    ${r}


测试8
    ${r}=    Run Keyword    查看表格是否有管理菜单    微信报名
    Log    ${r}
    ${r}=    Run Keyword    查看表格是否可以被拖动    微信报名
    Log    ${r}

测试9（进入权限测试工作区工作区）
    Sleep    10
    按工作区名称点击进入    权限测试工作区
    #按工作区名称点击进入    招小伙伴
    #遍历工作区可见导航
    切换到指定导航    表格与动态

测试10
    ${r}=    Run Keyword    查看表格是否有管理菜单    测试表1
    Log    ${r}
    ${r}=    Run Keyword    查看表格是否可以被拖动    未命名表格
    Log    ${r}
    ${r}=    Run Keyword    查看表格是否有管理菜单    面试安排
    Log    ${r}
    ${r}=    Run Keyword    查看表格是否可以被拖动    面试安排
    Log    ${r}

测试11（退出登录）
    收起工作区列表
    Sleep    ${SLEEP_TIME_LONG}
    退出登录