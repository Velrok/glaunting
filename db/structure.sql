CREATE TABLE ledgers (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  version INTEGER
);

CREATE TABLE transactions (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  label TEXT,
  ledger_version INTEGER,
  ledger_id INTEGER,       -- Foreign Key to `ledgers.Id`
  applied_at TIMESTAMP,    -- Timestamp for when the transaction is applied
  effective_at TIMESTAMP,  -- Timestamp for when the transaction becomes effective
  FOREIGN KEY (ledger_id) REFERENCES ledgers(Id)
);

CREATE TABLE entries (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  transaction_id INTEGER,  -- Foreign Key to `transactions.Id`
  type TEXT CHECK(type IN ('credit', 'debit')),  -- Enforcing 'credit' or 'debit'
  amount REAL,          -- Amount in cents, allowing for fractional values
  FOREIGN KEY (transaction_id) REFERENCES transactions(Id)
);
;
