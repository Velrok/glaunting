pub type Movement {
  Credit
  Debit
}

pub fn to_string(m: Movement) {
  case m {
    Credit -> "credit"
    Debit -> "debit"
  }
}

pub fn from_string(s: String) {
  case s {
    "credit" -> Credit
    "debit" -> Debit
    _ -> panic as "invalid type"
  }
}
