import domain/acounting
import domain/ledgers
import domain/transactions.{new}
import gleam/option.{None, Some}
import gleam/time/calendar.{Date}
import gleeunit

// import gleam/time/timestamp

// import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn new_test() {
  let ledger = ledgers.Ledger(id: Some(1), name: "LedgerA", version: 1)
  let movement = acounting.Debit
  let effective_at = Date(2025, calendar.January, 1)
  let applied_at = Date(2025, calendar.January, 2)
  // a valid one can be crated
  // invalid case cant be created:
  // containing no entries
  // containing entries where debits and credits don't add up to the same number
}
