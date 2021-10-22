const env = process.env;

const config = {
  db: { /* don't expose password or any sensitive info, done only for demo */
    host: env.DB_HOST || 'remotemysql.com',
    user: env.DB_USER || 'JWz3NiAPma',
    password: env.DB_PASSWORD || 'JAxGUFQV9B',
    database: env.DB_NAME || 'JWz3NiAPma',
  },
  listPerPage: env.LIST_PER_PAGE || 50,
};


module.exports = config;