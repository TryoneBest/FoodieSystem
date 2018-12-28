import api from './api'

export default {
    getReslist(){
        return api().get('/restaurant');
    },
    searchRestaurant(name, lng, lat){
        return api().post('/restaurant/mapsearch',{
            name,
            lng,
            lat
        });
    },
    addRestaurant(params){
        return api().post('/restaurant/addres', params);
    }
}