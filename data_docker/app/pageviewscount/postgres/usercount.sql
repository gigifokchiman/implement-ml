-- Create the database 'userdb' if it does not already exist
SELECT datname
FROM pg_database
WHERE datistemplate = false;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'userdb') THEN
        PERFORM dblink_exec('dbname=postgres', 'CREATE DATABASE userdb');
    END IF;
END $$;

-- Connect to the 'userdb' database
\c userdb;

-- Create the 'usercount' table
CREATE TABLE IF NOT EXISTS user_counts (
    id SERIAL PRIMARY KEY,
    window_start VARCHAR(19) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    count INT NOT NULL
);