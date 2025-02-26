//import db/sqlite
import domain/acounting.{type Movement}
import domain/ledgers.{type Ledger}
import domain/sub_accounts.{type SubAccount}
import domain/validation.{type ValidationErrors}

// import gleam/dynamic/decode
// import gleam/int
// import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/time/calendar.{type Date}

//import gleam/time/timestamp.{type Timestamp}

pub opaque type Transaction {
  Transaction(
    id: Option(Int),
    label: String,
    ledger_version: Int,
    entries: List(Entry),
    ledger_id: Int,
    applied_at: Date,
    effective_at: Date,
  )
}

pub opaque type Entry {
  Entry(
    id: Option(Int),
    transaction: Transaction,
    movement: Movement,
    sub_account_id: Int,
    amount: Float,
  )
}

type EntryTuple =
  #(Movement, SubAccount, Float)

pub fn new(
  label label: String,
  ledger ledger: Ledger,
  entries entry_tuples: List(EntryTuple),
  effective_at effective_at: Date,
  applied_at applied_at: Date,
) {
  let assert Some(ledger_id) = ledger.id

  let transaction =
    Transaction(
      id: None,
      label:,
      entries: [],
      ledger_version: ledger.version + 1,
      ledger_id: ledger_id,
      applied_at:,
      effective_at:,
    )

  let entries = entry_tuples |> list.map(entry_from_tuple(transaction, _))
  let transaction = Transaction(..transaction, entries:)

  validate(transaction)
}

fn entry_from_tuple(transaction: Transaction, tuple: EntryTuple) -> Entry {
  let #(movement, sub_account, amount) = tuple
  let assert Some(sub_account_id) = sub_account.id

  Entry(id: None, transaction:, movement:, sub_account_id:, amount:)
}

pub fn validate(
  transaction transaction: Transaction,
) -> Result(Transaction, ValidationErrors) {
  case transaction.entries {
    [] -> Error(["Must have at least two entries"])
    [_] -> Error(["Must have at least two entries"])
    _ -> Ok(transaction)
  }
}

pub fn to_string(transaction: Transaction) -> String {
  todo
}

pub fn insert(sub_account: Transaction) {
  todo
}

pub fn all() -> List(Transaction) {
  todo
}
