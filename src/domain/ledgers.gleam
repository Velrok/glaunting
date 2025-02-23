import db/sqlite
import gleam/dynamic/decode
import gleam/int
import gleam/io
import gleam/option.{type Option, None, Some}

pub type Ledger {
  Ledger(id: Option(Int), name: String, version: Int)
}

pub fn new(name: String) {
  Ledger(id: None, version: 0, name: name)
}

pub fn insert(ledger: Ledger) {
  let sql = "INSERT INTO ledgers (name, version)
VALUES ('" <> ledger.name <> "', " <> int.to_string(ledger.version) <> ");"
  sqlite.exec(sql)
}

fn ledger_decoder() {
  use id <- decode.field(0, decode.int)
  use name <- decode.field(1, decode.string)
  use version <- decode.field(2, decode.int)
  decode.success(Ledger(id: Some(id), name: name, version: version))
}

pub fn all() -> List(Ledger) {
  let sql = "select id, name, version from ledgers;"
  case sqlite.query(sql, [], ledger_decoder()) {
    Error(_) -> panic
    Ok(ledgers) -> ledgers
  }
}

pub fn for_name(name: String) -> List(Ledger) {
  let sql = "SELECT id, name, version
    FROM ledgers
    WHERE name = '" <> name <> "'
    ;"
  case sqlite.query(sql, [], ledger_decoder()) {
    Error(_) -> panic
    Ok(ledgers) -> ledgers
  }
}
