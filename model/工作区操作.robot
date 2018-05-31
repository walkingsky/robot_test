*** Settings ***
Documentation     登录相关操作
Resource          ../config/env_conf.robot
Resource          ../config/test_conf.robot
Resource          ../pages/主工作页.robot

*** Variables ***
${count}          0    # 数量，内部临时变量

*** Keywords ***
获取当前用户企业数量
    ${count}=    Get Element Count    ${企业信息图标}
    [Return]    ${count}

获取当前用户企业工作区数量
    ${count}=    Get Element Count    ${企业工作区图标及企业名称}
    [Return]    ${count}

获取当前用户工作区数量
    ${count}=    Get Element Count    ${工作区名称}
    [Return]    ${count}

点击工作区列表按钮
    检查顶部是否有报错
    Click Element    ${切换工作区按钮}

展开工作区列表
    ${temp_result}=    Run Keyword And Return Status    Element Should Not Be Visible    ${企业工作区下拉图层}
    Run Keyword If    ${temp_result}    点击工作区列表按钮

收起工作区列表
    ${temp_result}=    Run Keyword And Return Status    Element Should Be Visible    ${企业工作区下拉图层}
    Run Keyword If    ${temp_result}    点击工作区列表按钮

按工作区名称点击进入
    [Arguments]    ${工作区名称}
    [Documentation]    按工作去名称点击进入工作区；
    ...    不需要再单独操作点击展开工作区列表；
    ...    只能点击第一个找到的工作区
    展开工作区列表
    #Focus    //h3[text()='${工作区名称}']/parent::div    #先定位焦点，看能够解决工作区列表多了后，在屏幕之外的工作区不能点击的问题
    ${垂直位置}=    Get Horizontal Position    //h3[text()='${工作区名称}']
    Run Keyword If    ${垂直位置}<-10 or ${垂直位置}>800    Execute Javascript    document.documentElement.scrollTop=${垂直位置}
    Click Element    //h3[text()='${工作区名称}']/../img    #本操作使用了xpath 以及 parent 向上查找的思路（h3标签可能不能接受click操作）
    #判断是否成功进入工作区
    Sleep    ${SLEEP_TIME_SHORT}
    ${result}=    Run Keyword And Return    检查当前工作区是否是参数指定的工作区    ${工作区名称}
    Run Keyword If    ${result}    Log    '成功进入工作区${工作区名称}'    Else    Log    '进入工作区${工作区名称}有点问题'

检查当前工作区是否是参数指定的工作区
    [Arguments]    ${工作区名称}
    ${result}=    Run Keyword And Return Status    Element Should Contain    ${工作区title}    ${工作区名称}
    [Return]    ${result}

遍历所有工作区
    展开工作区列表
    @{所有工作区} =    Get WebElements    ${工作区div}
    : FOR    ${工作区}    IN    @{所有工作区}
    \    Wait Until Element Is Visible    ${工作区}    ${SLEEP_TIME_SHORT}
    \    Click Element    ${工作区}
    \    Sleep    ${SLEEP_TIME_SHORT}
    \    ${title}=    Get text    ${工作区title}    #获取工作区名称
    \    Log    '成功进入工作区或企业：${title}'
    \    展开工作区列表
    Log    '遍历完成'

检查顶部是否有报错
    [Documentation]    系统级的操作，随时查看操作后是否有报错
    ${result}=    Run Keyword And Return Status    Element Should Not Be Visible    ${顶部错误信息的关闭按钮}
    Run Keyword Unless    ${result}    获得元素文本并记录LOG    ${顶部报错信息内容p元素}
    Run Keyword Unless    ${result}    Wait Until Element Is Not Visible    ${顶部报错信息内容p元素}    ${SLEEP_TIME_LONG}    #有错误信息，就等待其消失

检查系统弹层通知
    [Arguments]    ${是否忽略该通知}
    [Documentation]    用户打开通知的“浮窗提示”后，通知会随时出现一个浮窗，影响右上角区域的操作；
    ...    系统通知也会出来一个浮层
    ${result}=    Run Keyword And Return Status    Element Should Not Be Visible    ${系统通知浮层}
    Run Keyword Unless    ${result}    获得元素文本并记录LOG    ${系统通知浮层_内容}
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    ${系统通知浮层_关闭按钮}
    Run Keyword If    ${result}    Log    '发现了忽略按钮'
    Run Keyword If    ${result} and ${是否忽略该通知}    Click Element    ${系统通知浮层_关闭按钮}
    Run Keyword If    ${result} and ${是否忽略该通知}    Wait Until Element Is Not Visible    ${系统通知浮层}    ${SLEEP_TIME_LONG}

获得元素文本并记录LOG
    [Arguments]    ${元素}
    [Documentation]    后期优化记录方式，并将该函数移到基本支持model里
    ${信息内容}=    Get Text    ${元素}
    Log    "元素中出现的文本为'${信息内容}'"
    


#############################工作区导航#####################################

获得当前工作区导航文本
    ${导航名称}=    Get Text    ${工作区导航_当前导航}
    [Return]    ${导航名称}

切换到指定导航
    [Arguments]    ${导航名称}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    //div[contains(@class, 'menu_list')]//span[text()='${导航名称}']
    Run Keyword If    ${result}    Click Element    //div[contains(@class, 'menu_list')]//span[text()='${导航名称}']
    ${status}    ${result_1}=    Run Keyword And Ignore Error    查看是否有更多导航
    Run Keyword Unless    ${result} or ${result_1}    Log    '没有找到对应的导航'
    Run Keyword If   ${result_1}    在更多菜单中点击导航    ${导航名称}
    ${当前导航}=    Run Keyword    获得当前工作区导航文本 
    Should Be Equal    ${导航名称}    ${当前导航}

查看是否包含某导航
    [Arguments]    ${导航名称}
    ${status}    ${result_1}=    Run Keyword And Ignore Error    查看是否有更多导航
    Run Keyword If   ${result_1}    Mouse Over    ${工作区导航_更多提示按钮}
    ${result_1}=    Run Keyword And Return Status    Element Should Be Visible    //div[contains(@class, 'app_menu cl')]//span[text()='${导航名称}']
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    //div[contains(@class, 'menu_list')]//span[text()='${导航名称}']
    Mouse Over    ${切换工作区按钮}
    Should Be True    ${result_1} or ${result}



在更多菜单中点击导航
    [Arguments]    ${导航名称}
    Mouse Over    ${工作区导航_更多提示按钮}
    Element Should Be Visible    ${工作区导航_更多菜单弹层}
    Run Keyword And Return Status    Click Element    //div[contains(@class, 'app_menu cl')]//span[text()='${导航名称}']  
    Mouse Over    ${切换工作区按钮}  
    Sleep    ${SLEEP_TIME_SHORT}


遍历工作区可见导航
	@{当前工作区导航} =    Get WebElements    ${工作区导航_数量}
    : FOR    ${导航}    IN    @{当前工作区导航}
    \    Wait Until Element Is Visible    ${导航}    ${SLEEP_TIME_SHORT}
    \    Click Element    ${导航}
    \    Sleep    ${SLEEP_TIME_SHORT}
    \    ${title}=    Get text    ${工作区导航_当前导航}
    \    Log    '切换导航成功：${title}'
    ${status}    ${result_1}=    Run Keyword And Ignore Error    查看是否有更多导航
    Run Keyword If    ${result_1}    遍历工作区更多导航
    Log    '遍历完成'


遍历工作区更多导航
    Mouse Over    ${工作区导航_更多提示按钮}
    @{当前工作区导航} =    Get WebElements    ${工作区导航_更多菜单弹层_菜单项}
    : FOR    ${导航}    IN    @{当前工作区导航}
    \    Mouse Over    ${工作区导航_更多提示按钮}
    \    Wait Until Element Is Visible    ${导航}    ${SLEEP_TIME_SHORT}
    \    Click Element    ${导航}
    \    Sleep    ${SLEEP_TIME_SHORT}
    \    ${title}=    Get text    ${工作区导航_当前导航}
    \    Log    '切换导航成功：${title}'

查看是否有更多导航
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    ${工作区导航_更多提示按钮}    ${SLEEP_TIME_SHORT}
    [Return]    ${result}


#############################表格列表#####################################
按表格名称打开表格（只打开第一个）
    [Arguments]    ${表格名称}
    ${status}    ${result}=    Run Keyword And Ignore Error   按名称验证表格是否存在或可见    ${表格名称}
    Run Keyword If    ${result}
    Click Element    //span[@title='${表格名称}']

#遍历表格（放到表格操作里）

查看表格是否可以被拖动
    [Arguments]    ${表格名称}
    ${result}=    Run Keyword    按名称验证表格是否存在或可见    ${表格名称}
    Run Keyword Unless    ${result}    Return From Keyword    False    #不可见直接返回错误
    ${result}=    Get Element Attribute    //span[@title='${表格名称}']/../../li    draggable
    Return From Keyword    ${result}
    #Run Keyword If    ${result}     Return From Keyword    True
    #...    Return From Keyword    False


查看表格是否有管理菜单
    [Arguments]    ${表格名称}
    ${result}=    Run Keyword    按名称验证表格是否存在或可见    ${表格名称}
    Run Keyword Unless    ${result}    Return From Keyword    False    #不可见直接返回错误
    ${result}=    Run Keyword And Return Status    Mouse Over    //span[@title='${表格名称}']
    Run Keyword Unless    ${result}    Return From Keyword    False    #不可见直接返回错误
    Mouse Over    ${切换工作区按钮}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is visible    //span[@title='${表格名称}']/../em
    Return From Keyword    ${result}
    #Run Keyword If    ${result}     Return From Keyword    True
    #...    Return From Keyword    False

按名称验证表格是否存在或可见
    [Arguments]    ${表格名称}
    ${result}=    Run Keyword And Return Status    Wait Until Element Is visible    //span[@title='${表格名称}']
    [Return]    ${result}

按名称验证表格是否为反向同步表
    [Arguments]    ${表格名称}
    ${result}=    Run Keyword    按名称验证表格是否存在或可见    ${表格名称}
    Run Keyword Unless    ${result}    Return From Keyword    False    #不可见直接返回错误
    ${result}=    Run Keyword And Return Status    Wait Until Element Is visible    //span[@title='${表格名称}']/em
    Return From Keyword    ${result}
    #Run Keyword If    ${result}     Return From Keyword    True
    #...    Return From Keyword    False

#----------------------表格分组操作-----------------------------
返回工作区分组的数量


删除分组


隐藏分组

显示分组

分组改名

点击进入分组

退出分组



