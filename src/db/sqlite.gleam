import domain.{type Ledger}
import gleam/dynamic/decode
import gleam/int
import gleam/io
import gleam/option.{Some}
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

pub fn all_ledgers() -> List(Ledger) {
  use conn <- sqlight.with_connection(db_path)

  let ledger_decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use version <- decode.field(2, decode.int)
    decode.success(domain.Ledger(id: Some(id), name: name, version: version))
  }
  let sql = "select id, name, version from ledgers;"
  io.debug(sql)
  case sqlight.query(sql, on: conn, with: [], expecting: ledger_decoder) {
    Error(_) -> panic as "cant parse Ledger from sql result"
    Ok(ledger) -> ledger
  }
}
