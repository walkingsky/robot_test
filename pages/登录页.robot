*** Settings ***
Documentation     登录页面相关的页面元素设置

*** Variables ***
${LOGIN PGAE URL}    account/login    # 登录页url里应该包含的固定路径
${登录页的title}    登录 - 伙伴办公（原“伙伴云表格”）    
${用户名输入框}    name=username
${密码输入框}    name=password
${登录按钮}    css=dl:nth-child(2) button
${登录错误div}   class:login_tips
${用户图标}    css=span.mod_avatar.avt_small
${退出按钮}    link:退出