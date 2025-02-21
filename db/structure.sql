CREATE TABLE ledgers (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  version INTEGER
);

CREATE TABLE transactions (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  label String,
  ledger_version INTEGER, -- FK
  ledger_id -- FK
  applied_at  -- timestamp
  effective_at -- timestamp
);

CREATE TABLE entries (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  transaction_id -- FK
  type -- either credit OR debit
  amount -- amount in cents, can be fractional
);
