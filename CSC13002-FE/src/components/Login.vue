<template>
    <div class="container-fluid">
        <div class="form">
            <div class="text-center">
                <h6><span>Đăng nhập</span> <span>Đăng ký</span></h6>
                <input @click="onFlip" type="checkbox" class="checkbox" id="reg-log" />
                <label for="reg-log"></label>
                <div class="card-3d-wrap">
                    <div class="card-3d-wrapper">
                        <!-- card front -->
                        <div class="card-front">
                            <div class="center-wrap">
                                <h4 class="heading">Đăng nhập</h4>
                                <div class="form-group">
                                    <input :value="userNameInput" @input="onUserNameInput" type="text"
                                        class="form-style" placeholder="Tên đăng nhập" />
                                    <i class="input-icon material-icons">person</i>
                                </div>
                                <div class="form-warning">
                                    {{ userNameWarning }}
                                </div>
                                <div class="form-group">
                                    <input :value="passwordInput" @keyup.enter="onLogin" @input="onPasswordInput"
                                        type="password" class="form-style" placeholder="Mật khẩu" />
                                    <i class="input-icon material-icons">lock</i>
                                </div>
                                <div class="form-warning">
                                    {{ passwordWarning }}
                                </div>
                                <button href="#" class="btn" @click="onLogin">
                                    Xong
                                </button>
                                <p class="text-center">
                                    <a href="#" class="link">Quên mật khẩu</a>
                                </p>
                            </div>
                        </div>
                        <!-- card back -->
                        <div class="card-back">
                            <div class="center-wrap">
                                <h4 class="heading">Đăng ký</h4>
                                <div class="form-group">
                                    <input :value="userNameInput" @input="onUserNameInput" type="text"
                                        class="form-style" placeholder="Tên đăng nhập" />
                                    <i class="input-icon material-icons">person</i>
                                </div>
                                <div class="form-warning">
                                    {{ userNameWarning }}
                                </div>
                                <div class="form-group">
                                    <input :value="passwordInput" @input="onPasswordInput" type="password"
                                        class="form-style" placeholder="Mật khẩu" />
                                    <i class="input-icon material-icons">lock</i>
                                </div>
                                <div class="form-warning">
                                    {{ passwordWarning }}
                                </div>
                                <div class="form-group">
                                    <input :value="passwordReinput" @input="onPasswordReinput" @keyup.enter="onSignup"
                                        type="password" class="form-style" placeholder="Nhập lại mật khẩu" />
                                    <i class="input-icon material-icons">lock</i>
                                </div>
                                <div class="form-warning">
                                    {{ rePasswordWarning }}
                                </div>
                                <button href="#" class="btn" @click="onSignup">
                                    Xong
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script scoped>
import { app } from '../main';
const bcryptjs = require('bcryptjs');

export default {
    name: 'Login-Register',
    // data: variables
    data() {
        return {
            userNameInput: '',
            passwordInput: '',
            passwordReinput: '',

            userNameWarning: '',
            passwordWarning: '',
            rePasswordWarning: '',

            isUserNameOk: false,
            isPasswordOk: false,
            isRepasswordOk: false,

            public_accountList: [],
        };
    },
    beforeMount() {
        this.getAccountAll();
    },
    // methods: functions
    methods: {
        onUserNameInput(e) {
            this.userNameInput = e.target.value;
            if (!/^[A-Za-z]\w{3,120}$/.test(this.userNameInput)) {
                this.userNameWarning = '⚠ Tên đăng nhập không hợp lệ';
                this.isUserNameOk = false;
            } else {
                this.userNameWarning = '';
                this.isUserNameOk = true;
            }
        },

        onPasswordInput(e) {
            this.passwordInput = e.target.value;
            if (!/^.{6,}$/.test(this.passwordInput)) {
                this.passwordWarning = '⚠ Mật khẩu không hợp lệ';
                this.isPasswordOk = false;
            } else {
                this.passwordWarning = '';
                this.isPasswordOk = true;
            }

            if (this.passwordReinput.localeCompare(this.passwordInput) != 0) {
                this.rePasswordWarning = '⚠ Mật khẩu không khớp';
                this.isRepasswordOk = false;
            } else {
                this.rePasswordWarning = '';
                this.isRepasswordOk = true;
            }
        },

        onPasswordReinput(e) {
            this.passwordReinput = e.target.value;
            if (this.passwordReinput.localeCompare(this.passwordInput) != 0) {
                this.rePasswordWarning = '⚠ Mật khẩu không khớp';
                this.isRepasswordOk = false;
            } else {
                this.rePasswordWarning = '';
                this.isRepasswordOk = true;
            }
        },

        onFlip() {
            this.userNameInput = '';
            this.passwordInput = '';
            this.passwordReinput = '';

            this.userNameWarning = '';
            this.passwordWarning = '';
            this.rePasswordWarning = '';

            this.isUserNameOk = false;
            this.isPasswordOk = false;
            this.isRepasswordOk = false;
        },

        getAccountAll() {
            fetch(this.base_url + '/taikhoan/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_accountList = api.data.map((std) => std);
                });
        },

        onLogin() {
            if (this.isUserNameOk && this.isPasswordOk) {
                let userName = this.userNameInput;
                let pass = this.passwordInput;
                let thisClone = this;
                let appClone = app;
                let accounts = this.public_accountList.find((acc) => {
                    return acc.tendangnhap === userName;
                });
                if (accounts === undefined || !pass) {
                    alert('Tài khoản không tồn tại!');
                } else {
                    bcryptjs.compare(
                        pass,
                        accounts.matkhau,
                        function (err, res) {
                            if (res) {
                                alert('Đăng nhập thành công!');
                                appClone.config.globalProperties.gUserName =
                                    userName;
                                appClone.config.globalProperties.gUserType =
                                    parseInt(accounts.loaitk);
                                thisClone.onFlip();
                                thisClone.$router.push('/home');
                            } else {
                                alert('Mật khẩu không chính xác');
                            }
                        }
                    );
                }
            }
        },

        async onSignup() {
            if (this.isUserNameOk && this.isPasswordOk && this.isRepasswordOk) {
                let userName = this.userNameInput;
                let pass = this.passwordInput;
                if (!pass || !userName) {
                    alert('Tên đăng nhập và Mật khẩu không được trống!');
                } else {
                    const salt = bcryptjs.genSaltSync(10);
                    let hash = bcryptjs.hashSync(pass, salt);

                    if (this.public_accountList.length === 0) {
                        const user = {
                            MATK: 'TK001',
                            TENDANGNHAP: userName,
                            MATKHAU: hash,
                            LOAITK: 3,
                        };
                        const new_user = JSON.stringify(user);
                        const res = await fetch(
                            this.base_url + `/taikhoan/create?data=${new_user}`
                        );
                        const data = res.json();
                        console.log(data);
                        alert('Tạo tài khoản thành công');
                        this.getAccountAll();
                        return;
                    }
                    else {
                        let sentinel = this.public_accountList[0].matk;
                    for (let i = 1; i < this.public_accountList.length; i++) {
                        const element = this.public_accountList[i];
                        if (sentinel < element.matk) sentinel = element.matk;
                    }
                    let last_id = sentinel;
                    last_id = String(last_id).substring(2, 5);
                    last_id = parseInt(last_id) + 1;
                    if (last_id < 10) last_id = '00' + String(last_id);
                    else if (last_id >= 10 && last_id <= 99)
                        last_id = '0' + String(last_id);
                    else last_id = String(last_id);

                    let accounts = this.public_accountList.find((acc) => {
                        return acc.tendangnhap === userName;
                    });
                    if (accounts != undefined) {
                        alert('Tài khoản đã tồn tại');
                        return;
                    }
                    const user = {
                        MATK: 'TK' + last_id,
                        TENDANGNHAP: userName,
                        MATKHAU: hash,
                        LOAITK: 0,
                    };
                    const new_user = JSON.stringify(user);
                    const res = await fetch(
                        this.base_url + `/taikhoan/create?data=${new_user}`
                    );
                    const data = res.json();
                    console.log(data);
                    alert('Tạo tài khoản thành công');
                    this.getAccountAll();
                    }
                }
            }
        },
    },
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/icon?family=Material+Icons');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.container-fluid {
    font-family: 'Josefin Sans', sans-serif;
    letter-spacing: 1px;
    background: var(--body-color);
    background-attachment: fixed;
    background-size: 100% 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.container-fluid a {
    text-decoration: none;
}

.container-fluid .text-center {
    text-align: center;
}

.container-fluid input[type='checkbox'] {
    display: none;
}

.container-fluid h4 {
    font-weight: 600;
    color: var(--text-color);
}

.container-fluid h6 {
    margin-bottom: 30px;
    color: var(--text-color);
}

.container-fluid h6 span {
    padding: 0 20px;
    text-transform: uppercase;
    font-weight: 700;
    font-size: 16px;
}

.container-fluid .checkbox:checked+label,
.container-fluid .checkbox:not(:checked)+label {
    position: relative;
    display: block;
    width: 60px;
    height: 16px;
    background: var(--primary-color);
    border-radius: 8px;
    margin: 10px auto;
    cursor: pointer;
}

.container-fluid .checkbox:checked+label::before,
.container-fluid .checkbox:not(:checked)+label::before {
    position: absolute;
    display: block;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    color: var(--primary-color);
    background-color: var(--text-color);
    top: -10px;
    left: -10px;
    font-family: 'Material Icons';
    content: '\f1e2';
    line-height: 36px;
    text-align: center;
    font-size: 24px;
    transition: all 0.5s ease;
}

.container-fluid .checkbox:checked+label::before {
    transform: translateX(44px) rotate(-270deg);
}

.container-fluid .card-3d-wrap {
    position: relative;
    width: 400px;
    max-width: 100%;
    height: 400px;
    transform-style: preserve-3d;
    perspective: 800px;
    margin-top: 60px;
}

.container-fluid .card-3d-wrapper {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    transform-style: preserve-3d;
    transition: all 600ms ease-out;
}

.container-fluid .card-front,
.container-fluid .card-back {
    width: 100%;
    height: 100%;
    background-color: var(--sidebar-color);
    background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/1462889/pat.svg');
    background-position: bottom center;
    background-repeat: no-repeat;
    background-size: 300%;
    position: absolute;
    border-radius: 6px;
    left: 0;
    top: 0;
    transform-style: preserve-3d;
    backface-visibility: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.container-fluid .card-back {
    transform: rotateY(180deg);
}

.container-fluid .checkbox:checked~.card-3d-wrap .card-3d-wrapper {
    transform: rotateY(180deg);
}

.container-fluid .center-wrap {
    position: absolute;
    width: 100%;
    padding: 0 35px;
    top: 50%;
    left: 0;
    transform: translate3d(0, -50%, 35px) perspective(100px);
    z-index: 20;
    display: block;
}

.container-fluid .heading {
    margin-bottom: 30px;
    font-size: 24px;
}

.container-fluid .form-group {
    position: relative;
    display: block;
    margin-bottom: 12px;
}

.container-fluid .form-warning {
    color: var(--warning-color);
    font-size: 12px;
    font-weight: 700;
    padding-bottom: 10px;
}

.container-fluid .form-style {
    padding-left: 55px;
    height: 48px;
    width: 100%;
    font-weight: 500;
    border-radius: 4px;
    font-size: 14px;
    line-height: 22px;
    letter-spacing: 0.5px;
    outline: none;
    background: var(--body-color);
    color: var(--text-color);
    border: none;
    box-shadow: 0 4px 8px 0 rgba(21, 21, 21, 0.2);
    transition: all 200ms linear;
}

.container-fluid .form-style:focus,
.container-fluid .form-style:active {
    border: none;
    outline: none;
    box-shadow: 0 4px 8px 0 rgba(21, 21, 21, 0.2);
}

.container-fluid .input-icon {
    position: absolute;
    top: 0;
    left: 18px;
    height: 48px;
    font-size: 24px;
    line-height: 48px;
    color: var(--primary-color);
    text-align: left;
}

.container-fluid .form-group input::placeholder {
    color: var(--text-color);
    opacity: 0.7;
    transition: all 200ms linear;
}

.container-fluid .form-group input:focus::placeholder {
    opacity: 0;
}

.container-fluid .btn {
    height: 44px;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    text-transform: uppercase;
    padding: 0 30px;
    letter-spacing: 1px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border: none;
    background: var(--primary-color);
    color: #ffffff;
    margin-top: 15px;
    /* box-shadow: 0 8px 24px 0 rgba(228, 104, 10, 0.2); */
    transition: all 200ms linear;
}

.container-fluid .btn:hover {
    background: var(--selected-hover-color);
    box-shadow: 0 8px 24px 0 rgba(138, 140, 146, 0.2);
}

/* Forgot password */
.container-fluid .link {
    color: var(--text-color);
    margin-top: 20px;
    display: block;
}

.container-fluid .text-normal {
    color: var(--text-color);
    margin-top: 20px;
    display: block;
}

.container-fluid .link-normal {
    color: var(--text-color);
    display: inline;
}

.container-fluid .link-normal:hover {
    color: var(--primary-color);
}

.container-fluid .link:hover {
    color: var(--primary-color);
}
</style>
