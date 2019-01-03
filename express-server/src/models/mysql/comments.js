const pool = require('./db');

async function getComment(rid){
    var con;
    try{
        con = await pool.aGet();
        var cmd = "select * from v_content_user where rid =" + con.escape(rid) + ";";
        var res = await pool.aQuery(con, cmd);
        return res;
    } catch(err){
        console.error("[Error][MySQL] get comment failed");
        throw err;
    } finally {
        pool.release(con);
    }
}

module.exports = {
    getComment
}