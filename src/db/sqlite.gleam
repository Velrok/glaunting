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
