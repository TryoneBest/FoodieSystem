import api from './api'

export default {
    userLogin(username, pass){
        return api().post('/user/login',{
            username,
            pass
        });
    },
    userRegister(username, pass){
        return api().post('/user/register',{
            username,
            pass
        })
    }
}