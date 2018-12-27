import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: null
  },
  mutations: {
    setUser: (state, uid) => {
      state.user = uid;
    },
    logoutUser: state => {
      state.user = null;
    }
  },
  actions: {}
});
