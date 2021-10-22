const env = process.env;

const config = {
  db: { /* don't expose password or any sensitive info, done only for demo */
    host: env.DB_HOST || 'remotemysql.com',
    user: env.DB_USER || 'JWz3NiAPma',
    password: env.DB_PASSWORD || 'JAxGUFQV9B',
    database: env.DB_NAME || 'JWz3NiAPma',
  },
  listPerPage: env.LIST_PER_PAGE || 50,
  notification: {
    apiKey: "22995461-4fd0-44ae-b4c1-b72d4852cbc1",
    restKey: "OTc4M2RkMDctNjdkYi00ODhlLWJiN2YtMDEwNTA0OWZlZjFj",
  },
};


module.exports = config;