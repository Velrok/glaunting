import db/sqlite
import domain
import gleam/dict
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
  case arguments {
    ["create", ..args] -> create(args)
    _ -> panic as "Unknown command"
  }

  Nil
}

fn create(args: List(String)) {
  let parsed_args =
    list.map(args, parse_labeled_argument)
    |> dict.from_list()
  io.debug(parsed_args)

  let ledger = case dict.get(parsed_args, "name") {
    Error(_) -> panic
    Ok(name) -> domain.new_ledger(name)
  }

  sqlite.insert_ledger(ledger)
  // convert labeled_args into Ledger
  // write Ledger to db
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
