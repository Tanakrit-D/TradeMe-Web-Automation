# TradeMe Web Automation - Robot Framework
Documentation is a work in progress.

The [accounts data](./data/Accounts.csv) has not be excluded with [.gitignore](./.gitignore) as Trade Me Sandbox is a public test environment.

## Dependency Management
This project uses pipx (optional) and Poetry.
[pipx](https://github.com/pypa/pipx)
[Poetry](https://python-poetry.org/docs/)

## Version Notes
I've locked Robot Framework to 6.1.1 due to the <7.0.0 dependency of RPA Assistant which is used for dialog windows.