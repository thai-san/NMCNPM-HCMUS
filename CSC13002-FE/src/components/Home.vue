<template>
    <!-- Home Tab -->
    <section id="hometab" class="home">
        <div class="left-panel">
            <div class="title">
                <h1 class="text-center">Xin chào, <span>{{ userName }}</span> !</h1>
                <p>Các chức năng bạn có thể thực hiện</p>
            </div>
            <div v-for="item in items" :key="item.title" class="card">
                <div class="card-body" style="font-size: 20px">
                    <h1 class="card-title">
                        {{ item.title }}
                    </h1>
                    <p class="card-text text-muted">
                        {{ item.content }}
                    </p>
                </div>
            </div>
        </div>
        <div class="right-panel">
            <div class="avatar">
                <h1>Thông tin tài khoản</h1>
                <h3>{{ getDuty }}</h3>
                <div class="avt-img">
                    <img id="show-img" src="img/logo_small.png" alt="Avatar" />
                </div>
                <div class="img-btn">
                    <label for="myFile" id="change"><i class='bx bx-check'></i><span>Sửa</span></label>
                    <input type="file" id="myFile" @change="loadFile($event)" hidden/>
                    <label for="myRemove" id="remove" @click="removeImg"><i class='bx bx-x'></i><span>Xoá</span></label>
                    <input type="button" id="myRemove" value="Gỡ" hidden>
                </div>
                <div class="input-container">
                    <div class="input-group">
                        <label for="username">Tên đăng nhập</label>
                        <input v-model="userName" id="username" name="username" disabled />

                        <label for="name">Tên đầy đủ</label>
                        <input id="name" type="text" />

                        <label for="phone">Số điện thoại</label>
                        <input id="phone" type="text" />
                    </div>
                </div>
            </div>
        </div>
    </section>

</template>

<script>

import myFunctions from '../assets/data/functions.json';

export default {
    name: 'HomeComponent',
    data() {
        return {
            userName : '',
            userType: -1,
            items: null
        }
    },
    beforeMount() {
        this.userName = this.gUserName;
        this.userType = parseInt(this.gUserType);
        this.items = myFunctions[this.userType];
    },
    computed: {
        getDuty() {
            if (this.userType === 0) {
                return 'Người dùng';
            } else if (this.userType === 1) {
                return 'Giáo viên';
            } else if (this.userType === 2) {
                return 'Giáo vụ';
            } else if (this.userType === 3) {
                return 'Quản lý';
            } else {
                return '';
            }
        }
    },
    methods: {
        removeImg() {
            let image = document.getElementById('show-img');
            image.src = 'img/favicon.png';
        },
        loadFile(e) {
            let image = document.getElementById('show-img');
            image.src = URL.createObjectURL(e.target.files[0]);
        }
    },
};
</script>

<style scoped>
.home {
    float: left;
    width: calc(100%);
    padding: 10px;
    margin-top: 20px;
    color: var(--text-color);
}


.left-panel {
    float: left;
    width: 50%;
    max-width: 50%;
}

.right-panel {
    float: left;
    width: 50%;
    /* max-width: 40%; */
}

.home:after {
    content: "";
    display: table;
    clear: both;
}

.left-panel .title {
    text-align: center;
    margin-bottom: 30px;
}

.left-panel .text-center {
    font-size: 30px;
}
.left-panel .text-center span {
    color: var(--primary-color);
}
.left-panel .title p {
    font-size: 20px;
    padding-top: 10px;
}

.card {
    text-align: left;
    background-color: var(--body-color);
    transition: var(--tran-05);
    padding: 30px;
    margin: 30px 0px;
    margin-left: auto;
    margin-right: auto;
    border: 2px solid var(--text-color);
    border-radius: 25px;
    height: 150px;
    width: 450px;
}

.card-body p {
    padding: 10px 0;
    text-align: justify;
    line-height: 1.5;
}

.avatar h1 {
    font-size: 30px;
    text-align: center;
}
.avatar h3 {
    margin: auto;
    width: 120px;
    padding: 10px 0px;
    font-size: 20px;
    color: var(--primary-color);
    text-align: center;
    border-bottom: 2px solid var(--text-color);
}

.input-container {
    display: flex;
    flex-direction: row;
    justify-content: center;
}

.input-group {
    display: flex;
    flex-direction: column;
    justify-content: center;
    margin: 30px 10px;
}

.input-group input {
    height: 40px;
    width: 300px;
    margin: 5px 0px 30px;
    font-size: 25px;
    padding-left: 10px;
    color: var(--text-color);
    background-color: var(--body-color);
    border: 2px solid var(--text-color);
    border-radius: 6px;
}

.img-btn {
    display: flex;
    justify-content: center;
}

#remove {
    margin-left: 30px;
    padding: 0 15px 0 10px;
    height: 40px;
    background-color: var(--remove-btn);
    color: #fff;
    border-radius: 20px;
    border-width: 0;
    display: flex;
    align-items: center;
    font-size: 20px;
}

#remove i{
    padding-right: 5px;
    font-size: 20px;
}

#change {
    padding: 0 15px 0 10px;
    height: 40px;
    background-color: var(--change-btn);
    color: #fff;
    border-radius: 20px;
    border-width: 0;
    display: flex;
    align-items: center;
    font-size: 20px;
}

#change i {
    padding-right: 5px;
    font-size: 20px;
}

#myFile {
    width: 5px;
}

#username {
    pointer-events: none;
    /* color: var(--hover-color);
    border-color: var(--hover-color); */
    opacity: 0.5;
}

#name, #phone {
    background: var(--sidebar-color);
}

.avt-img {
    text-align: center;
    margin: 10px;
}
.avatar img {
    width: 15rem;
    height: 15rem;
    margin: auto;
    border-radius: 50%;
}

.input-group label {
    font-size: 20px;
}

.avatar input {
    font-size: 20px;
}
</style> 