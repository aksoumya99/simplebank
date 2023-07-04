/*accounts table queries*/
-- name: CreateAccount :one
INSERT INTO accounts (
  owner, balance, currency
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

-- name: GetAccountForUpdate :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1
FOR NO KEY UPDATE;

-- name: ListAccounts :many
SELECT * FROM accounts
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :one
UPDATE accounts SET balance = $2
WHERE id = $1 RETURNING *; 

-- name: AddAccountBalance :one
UPDATE accounts SET balance = balance + sqlc.arg(amount)
WHERE id = $1 RETURNING *; 

-- name: DeleteAccount :exec
DELETE from accounts 
WHERE id = $1; 

/*entries table queries*/
-- name: CreateEntry :one
INSERT INTO entries (
  account_id, amount
) VALUES (
  $1, $2
) RETURNING *;

-- name: GetEntry :one
SELECT * from entries
WHERE id = $1 LIMIT 1;

-- name: ListEntries :many
SELECT * FROM entries
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateEntry :one
UPDATE entries SET amount = $2
WHERE id = $1 RETURNING *; 

-- name: DeleteEntry :exec
DELETE from entries 
WHERE id = $1; 

/*transfers table queries*/
-- name: CreateTransfer :one
INSERT INTO transfers (
  from_account_id, to_account_id, amount
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: GetTransfer :one
SELECT * from transfers
WHERE id = $1 LIMIT 1;

-- name: ListTransfers :many
SELECT * FROM transfers
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateTransfer :one
UPDATE transfers SET from_account_id = $2, to_account_id = $3, amount = $4
WHERE id = $1 RETURNING *; 

-- name: DeleteTransfer :exec
DELETE from transfers 
WHERE id = $1; 