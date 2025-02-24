import domain/transactions
import gleam/io
import gleam/list

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
