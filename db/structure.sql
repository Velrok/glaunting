
CREATE TABLE ledgers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  version INTEGER
);

CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  label TEXT,
  ledger_version INTEGER,
  ledger_id INTEGER,       -- Foreign Key to `ledgers.id`
  applied_at TIMESTAMP,    -- Timestamp for when the transaction is applied
  effective_at TIMESTAMP,  -- Timestamp for when the transaction becomes effective
  FOREIGN KEY (ledger_id) REFERENCES ledgers(id)
);

CREATE TABLE sub_accounts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  label TEXT,
  ledger_id INTEGER,       -- Foreign Key to `ledgers.id`
  normal_type TEXT CHECK(normal_type IN ('credit', 'debit')),  -- Fixed constraint name
  FOREIGN KEY (ledger_id) REFERENCES ledgers(id)
);

CREATE TABLE entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  transaction_id INTEGER,  -- Foreign Key to `transactions.id`
  sub_account_id INTEGER,  -- Foreign Key to `sub_accounts.id`
  type TEXT CHECK(type IN ('credit', 'debit')),  -- Enforcing 'credit' or 'debit'
  amount REAL,          -- Amount in cents, allowing for fractional values
  FOREIGN KEY (transaction_id) REFERENCES transactions(id),
  FOREIGN KEY (sub_account_id) REFERENCES sub_accounts(id)  -- Added missing comma
);
