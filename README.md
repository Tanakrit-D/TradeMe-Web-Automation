# TradeMe Web Automation - Robot Framework
Documentation is a work in progress.

The [accounts data](./data/Accounts.csv) has not be excluded with [.gitignore](./.gitignore) as Trade Me Sandbox is a public test environment.

## Dependency Management
This project uses [pipx](https://github.com/pypa/pipx) (optional) and [Poetry](https://python-poetry.org/docs/).

## Version Notes
I've locked Robot Framework to 6.1.1 due to the <7.0.0 dependency of RPA Assistant which is used for dialog windows.

## Test Example
[register.robot](./tests/register.robot)
```
Register New Account
    Open Trade Me
    Go To Register Page
    ${account_info}    Create Account
    Set Account Purpose    Personal
    Input Account Details    ${account_info}    New Zealand
    Input Personal Details    ${account_info}
    Verify Success    ${account_info}
```

## Robot Framework Keyword Example
[resources/RegisterPage/Keywords.resource](./resources/RegisterPage/Keywords.resource)
```
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
```

## Custom Keyword Example
[libraries/Account/AccountManager.py](./libraries/Account/AccountManager.py)
```
@keyword("Put Account")
def put_account(file, account_info: dict):
    headers = ['account', 'email', 'password', 'f_name', 'l_name', 'date_of_birth', 'status']
    account_info['date_of_birth'] = '2000/01/01'
    account_info['status'] = 'disabled'
    
    if not os.path.exists(file):
        with open(file, 'w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=headers)
            writer.writeheader()

    with open(file, 'a', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=headers)
        writer.writerow(account_info)
```
