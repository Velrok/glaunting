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
  let effective_at = timestamp.from_unix_seconds(1_740_519_016)
  let applied_at = timestamp.from_unix_seconds(1_740_519_816)

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
