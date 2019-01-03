<template>
    <div class="addcomment">
        <div class="addlabel">
            <h1>add comment for {{restaurant.name}}</h1>
        </div>
        <div class="title">
            <textarea placeholder="title" v-model="title" class="title"></textarea>
        </div>
        <div class="content">
            <textarea placeholder="content" v-model="content" class="content"></textarea>
        </div>
        <div >
            <input type="button" value="confirm" @click="confirmAdd" class="click">
        </div>
    </div>
</template>

<script>
import commentService from '../service/comment';
export default {
    data(){
        return{
            restaurant:{
                id: this.$route.params.id,
                name: this.$route.params.name,
                address: this.$route.params.address
            },
            title: null,
            content: null
        }
    },
    computed:{
        
    },
    methods:{
        async confirmAdd(){
            var sendData = {
                uid: this.$store.state.user,
                rid: this.restaurant.id,
                title: this.title,
                content: this.content
            };
            const res = await commentService.addComment(sendData);
            if(res.data.success){
                window.alert('comment success');
                this.$router.push({name: "restaurantCheck", params:this.restaurant});
            } else {
                window.alert('undefined fault');
            }
        },
    }
}
</script>

<style>
.addcomment{
    text-align: center
}
.content{
    height: 250px;
    width: 500px;
    margin-left: auto;
    margin-right: auto;
}
.title{
    height: 50px;
    width: 500px;
    margin-left: auto;
    margin-right: auto;
}
.click{
    text-align: center;
    margin-left: auto;
    margin-right: auto;
}
</style>
