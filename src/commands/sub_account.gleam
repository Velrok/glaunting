import domain/acounting
import domain/ledgers
import domain/sub_accounts
import gleam/dict
import gleam/io
import gleam/list
import utils

pub fn list() {
  io.println("Sub-Accounts:")
  list.map(sub_accounts.all(), fn(sub_account) {
    io.println(" - " <> sub_accounts.to_string(sub_account))
  })
  Nil
}

pub fn create(args: List(String)) {
  let parsed_args =
    list.map(args, utils.parse_labeled_argument)
    |> dict.from_list()

  let label = case dict.get(parsed_args, "name") {
    Error(_) -> panic as "missing sub_account name"
    Ok(label) -> label
  }
  let ledger_name = dict.get(parsed_args, "ledger")
  let acc_type = case dict.get(parsed_args, "type") {
    Error(_) -> panic as "missing type"
    Ok(x) -> x
  }

  let first_ledger_for_name = case ledger_name {
    Error(_) -> panic as "missing ledger"
    Ok(ledger_name) ->
      ledgers.for_name(ledger_name)
      |> list.first
  }

  let ledger = case first_ledger_for_name {
    Error(_) -> panic as "cant find ledger for name"
    Ok(ledger) -> ledger
  }

  let default_type = acounting.from_string(acc_type)
  let sub_account = sub_accounts.new(label, ledger, default_type)

  let assert Ok(_) = sub_accounts.insert(sub_account)
}
