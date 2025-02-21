import domain.{type Ledger}
import gleam/int
import gleam/io
import simplifile
import sqlight

const db_path = "./db/accouting.db"

pub fn create() {
  use conn <- sqlight.with_connection(db_path)
  let assert Ok(sql) = simplifile.read("./db/structure.sql")
  let assert Ok(Nil) = sqlight.exec(sql, conn)
}

pub fn main() {
  io.debug("|> Creating DB " <> db_path)
  create()
}

pub fn insert_ledger(ledger: Ledger) {
  use conn <- sqlight.with_connection(db_path)
  let sql = "INSERT INTO ledgers (name, version)
VALUES ('" <> ledger.name <> "', " <> int.to_string(ledger.version) <> ");"
  io.debug(sql)
  let assert Ok(Nil) = sqlight.exec(sql, conn)
}
