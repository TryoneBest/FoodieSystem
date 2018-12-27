const pool = require('./db');

async function userLogin(username, password){
    var con;
    try{
        con = await pool.aGet();
        await pool.aQuery(con, 'call user_login(' +con.escape(username)+ ', '+con.escape(password)+', @uid);');
        res = await pool.aQuery(con, 'select @uid;');
        if(res.length > 0 && res[0]['@uid'] > 0){
            return res[0]['@uid']; //login success
        } else{
            return null; //login failed
        }
    } catch(err){
        console.error('[Error][MySQL] login failed.', username, password);
        throw err;
    } finally{
        pool.release(con);
    }
}

module.exports = {
    userLogin
}