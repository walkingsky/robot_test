*** Settings ***
Documentation     主工作区页面相关的页面元素设置

*** Variables ***
${切换工作区按钮}    css=.switch_workspaces.switch_workspaces_tips_closed
${工作区名称}    css=.mod_cover.c_business h3    #工作区图表上的企业名称小字
${企业信息图标}    css=.mod_cover.c_business em.tips    #企业信息图标上的“企业信息”tips小图标
${企业工作区图标及企业名称}    css=.mod_cover.c_business h2    #企业工作区图表上的企业名称小字
${创建工作区图标}    css=.workspace_add    #集合，不能区分那个企业以及企业及个人工作区
${企业工作区分组}    css=.workspaces_group    #工作区分组，区分不同额企业，个人工作区一组
${企业工作区下拉图层}    id=spaceList  
#########################工作区内部##################################
${工作区title}    //cite
${工作区div}    css=.mod_cover    #工作区列表的每个工作区的div，包含企业和企业信息
${顶部错误信息的关闭按钮}    css=.hb_close
${顶部报错信息内容p元素}    css=.hb_headtips p
${顶部报错信息内容div}    css=.hb_headtips

######################### 通知 ##################################
${系统通知浮层}    css=.pop_announce
${系统通知浮层_内容}    css=.pop_announce a
${系统通知浮层_关闭按钮}    css=.notice_data .btn_ignore

######################### 工作区 导航 ##################################
${工作区导航_当前导航}    css=.menu_list li.current    #当前标签页
${工作区导航_数量}    css=.menu_list li    #导航标签页的数量，不包隐藏到末尾的下拉弹层里的导航
${工作区导航_更多提示按钮}    css=.menu_list .more    #工作区导航，更多导航选项
${工作区导航_更多菜单弹层}    css=.app_menu.cl
${工作区导航_更多菜单弹层_菜单项}    css=.app_menu.cl span

######################### 表格相关 ##################################
${工作区_表格_div}    css=.mod_appicon    #表格整个区域，title为完整标题
${工作区_表格_标题}    css=.mod_appicon  span   #显示出来的表格标题 
${工作区_表格_反向同步表标记}    css=.mod_appicon  em　　　　＃不是反向同步表的没有
${工作区_表格_下拉菜单按钮}    css=.mod_appicon +em 　　　　＃无权限的表格没有
#xpath 判断表格是否可以有被拖动属性，//span[@title='测试表格']/../../li ，然后用 Get Element Attribute locator attribute_name 获取
${工作区_表格_下拉菜单_选项}    css=.popover-content li    ＃表格右键菜单选项
${工作区_表格_下拉菜单_弹层}    css=.popover.bottom-left.in    #display属性判断是否存在
${工作区_表格_新建按钮}    css=.create_app
${工作区_表格_分组图标}    css=.groupicon
${工作区_表格_分组下拉菜单按钮}    css=.groupicon +em.drop 
${工作区_表格_分组下拉菜单_弹层}    css=.popover.bottom.in
${工作区_表格_分组下拉菜单_选项}    css=.popover-content li
${工作区_表格_分组_返回}    css=.appgroup_title


######################### 用户操作 ##################################
${工作区_side_菜单}    css=.side_head_menu i
${工作区_side_邀请div}    css=.invite_tips    #判断是否开启了工作区公开邀请
${工作区_side_邀请链接}    css=.invite_tips a    #
${工作区_side_邀请按钮}    css=.side_head_invite
${工作区_side_菜单弹层}    css=.popover.bottom.in
${工作区_side_菜单选项}    css=.pop_menu.cl




