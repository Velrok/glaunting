import argv
import commands/help
import commands/ledger
import commands/sub_account
import commands/transaction

pub fn main() {
  let arguments = argv.load().arguments
  case arguments {
    [] -> help.handle()
    ["help"] -> help.handle()
    ["--help"] -> help.handle()
    ["-h"] -> help.handle()

    ["ledger", ..rest] -> ledger.handle(rest)
    ["ledgers", ..rest] -> ledger.handle(rest)

    ["sub_account", ..rest] -> sub_account.handle(rest)
    ["sub_accounts", ..rest] -> sub_account.handle(rest)

    ["transaction", ..rest] -> transaction.handle(rest)
    ["transactions", ..rest] -> transaction.handle(rest)
    [_, ..] -> panic as "unknown sub command"
  }
}
