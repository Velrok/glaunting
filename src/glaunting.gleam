import argv
import commands
import gleam/io

pub fn main() {
  io.println("|> MAIN <|")
  let arguments = argv.load().arguments
  io.debug(arguments)
  case arguments {
    [] -> commands.print_help()
    ["help"] -> commands.print_help()
    ["--help"] -> commands.print_help()
    ["-h"] -> commands.print_help()

    ["ledger", ..rest] -> commands.ledger(rest)
    [_, ..] -> todo
  }
}
