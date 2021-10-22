const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;
const articlesRouter = require('./routes/articles');
// create application/json parser
var jsonParser = bodyParser.json()
// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false })

app.use(jsonParser);
app.use(urlencodedParser);

app.get('/', (req, res) => {
  res.json({'message': 'ok'});
})

/* Error handler middleware */
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  console.error(err.message, err.stack);
  res.status(statusCode).json({'message': err.message});

  return;
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});

app.use('/articles', articlesRouter);
