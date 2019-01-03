const pool = require('./db');

async function getReslist(){
    var con;
    try{
        con = await pool.aGet();
        var cmd = "select * from `foodie_system`.`restaurant`";
        var res = await pool.aQuery(con, cmd);
        return res;
    } catch(err){
        console.log('[Error] get restaurant failed', cmd);
        throw err;
    }finally{
        pool.release(con);
    }
}

async function searchRestaurant(name, lng, lat){
    var con;
    try{
        con = await pool.aGet();
        //console.log('[ERROR]' +  con.escape(name));
        var cmd = "select * from `foodie_system`.`restaurant` where restaurant_name=" + con.escape(name) + " and lng=" + con.escape(lng) + " and lat=" + con.escape(lat) +";";
        //console.log(cmd);
        var res = await pool.aQuery(con,cmd);
        return res;
    } catch(err){
        console.log('[Error] search restaurant by lng and lat failed', cmd);
        throw err;
    } finally{
        pool.release(con);
    }
}

async function addRestaurant(name, address, city, lng, lat){
    var con;
    try {
        con = await pool.aGet();
        var cmd = "call add_restaurant(" + con.escape(name) + ',' + con.escape(address) + ',' + 
            con.escape(city) + ',' + con.escape(lng) + ',' + con.escape(lat) + ',@rid);';
        await pool.aQuery(con,cmd);
        var res = await pool.aQuery(con,"select @rid");
        if(res.length > 0 && res[0]['@rid'] > 0){
            return res[0]['@rid'];
        } else{
            return null;
        }
    } catch(err) {
        console.log('[Error] add restaurant error');
        throw err;
    } finally {
        pool.release(con);
    }
}

async function getMenu(rid){
    var con;
    try {
        con = await pool.aGet();
        var cmd = "select * from food where rid=" + con.escape(rid) + ";";
        var res = await pool.aQuery(con,cmd);
        return res;
    } catch(err) {
        console.log('[Error] get menu error');
        throw err;
    } finally {
        pool.release(con);
    }
}

module.exports = {
    getReslist,
    searchRestaurant,
    addRestaurant,
    getMenu
}