import gleam/io

pub fn handle() {
  io.println(
    "
# This is the help

glaunting ledger create --name=<name>
glaunting ledger list
  ",
  )
}
