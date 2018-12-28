<template>
    <div id="register">
        <h1>register</h1>
        <div>
            <div>
                <input class="noimage" placeholder="username" v-model="table.username">
                <p v-if="table.username.length > 0 && usernameInvalid">{{ warning.username }}</p>
            </div>
            <div>
                <input class="noimage" placeholder="password" v-model="table.pass" type="password">
                <p v-if="table.pass.length > 0 && passInvalid">{{ warning.pass }}</p>
            </div>
            <div>
                <input class="noimage" placeholder="repeat password" v-model="table.repeatPass" type="password">
                <p v-if="table.repeatPass.length > 0 && passNotMatch">{{ warning.repeatPass }}</p>
            </div>
            <div>
                <p v-if="loading">载入中... </p>
            </div>
            <button class="commit" @click="commitClick">Commit</button>
        </div>
    </div>
</template>

<script>
import UserService from '../service/user';
// TODO check username and email availability before a commit.
export default {
    name: "register",
    data(){
        return{
            table: {
                username: '',
                pass: '',
                repeatPass: ''
            },
            word: {
                username: '用户名',
                pass: '密码',
                repeatPass: '重复密码',
            },
            warning: {
                username: '用户名只能由大小写字母和数字组成。',
                pass: '密码只能由大小写字母和数字和六个特殊字符(%$-_=&)组成，密码长度在6到20之间。',
                repeatPass: '两组密码不相符。',
            },
            loading: false,
        }
    },
    computed: {
        usernameInvalid() {
            return !(this.table.username.match(/^[a-zA-Z0-9]+$/));
        },
        passInvalid() {
            return !(this.table.pass.match(/^[a-zA-Z0-9%-_=&$]{6,20}$/));
        },
        passNotMatch() {
            return this.table.pass != this.table.repeatPass;
        }
    },
    methods: {
        async commitClick() {
            if(this.loading) {
                alert('正在通讯中，请勿重复提交。')
                return;
            }
            var alertText = '';
            for(var keyName in this.table) {
                this.table[keyName] = this.table[keyName].trim();
                if(!this.table[keyName]) {
                    alertText += this.word[keyName] + '不能为空。\n';
                }
            }
            if(this.usernameInvalid || this.passNotMatch || this.passInvalid ) {
                alertText += '表格填写有错误，不能提交。\n';
            }
            if(alertText) {
                alert(alertText);
                return;
            }
            this.loading = true;
            var res = await UserService.userRegister(this.table.username, this.table.pass);
            this.loading = false;
            if(res.data && res.data.success) {
                alert('注册成功');
                this.$store.commit('setUser', res.data.uid);
                this.$router.push('/');
            } else {
                if(res.data.msg) {
                    alert('注册失败\n' + res.data.msg);
                } else {
                    alert('注册失败');
                }
            }
        }
    }
}
</script>


<style scoped>
#register {
    font-family: monospace;
    text-align: center;
    color:teal;
    margin-top: 100px;
}
.noimage{
    padding-left: 10px;
    width: 240px;
}
.commit {
    background-color: darkgray;
    height: 40px;
    width: 240px; 
}
.error-alert {
    color:crimson;
    font-size: 12px;
}
</style>
