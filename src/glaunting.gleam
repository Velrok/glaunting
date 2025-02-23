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
    ["sub_account", ..rest] -> commands.sub_account(rest)
    [_, ..] -> panic as "unknown sub command"
  }
}
