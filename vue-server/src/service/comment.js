import api from './api.js'

export default {
    getComment(rid){
        return api().get('/comment/' + rid);
    }
}