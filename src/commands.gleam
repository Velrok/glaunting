import commands/ledger
import commands/sub_account
import commands/transaction
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
  let _ = case arguments {
    ["create", ..args] -> {
      let assert Ok(_) = ledger.create(args)
      Nil
    }
    ["list"] -> ledger.list()
    _ -> panic as "Unknown sub command for ledger"
  }

  Nil
}

pub fn sub_account(arguments: List(String)) {
  io.println("|> sub_account")
  let _ = case arguments {
    ["create", ..args] -> {
      let assert Ok(_) = sub_account.create(args)
      Nil
    }
    ["list"] -> sub_account.list()
    _ -> panic as "Unknown sub command for sub_account"
  }

  Nil
}

pub fn transaction(arguments: List(String)) {
  io.println("|> transaction")
  let _ = case arguments {
    ["create", ..args] -> {
      let assert Ok(_) = transaction.create(args)
      Nil
    }
    ["list"] -> transaction.list()
    _ -> panic as "Unknown sub command for transaction"
  }

  Nil
}
