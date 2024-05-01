*** Settings ***
Library     Browser
Library     OperatingSystem
Library     Account_Manager
Resource    ../resources/Common/Keywords.resource
Resource    ../resources/RegisterPage/Keywords.resource

*** Variables ***
${account_file}    ${EXECDIR}/data/Accounts.csv

*** Test Cases ***
Register New Account
    Open Trade Me
    Go To Register Page
    ${account_info}    Create Account
    Set Account Purpose    Personal
    Input Account Details    ${account_info}    New Zealand
    Sleep    5s

Register New Account Existing
    Open Trade Me
    Go To Register Page
    ${account_info}    Get Account    ${account_file}    UserID_695519
    Set Account Purpose    Personal
    Input Account Details    ${account_info}    New Zealand
    Input Personal Details    ${account_info}
    Sleep    5s