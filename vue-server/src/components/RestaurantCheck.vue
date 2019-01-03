<template>
    <div class="restaurantCheck">
        <div class="restaurantContent">
            <h1>{{restaurant.name}}</h1>
            <h2>{{restaurant.address}}</h2>
            <input type="button" value="Menu" @click="gotoMenu" class="click">
            <input type="button" value="Add Comment" @click="addComment" class="click">
        </div>
        <div v-if="hascomment" class="comment">
            <table>
                <thead>
                    <tr>
                        <td width="100">id</td>
                        <td width="100">title</td>
                        <td width="500">comment</td>
                        <td width="200">datetime</td>
                        <td width="100">username</td>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="comment in comments" :key="comment.content_id">
                        <td >{{ comment.cid}}</td>
                        <td >{{ comment.title}}</td>
                        <td >{{ comment.comment}}</td>
                        <td >{{ comment.datetime }}</td>
                        <td >{{ comment.uname}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<script>
import commentService from '../service/comment';
import restaurant from '../service/restaurant';
export default {
    data(){
        return{
            loading: true,
            restaurant: {
                rid:this.$route.params.id,
                address: this.$route.params.address,
                name: this.$route.params.name
            },
            comments:[]
        };
    },
    computed: {
        hascomment(){
            return this.loading || this.comments.length > 0;
        }
    },
    mounted(){
        this.getComments(this.$route.params.id);
    },
    methods: {
        async getComments(rid){
            //console.log(rid);
            var response = await commentService.getComment(rid);
            if(response.data.success){
                this.comments = response.data.data;
                this.loading = false;
            }
        },
        gotoMenu(){
            this.$router.push({name:"restaurantMenu",params:{id: this.restaurant.rid, name: this.restaurant.name, address: this.restaurant.address}});
        },
        addComment(){
            if(this.$store.state.user != null){
                this.$router.push({name:"addComment", params:{id: this.restaurant.rid, name: this.restaurant.name, address: this.restaurant.address}});
            } else {
                window.alert('you must login at first');
                this.$router.push("/login");
            }
        }
    }
}
</script>

<style>
.restaurantContent {
    height: 170px;
    text-align: center;
}
.click {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
    font-size: 16px;
}
.click:hover{
    background-color: rgb(47, 110, 49)
}
table {
	margin: 0 auto;
	text-align: center;
	font-family: monospace;
}
tbody tr:nth-child(even) {
	background: #f2f2f2;
}
td {
	text-align: center;
	padding: 10px;
    color:rgb(4, 116, 116);
}
</style>
