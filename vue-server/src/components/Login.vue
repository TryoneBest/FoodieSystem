<template>
    <div id="login">
        <h1>Welcome to our app!</h1>
        <div class="login-model">
            <div class="user-name">
                <input class="text" type="text" placeholder="Username" v-model="username">
                <p v-if="this.username.length > 0 && usernameInvalid">用户名只能由大小写字母和数字组成。</p>
            </div>
            <div class="user-password">
                <input class="pass" type="password" placeholder="Password" v-model="password">
            </div>
            <div class="buttons">
                <button class="confirm" @click="confirmLogin">Login</button>
                <button class="register" @click="setNewuser">Register</button>
            </div>
        </div>
    </div>
</template>

<script>
import UserService from '../service/user';
export default {
    name:'login',
    data() {
        return {
            username: '',
            password: '',
        }
    },
    components: {
    },
    mounted(){
        if(this.$store.state.user != null){
            window.alert('you have login already!');
            this.$router.push('/');
        }
    },
    computed: {
        usernameInvalid() {
            return !(this.username.match(/^[a-zA-Z0-9]+$/));
        },
    },
    methods: {
        async confirmLogin(){
            // TODO we can do a shake animation here.
            if(this.usernameInvalid) {
                alert('用户名格式不正确');
                return;
            }
            this.username = this.username.trim();
            this.password = this.password.trim();
            if(this.username == '' || this.password == ''){
                window.alert("Your user name or password can't be null!");
            } else {
                const response = await UserService.userLogin(this.username, this.password);
                if(response.data.success){
                    this.$store.commit('setUser', response.data.uid);
                    window.alert('login success!');
                    this.$router.push('/');
                }
            }
        },
        async setNewuser(){
            this.$router.push('/register');
        }
    }
}
</script>


<style scoped>
#login {
    font-family: monospace;
    text-align: center;
    color:teal;
    margin-top: 100px;
}
input {
    background-repeat: no-repeat;
    width: 200px;
    height: 40px;
    border: 1px solid #e0dede;
    padding-left: 50px;
	outline: none;
    font-family: monospace;
    margin-top: 10px;
}
button {
    margin-top: 30px;
    margin-left: 20px;
    margin-right: 20px;
    text-align: center;
    text-decoration: #e0dede;
    width: 100px;
    height: 50px;
    border-radius: 15px;
    font-family: monospace;
}
.text{
    background-image: url(../assets/user_name.png);
}
.pass {
    background-image: url(../assets/user_password.png);
}
.confirm {
    background-color: crimson;
}
</style>
