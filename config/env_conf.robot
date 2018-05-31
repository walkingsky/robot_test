*** Settings ***
Documentation     测试执行参数设置
Library           Selenium2Library

*** Variables ***
#
${BROWSER}        chrome
${DELAY}          0
#设置是否使用 headless
${USE_HEADLESS}    1    # 0：不使用 \ 1：使用
#设置是否使用dev环境
${USE_DEV}        0    # 0:不使用 \ 1:使用
#后端分支
${hb_dev_host}    dev03
