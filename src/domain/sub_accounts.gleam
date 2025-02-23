import db/sqlite
import domain/acounting.{type Movement}
import domain/ledgers.{type Ledger}
import gleam/dynamic/decode
import gleam/int
import gleam/io
import gleam/option.{type Option, None, Some}

pub type SubAccount {
  SubAccount(
    id: Option(Int),
    label: String,
    ledger_id: Int,
    normal_type: Movement,
  )
}

pub fn new(label: String, ledger: Ledger, normal_type: Movement) {
  let assert Some(ledger_id) = ledger.id

  SubAccount(
    id: None,
    label: label,
    ledger_id: ledger_id,
    normal_type: normal_type,
  )
}

pub fn to_string(sub_account: SubAccount) -> String {
  let id = case sub_account.id {
    None -> "∅"
    Some(id) -> int.to_string(id)
  }
  let ledger_id = int.to_string(sub_account.ledger_id)

  sub_account.label
  <> " ("
  <> id
  <> ") "
  <> "Ledger ID: "
  <> ledger_id
  <> " Type: "
  <> acounting.to_string(sub_account.normal_type)
}

pub fn insert(sub_account: SubAccount) {
  let sql =
    "INSERT INTO sub_accounts (label, ledger_id, normal_type) VALUES ('"
    <> sub_account.label
    <> "', "
    <> int.to_string(sub_account.ledger_id)
    <> ", '"
    <> acounting.to_string(sub_account.normal_type)
    <> "');"
  sqlite.exec(sql)
}

pub fn all() -> List(SubAccount) {
  let sub_account_decoder = {
    use id <- decode.field(0, decode.int)
    use label <- decode.field(1, decode.string)
    use ledger_id <- decode.field(2, decode.int)
    use normal_type <- decode.field(3, decode.string)
    let normal_type = acounting.from_string(normal_type)

    decode.success(SubAccount(
      id: Some(id),
      label: label,
      ledger_id: ledger_id,
      normal_type: normal_type,
    ))
  }
  let sql = "SELECT id, label, ledger_id, normal_type FROM sub_accounts;"
  case sqlite.query(sql, [], sub_account_decoder) {
    Error(err) -> {
      io.println(err.message)
      panic
    }
    Ok(sub_accounts) -> sub_accounts
  }
}
