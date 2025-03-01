import domain/ledgers
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import utils

pub fn list() {
  io.println("Ledgers:")
  list.map(ledgers.all(), fn(ledger) {
    let version = int.to_string(ledger.version)
    let assert Some(id) = ledger.id
    let id = int.to_string(id)

    io.println(ledger.name <> "(" <> id <> ")" <> " verison:" <> version)
  })
  Nil
}

pub fn create(args: List(String)) {
  let parsed_args =
    list.map(args, utils.parse_labeled_argument)
    |> dict.from_list()

  let ledger = case dict.get(parsed_args, "name") {
    Error(_) -> panic
    Ok(name) -> ledgers.new(name)
  }

  let assert Ok(_) = ledgers.insert(ledger)
}

pub fn handle(arguments: List(String)) {
  io.println("|> ledger")
  let _ = case arguments {
    ["create", ..args] -> {
      let assert Ok(_) = create(args)
      Nil
    }
    ["list"] -> list()
    _ -> panic as "Unknown sub command for ledger"
  }

  Nil
}
