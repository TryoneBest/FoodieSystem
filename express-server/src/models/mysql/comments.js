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

async function addComment(uid,rid,title,content){
    var con;
    try{
        con = await pool.aGet();
        await pool.aQuery(con, 'call add_comment(' + 
            con.escape(uid) + ',' + 
            con.escape(rid) + ',' + 
            con.escape(title) + ',' +
            con.escape(content) + ',@cid);');
        var res = await pool.aQuery(con, 'select @cid;');
        if(res.length > 0 && res[0]['@cid'] > 0){
            return { cid: res[0]['@cid'], success: true};
        } else {
            return { success: false};
        }
    }catch(err){
        console.error('[Error][MySQL] add comment failed');
        throw err;
    } finally{
        pool.release(con);
    }
}

module.exports = {
    getComment,
    addComment
}