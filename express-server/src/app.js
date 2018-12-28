const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const mogoose = require('mongoose');

const userRouter = require('./router/user-router');
const restaurantRouter = require('./router/restaurant-router');

//set express server
const app = express();
app.use(bodyParser.json());
app.use(morgan('dev'));
app.use(cors());

//add router
app.use('/user',userRouter);
app.use('/restaurant',restaurantRouter);

app.listen(process.env.PORT || 8081);