const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const mogoose = require('mongoose');
var proxy = require('http-proxy-middleware');

const userRouter = require('./router/user-router');
const restaurantRouter = require('./router/restaurant-router');
const commentRouter = require('./router/comment-router');

var options = {
    target: "http://apis.juhe.cn",
    changeOrigin: true,
    ws: true,
    pathRewrite:{
        
    },
    router:{
        'dev.localhost:8081':'http://localhost:8081'
    }
};
var Proxy = proxy(options);
//set express server
const app = express();
app.use(bodyParser.json());
app.use(morgan('dev'));
app.use(cors());

app.use('/cook/query.php',Proxy);

//add router
app.use('/user',userRouter);
app.use('/restaurant',restaurantRouter);
app.use('/comment',commentRouter);

app.listen(process.env.PORT || 8081);