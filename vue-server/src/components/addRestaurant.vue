<template>
    <div id="addrestaurant">
        <h1>Add Restaurant</h1>
        <div class="addmodel">
            <div class="name">
                <input class="text" readonly="readonly" v-model="restaurant.name">
            </div>
            <div class="address">
                <input class="text" readonly="readonly" v-model="restaurant.address">
            </div>
            <div class="city">
                <input class="text" readonly="readonly" v-model="restaurant.city">
            </div>
            <div class="lng">
                <input class="text" readonly="readonly" v-model="restaurant.lng">
            </div>
            <div class="lat">
                <input class="text" readonly="readonly" v-model="restaurant.lat">
            </div>
            <div class="addbutton">
                <button class="confirm" @click="confirmAdd">Confirm</button>
            </div>
        </div>
    </div>
</template>

<script>
import RestaurantService from '../service/restaurant';
export default {
    name: "addres",
    data() {
        return {
            restaurant:{}
        }
    },
    mounted() {
        this.setRes();
    },
    methods: {
        setRes() {
            this.restaurant = {
                name: this.$route.params.name,
                address: this.$route.params.address,
                city: this.$route.params.city,
                lng: this.$route.params.lng,
                lat: this.$route.params.lat
            };
        },
        async confirmAdd(){
            const res = await RestaurantService.addRestaurant(this.restaurant);
            if(res.data.success){
                window.alert("add restaurant success.rid: " + res.data.data);
            }
        }
    }
}
</script>

<style>
#addrestaurant {
    font-family: monospace;
    text-align: center;
    color:teal;
    margin-top: 100px;
}
input {
    background-repeat: no-repeat;
    width: 400px;
    height: 40px;
    border: 1px solid #e0dede;
    padding-left: 50px;
	outline: none;
    font-family: monospace;
    margin-top: 10px;
}
.confirm {
    margin-top: 30px;
    margin-left: 20px;
    margin-right: 20px;
    text-align: center;
    text-decoration: #e0dede;
    width: 100px;
    height: 50px;
    border-radius: 15px;
    font-family: monospace;
    background-color: crimson;
}
</style>
