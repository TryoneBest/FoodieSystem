<template>
    <div id="restaurantList">
        <h1>Restaurant</h1>
        <div>
            <p v-if="!hasRestaurant">There is no restaurants in db, try to find your restaurant in the map and add one.</p>
        </div>
        <div v-if="hasRestaurant" class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th width="100">Rid</th>
                        <th width="300">Name</th>
                        <th width="150">City</th>
                        <th width="300">Address</th>
                        <th width="150">lng</th>
                        <th width="150">lat</th>
                        <th width="150" class="res-action-cell">Action</th>
                    </tr> 
                </thead>
                <tbody>
                    <tr v-for="Restaurant in Restaurants" :key="Restaurant.restaurant_id">
                        <td>{{ Restaurant.restaurant_id }}</td>
                        <td>{{ Restaurant.restaurant_name }}</td>
                        <td>{{ Restaurant.city_name }}</td>
                        <td>{{ Restaurant.address }}</td>
                        <td>{{ Restaurant.lng }}</td>
                        <td>{{ Restaurant.lat }}</td>
                        <td class="res-action-cell">
                            <router-link :to="{ name: 'restaurantCheck', params:{id: Restaurant.restaurant_id,name : Restaurant.restaurant_name,address: Restaurant.address}}">check</router-link>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
import RestaurantService from '../service/restaurant';
export default {
    name: 'restaurantList',
    data(){
        return {
            mapres: {},
            Restaurants: [],
            loading: true
        }
    },
    computed: {
        hasRestaurant(){
            return this.loading || this.Restaurants.length > 0;
        }
    },
    mounted(){
        if(this.$route.params.name != null){
            //console.log(this.$route.params.name, this.$route.params.lng, this.$route.params.lat);
            this.mapres = {
                name : this.$route.params.name,
                address : this.$route.params.address,
                city : this.$route.params.city,
                lng : this.$route.params.lng,
                lat : this.$route.params.lat
            }
            this.searchRestaurant(this.$route.params.name, this.$route.params.lng, this.$route.params.lat);
        } else{
            this.getRestaurants();
        }
    },
    methods: {
        async getRestaurants(){
            const response = await RestaurantService.getReslist();
            this.loading = false;
            //console.log(response.data.data);
            if(response.data.success){
                this.Restaurants = response.data.data;
            } else{
                window.alert("get the restaurants failed.");
            }
            //console.log(response.data.data);
        },
        async searchRestaurant(name, lng, lat){
            const response = await RestaurantService.searchRestaurant(name, lng, lat);
            if(response.data.success){
                if(!(response.data.data.length > 0)){
                    window.alert("There is no such restaurant in db, try to find in the map and add one");
                    this.$router.push('/around');
                } else{
                    this.Restaurants = response.data.data;
                }
            } else{
                window.alert("search the restaurant failed.");
            }
        }
    },
}
</script>

<style>
#restaurantList {
    font-family: monospace;
    text-align: center;
    color:teal;
    margin-top: 100px;
}
.res-action-cell {
	text-align: center;
}
table {
	margin: 0 auto;
	text-align: center;
	font-family: monospace;
}
tbody tr:nth-child(even) {
	background: #f2f2f2;
}
td, th {
	text-align: left;
	padding: 10px;
}
th {
	background: #4d7ef7;
	color: #fff;
	font-size: 16px;
}
a {
    text-decoration: none;
}
.add_res_link {
	background: #4d7ef7;
	color: #fff;
	padding: 10px 80px;
	text-transform: uppercase;
	font-size: 12px;
	font-weight: bold;
}
</style>
