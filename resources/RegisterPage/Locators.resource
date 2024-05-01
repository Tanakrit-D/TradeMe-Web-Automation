*** Variables ***
${register_link}             xpath=(//a[@href="register"])[1]

${personal_link}             xpath=//a[@href="/a/register/personal"]
${business_link}             xpath=//a[@href="https://www.tmsandbox.co.nz/Members/RegisterBusiness.aspx"]

${email_field}               xpath=//input[@name="email"]
${password_field}            xpath=//input[@name="password"]
${confirm_password_field}    xpath=//input[@name="confirmPassword"]
${username_field}            xpath=//input[@name="userName"]
${region_nz_option}          xpath=//tg-radio-item[@value="New Zealand"]/label
${region_au_option}          xpath=//tg-radio-item[@value="Australia"]/label
${submit_button}             xpath=//button[@type="submit"]

${f_name_field}              xpath=//input[@name="firstName"]
${l_name_field}              xpath=//input[@name="lastName"]
${dob_d_field}               xpath=//input[@name="day"]
${dob_m_field}               xpath=//select[@name="month"]
${dob_y_field}               xpath=//input[@name="year"]
${phone_areacode_field}      xpath=//select[@name="primaryPhonePrefix"]
${phone_number_field}        xpath=//input[@name="primaryPhoneNumber"]
${gender_male_option}        xpath=//tg-radio-item[@value="male"]/label
${gender_female_option}      xpath=//tg-radio-item[@value="female"]/label
${gender_diverse_option}     xpath=//tg-radio-item[@value="diverseGender"]/label