*** Settings ***
Library        Browser
Library        DateTime
Library        String
Library        AccountManager
Resource       Variables.resource

*** Variables ***
${account_file}    ${EXECDIR}/data/Accounts.csv

*** Keywords ***
Open Trade Me
    New Browser    ${DRIVER}    headless=${HEADLESS}
    New Context    viewport={'width': ${VIEWPORT_W}, 'height': ${VIEWPORT_H}}
    New Page    ${URL}
    Wait For Load State    domcontentloaded    60s

Load User
    Log    test

Get Formatted Date
    [Documentation]    The date fields for registration use the format 01 January 2000 (%d %B %Y)
    ...    However, these are written and stored in /data/Accounts.csv as 2000/01/01 (%Y/%m/%d) for readability.
    ...    This function will convert them and return a dictionary with easily accessible keys.
    [Arguments]    ${date}
    ${formatted_date}=    Convert Date    ${date}    result_format=%Y %B %d    date_format=%Y/%m/%d
    @{date_parts}=    Split String    ${formatted_date}    ${SPACE}
    ${date_dict}=    Create Dictionary    year=${date_parts[0]}    month=${date_parts[1]}    day=${date_parts[2]}
    RETURN    ${date_dict}