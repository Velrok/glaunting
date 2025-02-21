import gleam/option.{type Option, None}

pub type Ledger {
  Ledger(id: Option(Int), name: String, version: Int)
}

pub fn new_ledger(name: String) {
  Ledger(id: None, version: 0, name: name)
}
