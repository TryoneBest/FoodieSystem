const pool = require('./db');

async function userLogin(username, password){
    var con;
    try{
        con = await pool.aGet();
        await pool.aQuery(con, 'call user_login(' +con.escape(username)+ ', '+con.escape(password)+', @uid);');
        res = await pool.aQuery(con, 'select @uid;');
        if(res.length > 0 && res[0]['@uid'] > 0){
            return { uid: res[0]['@uid'], success: true}; //login success
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

async function userRegister(username, password){
    var con;
    try{
        con = await pool.aGet();
        await pool.aQuery(con, 'call user_register(' + con.escape(username) + ',' + con.escape(password) + ', @uid);');
        res = await pool.aQuery(con, 'select @uid;');
        if(res.length > 0 && res[0]['@uid'] > 0){
            return { uid: res[0]['@uid'], success: true};
        } else{
            return null;
        }
    } catch(err){
        if(err.code == 'ER_DUP_ENTRY'){
            return {
                msg: 'username has been used',
                success: false
            };
        }
        console.error('[Error][MySQL] register failed.', username, password);
        throw err;
    } finally{
        pool.release(con);
    }
}
module.exports = {
    userLogin,
    userRegister
}