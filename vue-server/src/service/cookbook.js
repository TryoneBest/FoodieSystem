//import axios from 'axios'
import api from './api'
export default {
    getcookbook(name){
        var key="1b94094722c61ec7762c83f5ed1e18a2";
        var cmd= "?menu=" + name + "&key=" + key;
        return api().get('/cook/query.php' + cmd);
    }
}