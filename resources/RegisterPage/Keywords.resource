*** Settings ***
Library     Browser
Library     Collections
Library     String
Library     AccountManager
Library     DialogManager
Resource    Locators.resource
Resource    Variables.resource
Resource    ../Common/Keywords.resource

*** Variables ***
${account_file}    ${EXECDIR}/data/Accounts.csv

*** Keywords ***
Create Account
    [Arguments]    ${randomised}=${True}    ${account}=${None}    ${email}=${None}     ${password}=${None}
    IF    ${randomised} == ${True}
        ${account}=    Generate Random String    6    [NUMBERS]
        ${email}=    Generate Random String    8    [LOWER]
        ${password}=    Generate Random String    8    [LETTERS]
        ${f_name}=    Generate Random String    4    [UPPER]
        ${l_name}=    Generate Random String    4    [UPPER]
        ${account}=    Catenate    SEPARATOR=    UserID_    ${account}
        ${email}=    Catenate    SEPARATOR=    ${email}    @test.account.com
    END
    ${account_info}    Create Dictionary    account=${account}    email=${email}    password=${password}    f_name=${f_name}    l_name=${l_name}
    Put Account    ${account_file}    ${account_info}
    RETURN    ${account_info}

Go To Register Page
    Click    ${register_link}
    Get Title    contains    Register for membership of Trade Me

Set Account Purpose
    [Arguments]    ${purpose}
    ${purpose}    Convert To Lower Case    ${purpose}
    IF    '${purpose}' == 'personal'
        Click    ${personal_link}
    END
    IF    '${purpose}' == 'business'
        Click    ${business_link}
    END

Input Account Details
    [Arguments]    ${account_info}    ${region}
    Type Text   ${email_field}    ${account_info['email']}
    Type Secret   ${password_field}    $account_info['password']
    Type Secret   ${confirm_password_field}    $account_info['password']
    Type Text    ${username_field}    ${account_info['account']}
    ${region}    Convert To Lower Case    ${region}
    IF    '${region}' == 'new zealand'
        Click    ${region_nz_option}
    END
    IF    '${region}' == 'australia'
        Click    ${region_au_option}
    END
    Click    ${submit_button}

Input Personal Details
    [Documentation]    To-do: Add additional arguments to specify or retrieve fields such as phone number or gender.
    ...    At this stage they remain hardcoded ¯\_(ツ)_/¯.
    [Arguments]    ${account_info}
    Type Text    ${f_name_field}    ${account_info['f_name']}
    Type Text    ${l_name_field}    ${account_info['l_name']}
    ${formatted_date}    Get Formatted Date    ${account_info['date_of_birth']}
    Type Text    ${dob_d_field}    ${formatted_date['day']}
    Select Options By    ${dob_m_field}    text    ${formatted_date['month']}
    Type Text    ${dob_y_field}    ${formatted_date['year']}
    Select Options By    ${phone_areacode_field}    text    03
    Type Text    ${phone_number_field}    1234567
    Click    ${gender_male_option}
    Type Text    ${address_field}    16 Jutland Street
    Wait For Elements State    ${desired_address_option}    visible
    Click    ${desired_address_option}
    Select Options By    ${town_option}    text    Canterbury - Christchurch City
    Click    ${terms_option}
    Click    ${submit_button}

Verify Success
    [Arguments]    ${account_info}
    Wait For Elements State    ${register_success}    attached
    Set Account Data    ${account_file}    ${account_info['account']}    status    enabled

Captcha Handling
    IF    ${CAPTCHA_SKIP} == ${False}
        Captcha Input Required
    END