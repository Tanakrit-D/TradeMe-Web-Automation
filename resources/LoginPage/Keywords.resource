*** Settings ***
Library     Browser
Library     Account_Manager
Resource    Locators.resource
Resource    Variables.resource

*** Keywords ***
Login
    [Arguments]    @{account}
    Click    ${login_link}
    Wait For Load State    load
    Wait For Condition    Element    class="login-text"
    Fill Text    selector    txt