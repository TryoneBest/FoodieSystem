const express = require('express');
const restaurant = require('../models/mysql/restaurant');

const router = express.Router();
router.get('/', async (req,res) => {
    try{
        var data = await restaurant.getReslist();
        res.send({
            success: true,
            data: data
        });
    } catch(err){
        res.send({ success: false });
    }
});

router.post('/mapsearch', async (req,res) => {
    try{
        //console.log('TEST TEST TEST : ' + req.body.lat);
        var data = await restaurant.searchRestaurant(req.body.name, req.body.lng, req.body.lat);
        res.send({
            success: true,
            data: data
        });
    } catch(err){
        res.send({ success : false });
    }
});

router.post('/addres', async (req,res) => {
    try {
        var data = await restaurant.addRestaurant(req.body.name, req.body.address, req.body.city, req.body.lng, req.body.lat);
        res.send({
            success: true,
            data: data
        });
    } catch(err) {
        res.send({ success : false });
    }
});

module.exports = router;