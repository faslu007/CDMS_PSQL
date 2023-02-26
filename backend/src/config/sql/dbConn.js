const { Pool } = require('pg');

// Create a new PostgreSQL pool instance
const pool = new Pool({
  user: process.env.pgUser,
  host: process.env.pgHost,
  database: process.env.pgDatabase,
  password: process.env.pgPassword,
  port: process.env.PGPort,
  max: 20, // Maximum number of clients in the pool
  idleTimeoutMillis: 30000, // Maximum amount of time a client can be idle before being closed
  connectionTimeoutMillis: 5000, // Maximum amount of time to wait for a client to become available
});

// Export the pool
module.exports = {
  pool,
};