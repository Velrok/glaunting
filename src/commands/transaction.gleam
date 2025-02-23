import domain/acounting
import domain/ledgers
import domain/transactions
import gleam/dict
import gleam/io
import gleam/list
import utils

pub fn list() {
  io.println("Transactions:")
  list.map(transactions.all(), fn(sub_account) {
    io.println(" - " <> transactions.to_string(sub_account))
  })
  Nil
}

pub fn create(args: List(String)) {
  todo
}
