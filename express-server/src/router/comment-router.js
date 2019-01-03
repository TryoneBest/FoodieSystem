const express = require('express');
const comment = require('../models/mysql/comments');

const router = express.Router();

router.get('/:rid',async (req,res) => {
    try {
        var data = await comment.getComment(req.params.rid);
        res.send({
            success: true,
            data: data
        })
    } catch(err) {
        res.send({success: false});
    }
});

module.exports = router;