const db = require('./db');
const helper = require('../helper');
const config = require('../config');

async function getMultiple(page = 1){
  const offset = helper.getOffset(page, config.listPerPage);
  const rows = await db.query(
    `SELECT * FROM articles LIMIT ?,?`,
    [offset, config.listPerPage]
  );
  const data = helper.emptyOrRows(rows);
  const meta = {page};

  return {
    data,
    meta
  }
}

async function create(article){
  const result = await db.query(
    `INSERT INTO articles
    (title, imageUrl, author, avatar, minRead, description)
    VALUES
    (?, ?, ?, ?, ?, ?)`,
    [
      article.title, article.imageUrl,
      article.author, article.avatar,
      article.minRead, article.description,
    ]
  );

  let message = 'Error in creating articles';

  if (result.affectedRows) {
    message = 'Article created successfully';
  }

  return {message};
}

module.exports = {
  getMultiple,
  create
}