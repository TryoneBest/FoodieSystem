import api from './api'

export default {
    userLogin(username, pass){
        return api().post('/user/login',{
            username,
            pass
        });
    }
}