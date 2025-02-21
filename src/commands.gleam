import db/sqlite
import domain
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp

pub fn print_help() {
  io.println(
    "
# This is the help

glaunting ledger create --name=<name>
glaunting ledger list
  ",
  )
}

pub fn ledger(arguments: List(String)) {
  io.println("|> ledger")
  io.debug(arguments)
  let _ = case arguments {
    ["create", ..args] -> create_ledger(args)
    ["list"] -> list_ledgers()
    _ -> panic as "Unknown command"
  }

  Nil
}

fn list_ledgers() {
  io.println("Ledgers:")
  list.map(sqlite.all_ledgers(), fn(ledger) {
    let version = int.to_string(ledger.version)
    let assert Some(id) = ledger.id
    let id = int.to_string(id)

    io.println(ledger.name <> "(" <> id <> ")" <> " verison:" <> version)
  })
  Nil
}

fn create_ledger(args: List(String)) {
  let parsed_args =
    list.map(args, parse_labeled_argument)
    |> dict.from_list()
  io.debug(parsed_args)

  let ledger = case dict.get(parsed_args, "name") {
    Error(_) -> panic
    Ok(name) -> domain.new_ledger(name)
  }

  let _ = sqlite.insert_ledger(ledger)
  Nil
}

pub fn parse_labeled_argument(arg_string: String) {
  let pattern = "--([\\w_-]+)=(.*)"
  let assert Ok(compiled_regex) = regexp.from_string(pattern)
  case regexp.scan(compiled_regex, arg_string) {
    [match] ->
      case match.submatches {
        [Some(label), Some(value)] -> #(label, value)
        _ -> panic
      }
    _ -> panic as "invalid labled argumen"
  }
}
