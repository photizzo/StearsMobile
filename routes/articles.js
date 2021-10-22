const express = require('express');
const bodyParser = require('body-parser');
const router = express.Router();
const articles = require('../services/articles');
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })
/* GET articles. */
router.get('/', async function(req, res, next) {
  try {
    res.json(await articles.getMultiple(req.query.page));
  } catch (err) {
    console.error(`Error while getting articles `, err.message);
    next(err);
  }
});

/* POST article */
router.post('/', jsonParser, async function(req, res, next) {
  try {
    res.json(await articles.create(req.body));
  } catch (err) {
    console.error(`Error while creating article`, err.message);
    next(err);
  }
});

module.exports = router;