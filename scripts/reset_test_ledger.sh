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

gleam run -- transaction create --ledger=loan1 \
  --label='loan creation' \
  --effective=2025-01-02 \
  --applied=2025-03-21 \
  --entry 'credit <subaccount> <amount>' \
  --entry 'debit <other-subaccount> <amount>'
