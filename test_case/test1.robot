*** Settings ***
Test Template     比较两个数的大小 ${数1} ${数2}

*** Test Cases ***
模版测试
    1    2
    1    1
    2    3
    2    2
*** Keywords ***
比较两个数的大小 ${数1} ${数2}
    Should Be Equal    ${数1}    ${数2}
