const express = require('express');
const user = require('../models/mysql/user');

const router = express.Router();

//set middleware here
//router.use(function(req,res,next) {next();});

router.post('/login',(request,response) => {
    user.userLogin(request.body.username, request.body.pass).then(data => {
        if(data){
            try{
                response.send(data);
            } catch(err){
                console.error('[Error][response] user-router response error!' + err);
                throw(err);
            }
        } else{
            response.send({ success : false });
        }
    }).catch(err => {
        response.send({ success : false });
    });
});

router.post('/register',(request,response) => {
    user.userRegister(request.body.username, request.body.pass).then(data => {
        response.send(data);
    }).catch(err => {
        response.send({success : false});
    })
});

module.exports = router;