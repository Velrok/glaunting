import argv
import commands

pub fn main() {
  let arguments = argv.load().arguments
  case arguments {
    [] -> commands.print_help()
    ["help"] -> commands.print_help()
    ["--help"] -> commands.print_help()
    ["-h"] -> commands.print_help()

    ["ledger", ..rest] -> commands.ledger(rest)
    ["ledgers", ..rest] -> commands.ledger(rest)

    ["sub_account", ..rest] -> commands.sub_account(rest)
    ["sub_accounts", ..rest] -> commands.sub_account(rest)

    ["transaction", ..rest] -> commands.transaction(rest)
    ["transactions", ..rest] -> commands.transaction(rest)
    [_, ..] -> panic as "unknown sub command"
  }
}
