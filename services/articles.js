const db = require('./db');
const helper = require('../helper');
const config = require('../config');
const OneSignal = require('onesignal-node');
var notificationMessage = ""
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
  var notificationMessage = {
    app_id: config.notification.apiKey,
    contents: {"en": article.title},
    included_segments: ["Subscribed Users"],
    small_icon: "app_logo"
  };
  sendNotification(notificationMessage);
  if (result.affectedRows) {
    message = 'Article created successfully';
  }

  return {message};
}

var sendNotification = function(data) {
  var headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": "Basic " + config.notification.restKey
  };

  var options = {
    host: "onesignal.com",
    port: 443,
    path: "/api/v1/notifications",
    method: "POST",
    headers: headers
  };

  var https = require('https');
  var req = https.request(options, function(res) {
    res.on('data', function(data) {
      console.log("Response:");
      console.log(JSON.parse(data));
    });
  });

  req.on('error', function(e) {
    console.log("ERROR:");
    console.log(e);
  });

  req.write(JSON.stringify(data));
  req.end();
};


module.exports = {
  getMultiple,
  create
}