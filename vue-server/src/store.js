import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    UserStatus: false
  },
  mutations: {
    UserStatusReversion: state => {
      if(state.UserStatus === false){
        state.UserStatus = true;
      }else{
        state.UserStatus = false;
      }
    }
  },
  actions: {}
});
