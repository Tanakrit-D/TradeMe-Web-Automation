import os
import csv
from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword, not_keyword, library
from typing_extensions import Literal

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

@keyword("Get Account")
def get_account(file, account_name: str):
    with open(file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if row['account'] == account_name:
                return {
                    'account': row['account'],
                    'email': row['email'],
                    'password': row['password'],
                    'f_name': row['f_name'],
                    'l_name': row['l_name'],
                    'date_of_birth': row['date_of_birth'],
                    'status': row['status']
                }
    raise Exception('The specified account was not found.')

@keyword("Set Account Data")
def set_account(file_path, account_name: str, key: str, value: str):
    """Updates the status of the desired account.

    :param file_path:       File path to the account file
    :param account_name:    Name of the account to update
    :param key:             Header/column to update
    :param value:           Value to set

    **Examples**

    .. code-block:: robotframework

        Set Account Data    /data/Accounts.csv    UserID_120    status    enabled


    .. code-block:: python

        set_account('/data/Accounts.csv', 'Billkin', 'email', 'new_email@test.email.com')
    """
    with open(file_path, mode='r', newline='') as file:
        reader = csv.DictReader(file)
        data = [row for row in reader]

    for row in data:
        if row['account'] == account_name:
            row[key] = value
            break

    with open(file_path, mode='w', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=reader.fieldnames)
        writer.writeheader()
        writer.writerows(data)

# Manual testing
if __name__ == '__main__':
    account_dict = {
        'account': 'UserID_200',
        'email': 'fresh@emal.test.com',
        'password': 'cleverpassword',
        'f_name': 'David',
        'l_name': 'Davidson'
    }
    put_account('./data/Accounts.csv', account_dict)
    set_account('./data/Accounts.csv', account_dict['account'], 'status', 'disabled')