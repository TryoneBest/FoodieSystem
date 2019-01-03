<template>
    <div class="Cookbook">
        <div class="restaurantContent">
            <h1>{{ foodname }}</h1>
            <input type="button" value="back" @click="back" class="click">
        </div>
        <div v-if="!hascookbook">
            <h1>there is no cookbook</h1>
        </div>
        <div v-if="hascookbook" style="text-align=center">
            <table>
                <tbody>
                    <tr v-for="cook in cookbook" :key="cook.id">
                        <td>{{ cook.title }}</td>
                        <td>{{ cook.tags }}</td>
                        <td>{{ cook.imtro }}</td>
                        <td>{{ cook.ingredients }}</td>
                        <td>{{ cook.burden }}</td>
                        <td v-for="step in cook.steps" :key="step.step"><span>{{ step.step }}</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
import cookService from '../service/cookbook'
export default {
    data(){
        return {
            loading:true,
            foodname: this.$route.params.food_name,
            restaurant:{
                id: this.$route.params.id,
                name: this.$route.params.name,
                address: this.$route.params.address
            },
            cookbook:[],
        }
    },
    computed:{
        hascookbook(){
            return this.loading || this.cookbook.length > 0
        }
    },
    mounted(){
        this.getcookbook(this.foodname);
    },
    methods:{
        back(){
            this.$router.push({name:"restaurantMenu",params:this.restaurant})
        },
        async getcookbook(name) {
            
            var res = await cookService.getcookbook(name);
            if(res.data.reason == "Success"){
                this.cookbook = res.data.result.data;
            } else{
                window.alert("can't find this food");
            }
        }
    }
}
</script>

<style>
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
</style>
