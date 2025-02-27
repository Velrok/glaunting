import domain/acounting
import domain/sub_accounts
import domain/transactions
import gleam/dict
import gleam/io
import gleam/list
import gleam/string
import utils

pub fn list() {
  io.println("Transactions:")
  list.map(transactions.all(), fn(sub_account) {
    io.println(" - " <> transactions.to_string(sub_account))
  })
  Nil
}

pub fn create(args: List(String)) {
  let parsed_args =
    list.map(args, utils.parse_labeled_argument)
    |> dict.from_list()

  dict.get(parsed_args, "ledger")
  dict.get(parsed_args, "label")
  dict.get(parsed_args, "effective")
  dict.get(parsed_args, "applied")
  dict.get(parsed_args, "order")

  parse_entries(args)
}

fn parse_entries(
  args: List(String),
) -> List(#(acounting.Movement, sub_accounts.SubAccount, Float)) {
  list.index_fold(args, [], fn(agg, arg, index) {
    let assert Ok(entry_str) = list.take(args, index + 1) |> list.last()
    let tuple = parse_entry(str)
    list.append(agg, [tuple])
  })
}

fn parse_entry(
  result: String,
) -> #(acounting.Movement, sub_accounts.SubAccount, Float) {
  let [move_str, sub_acc_str, amount_str] = string.split(result, " ")
}

pub fn handle(arguments: List(String)) {
  io.println("|> transaction")
  let _ = case arguments {
    ["create", ..args] -> {
      let assert Ok(_) = create(args)
      Nil
    }
    ["list"] -> list()
    _ -> panic as "Unknown sub command for transaction"
  }

  Nil
}
