<template>
    <div class="Menu">
        <div class="restaurantContent">
            <h1>{{restaurant.name}}</h1>
            <h2>{{restaurant.address}}</h2>
            <input type="button" value="back" @click="back" class="menuclick">
        </div>
        <div>
            <table>
                <tbody>
                    <tr v-for="menu in menuList" :key="menu.food_id">
                        <td width="100">{{ menu.food_id }}</td>
                        <td width="300">{{ menu.food_name }}</td>
                        <td calss="res-action-cell" width="100">
                            <router-link :to="{name:'cookbook' ,params: {food_name: menu.food_name,
                                id: restaurant.id, name: restaurant.name, address: restaurant.address}}">cookbook</router-link>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
import RestaurantService from '../service/restaurant';
import restaurant from '../service/restaurant';
export default {
    data(){
        return {
            loading : true,
            menuList:[],
            restaurant: {
                id: this.$route.params.id,
                name: this.$route.params.name,
                address: this.$route.params.address
            }
        }
    },
    computed: {
        hasmenu(){
            return this.loading || this.menuList.length > 0;
        }
    },
    mounted(){
        this.getMenu(this.$route.params.id);
    },
    methods:{
        async getMenu(rid){
            const res = await RestaurantService.getMenu(rid);
            if(res.data.success){
                this.menuList = res.data.data;
                this.loading = false;
            } else{
                window.alert('get menu failed');
                this.$router.push('/around');
            }
        },
        back(){
            this.$router.push({name:"restaurantCheck",params:this.restaurant});
        }
    }
}
</script>

<style>

</style>
