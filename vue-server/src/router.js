import Vue from "vue";
import Router from "vue-router";
import Around from "./views/AroundMap.vue";
import Login from "./components/Login.vue";
import Register from "./components/Register.vue";
import Restaurant from "./components/RestaurantList.vue";
import addRes from "./components/addRestaurant.vue";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/around",
      name: "Around",
      component: Around
    },
    {
      path: "/login",
      name: "login",
      component: Login
    },
    {
      path: "/register",
      name: "register",
      component: Register
    },
    {
      path: "/restaurant",
      name: "restaurant",
      component: Restaurant
    },
    {
      path: "/restaurant/add",
      name: "addres",
      component: addRes
    },
    {
      path: "/",
      name: "about",
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () =>
        import(/* webpackChunkName: "about" */ "./views/About.vue")
    }
  ]
});
