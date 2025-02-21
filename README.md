# Gleam Accounting -> glaunting

## Usage

```sh
glaunting subaccount create --name=<name> --type=[credit/debit]
glaunting subaccount list

glaunting transaction create --label='some description' --effective=2025-01-02 --applied=2025-03-21 --entry 'credit <subaccount> <amount>' --entry 'debit <other-subaccount> <amount>'
glaunting transaction list --order=[applied/effective]

glaunting balance --account=<subaccount> --order=[applied/effective]
```

## Todo

 - [ ] glaunting subaccount create
 - [ ] glaunting subaccount list
 - [ ] glaunting transaction create
 - [ ] glaunting transaction list
 - [ ] glaunting balance

