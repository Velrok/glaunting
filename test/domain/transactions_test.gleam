import domain/acounting
import domain/ledgers
import domain/transactions.{Transaction, new}
import gleam/option.{None, Some}
import gleam/time/timestamp
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn new_test() {
  let ledger = ledgers.Ledger(id: Some(1), name: "LedgerA", version: 1)
  let movement = acounting.Debit
  let assert Ok(effective_at) = timestamp.parse_rfc3339("2025-01-01")
  let assert Ok(applied_at) = timestamp.parse_rfc3339("2025-01-02")

  new(label: "label", ledger:, movement:, effective_at:, applied_at:)
  |> should.equal(Transaction(
    id: None,
    label: "label",
    ledger_version: 2,
    ledger_id: 1,
    movement: movement,
    applied_at: applied_at,
    effective_at: effective_at,
  ))
}
