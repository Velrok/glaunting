import db/sqlite
import domain/acounting.{type Movement}
import domain/ledgers.{type Ledger}
import gleam/dynamic/decode
import gleam/int
import gleam/io
import gleam/option.{type Option, None, Some}
import gleam/time/timestamp.{type Timestamp}

pub type Transaction {
  Transaction(
    id: Option(Int),
    label: String,
    ledger_version: Int,
    ledger_id: Int,
    movement: Movement,
    applied_at: Timestamp,
    effective_at: Timestamp,
  )
}

pub fn new(
  label label: String,
  ledger ledger: Ledger,
  movement movement: Movement,
  effective_at effective_at: Timestamp,
  applied_at applied_at: Timestamp,
) {
  let assert Some(ledger_id) = ledger.id

  Transaction(
    id: None,
    label:,
    ledger_version: ledger.version + 1,
    ledger_id: ledger_id,
    movement:,
    applied_at:,
    effective_at:,
  )
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
