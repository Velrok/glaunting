# Gleam Accounting -> glaunting

## setup

To create a local db run `gleam run -m db/sqlite`

## Usage

```sh
glaunting ledger create --name=<name>
glaunting ledger list

glaunting subaccount create --ledger=<ledger> --name=<name> --type=[credit/debit]
glaunting subaccount list --ledger=<ledger>

glaunting transaction create --ledger=<ledger>  --label='some description' --effective=2025-01-02 --applied=2025-03-21 --entry 'credit <subaccount> <amount>' --entry 'debit <other-subaccount> <amount>'
glaunting transaction list --ledger=<ledger> --order=[applied/effective]

glaunting balance --ledger=<ledger> --account=<subaccount> --order=[applied/effective]
```

## Todo

 - [x] glaunting ledger list
 - [x] glaunting ledger create
 - [ ] glaunting subaccount create
 - [ ] glaunting subaccount list
 - [ ] glaunting transaction create
 - [ ] glaunting transaction list
 - [ ] glaunting balance

