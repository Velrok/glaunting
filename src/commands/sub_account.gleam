import domain/sub_accounts
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some, None}
import utils

pub fn list() {
  io.println("Sub-Accounts:")
  list.map(sub_accounts.all(), fn(sub_account) {
    let assert Some(id) = sub_account.id
    let id = int.to_string(id)
    let ledger_id = int.to_string(sub_account.ledger_id)
    io.println(sub_account.label <> " (" <> id <> ") " <> "Ledger ID: " <> ledger_id <> " Type: " <> sub_account.normal_type)
  })
  Nil
}

pub fn create(args: List(String)) {
  let parsed_args =
    list.map(args, utils.parse_labeled_argument)
    |> dict.from_list()
  io.debug(parsed_args)

  case { dict.get(parsed_args, "label"), dict.get(parsed_args, "ledger_id"), dict.get(parsed_args, "type") } {
    { Ok(label), Ok(ledger_id_str), Ok(normal_type) } -> {
      case int.parse(ledger_id_str) {
        Ok(ledger_id) -> {
          let sub_account = sub_accounts.new(label, ledger_id, normal_type)
          sub_accounts.insert(sub_account)
          io.println("Sub-Account created: " <> label)
        }
        Error(_) -> io.println("Error: ledger_id must be an integer")
      }
    }
    _ -> io.println("Error: Missing required arguments --label, --ledger_id, --type")
  }
}
