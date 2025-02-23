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
    normal_type: Movement,
    applied_at: Timestamp,
    effective_at: Timestamp,
  )
}

pub fn new() {
  todo
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
