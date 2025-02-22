import commands/ledger
import gleam/io

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
    ["create", ..args] -> {
      let assert Ok(_) = ledger.create(args)
      Nil
    }
    ["list"] -> ledger.list()
    _ -> panic as "Unknown command"
  }

  Nil
}
