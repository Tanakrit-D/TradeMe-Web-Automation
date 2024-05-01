import os
import csv

def put_account(file, account_info):
    headers = ['account', 'email', 'password', 'f_name', 'l_name', 'date_of_birth']
    account_info['date_of_birth'] = '2000/01/01'
    
    if not os.path.exists(file):
        with open(file, 'w', newline='') as f:
            writer = csv.DictWriter(f, fieldnames=headers)
            writer.writeheader()

    with open(file, 'a', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=headers)
        writer.writerow(account_info)

def get_account(file, account_name):
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
                    'date_of_birth': row['date_of_birth']
                }
    raise Exception('The specified account was not found.')