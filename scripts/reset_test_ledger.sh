#!/usr/bin/env sh

rm ./db/accouting.db
gleam run -m db/sqlite

gleam run -- ledger create --name=loan1
gleam run -- sub_account create --name=principal --ledger=loan1 --type=debit
gleam run -- sub_account create --name=original_advance --ledger=loan1 --type=credit

echo 'ledgers'
echo '-------'
gleam run -- ledger list

echo 'sub accounts'
echo '------------'
gleam run -- sub_account list
