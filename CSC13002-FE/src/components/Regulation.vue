<template>
    <!-- Regulation Tab -->
    <div class="nav-group">
        <a href="#" :class="currentTag === 0 ? 'nav-selected' : ''" @click="onTagClicked($event, 0)"><i
                class="bx bx-user-circle"></i> Cấp quyền tài khoản</a>
        <a href="#" :class="currentTag === 1 ? 'nav-selected' : ''" @click="onTagClicked($event, 1)"><i
                class="bx bx-wrench"></i> Thay đổi quy định</a>
    </div>
    <!-- Cấp quyền tài khoản -->
    <div class="tag-content" v-if="currentTag === 0">
        <div class="user">
            <div class="select-user">
                <span class="title">Cấp quyền</span>
                <select v-model="selected" name="user">
                    <option value="teacher">Giáo viên</option>
                    <option value="manager">Giáo vụ</option>
                </select>
            </div>
            <div class="btn-group">
                <button @click="cancel" id="remove">
                    <i class="bx bx-x"></i><span class="btn-text">Huỷ bỏ cấp quyền</span>
                </button>
                <button @click="confirm" id="change">
                    <i class="bx bx-check"></i><span class="btn-text">Xác nhận cấp quyền</span>
                </button>
            </div>
        </div>
        <div class="info-table">
            <table class="info">
                <tr>
                    <td><label>Họ và tên</label></td>
                    <td>
                        <label>{{ fullname }}</label>
                    </td>
                    <td rowspan="4">
                        <div class="avatar">
                            <img class="avatar-img" src="/img/logo_small.png" alt="" />
                            <span>Ảnh đại diện</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Tên đăng nhập</label></td>
                    <td>
                        <label>{{ username }}</label>
                    </td>
                </tr>
                <tr>
                    <td><label>Số điện thoại</label></td>
                    <td>
                        <label>{{ phone }}</label>
                    </td>
                </tr>
                <tr>
                    <td><label>Quyền hiện tại</label></td>
                    <td>
                        <label>{{ permission }}</label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="search-email">
            <div class="search-email-title">
                <span>Danh sách tài khoản</span>
                <div class="search-input"></div>
            </div>
            <div class="email-table">
                <table id="email-std">
                    <thead>
                        <th style="text-align: left">User</th>
                        <!-- <th style="text-align: left;">Tên</th> -->
                        <th style="text-align: center">Tài khoản</th>
                        <th></th>
                    </thead>
                    <tbody>
                        <tr v-for="acc in public_accountList" :key="acc.matk">
                            <td>{{ acc.tendangnhap }}</td>
                            <td hidden></td>
                            <td>{{ getLoaiTK(acc.loaitk) }}</td>
                            <td>
                                <button @click="userDetails($event, acc.matk)" id="change">
                                    Chọn
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Thay đổi quy định -->
    <div class="tag-content" v-if="currentTag === 1">
        <div class="title-reg">
            <span>Quy định hiện hành</span>
            <div class="btn-group">
                <button id="undo" @click="fetchToInput">
                    <i class="bx bx-undo"></i><span class="btn-text">Hủy thay đổi</span>
                </button>
                <button id="change" @click="regApply">
                    <i class="bx bx-check"></i><span class="btn-text">Hoàn tất sửa đổi</span>
                </button>
            </div>
        </div>
        <div class="notice">
            <p>
                ⚠ Lưu ý <br />
                Thay đổi quy định có thể làm ảnh hưởng trực tiếp đến dữ liệu của
                toàn bộ học sinh <br />
                Chỉ thay đổi quy định khi thực sự cần thiết và không nên thay
                đổi quy định quá thường xuyên <br />
            </p>
        </div>
        <div class="input-reg">
            <div class="input-group">
                <div class="group">
                    <label for="">Tuổi nhập học tối thiểu</label>
                    <input type="text" v-model="minAge" />
                </div>
                <div class="group">
                    <label for="">Tuổi nhập học tối đa</label>
                    <input type="text" v-model="maxAge" />
                </div>
                <div class="group">
                    <label for="">Sĩ số tối đa trong lớp</label>
                    <input type="text" v-model="maxStd" />
                </div>
                <div class="group">
                    <label for="">Điểm chuẩn đạt môn</label>
                    <input type="text" v-model="admMark" />
                </div>
                <div class="group">
                    <label class="title-btn" for="">Thay đổi số lượng và tên môn học</label>
                    <button @click="incompleteFeature">Thay đổi</button>
                </div>
                <div class="group">
                    <label class="title-btn" for="">Thay đổi số lượng lớp và tên lớp</label>
                    <button @click="incompleteFeature">Thay đổi</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'RegulationComponent',
    data() {
        return {
            currentTag: 0,

            public_accountList: [],
            public_regulationList: [],

            username: '',
            phone: '',
            permission: '',
            fullname: '',

            selected: '',
            // regulations
            minAge: null,
            maxAge: null,
            maxStd: null,
            admMark: null,
        };
    },
    beforeMount() {
        this.getAccountAll();
        this.getRegulations();
    },
    methods: {
        onTagClicked(e, param1) {
            let tagNumber = parseInt(param1);
            if (tagNumber >= 0 && tagNumber <= 1) {
                this.currentTag = tagNumber;
            }
        },
        getAccountAll() {
            fetch(this.base_url + '/taikhoan/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_accountList = api.data.map((std) => std);
                });
        },
        getRegulations() {
            fetch(this.base_url + '/quydinh/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_regulationList = api.data.map((dat) => dat);
                    this.fetchToInput();
                });
        },
        getLoaiTK(x) {
            let permission = '';
            if (x === 0) permission = 'Chưa cấp quyền';
            else if (x === 1) permission = 'Giáo viên';
            else if (x === 2) permission = 'Giáo vụ';
            else if (x === 3) permission = 'Quản trị';
            return permission;
        },
        userDetails(e, id) {
            let account = this.public_accountList.find((acc) => {
                return acc.matk === id;
            });
            if (account === undefined) {
                return;
            }
            this.username = account.tendangnhap;
            this.phone = '-';
            this.fullname = '-';
            switch (account.loaitk) {
                case 0:
                    this.permission = 'Chưa cấp quyền';
                    break;
                case 1:
                    this.permission = 'Giáo viên';
                    break;
                case 2:
                    this.permission = 'Giáo vụ';
                    break;
                case 3:
                    this.permission = 'Quản lý';
                    break;
                default:
                    break;
            }
        },
        async confirm() {
            let account = this.public_accountList.find((acc) => {
                return acc.tendangnhap === this.username;
            });
            if (account === undefined) {
                alert('Bạn chưa chọn tài khoản');
                return;
            }
            if (!this.selected) {
                alert('Bạn chưa chọn quyền cần cấp');
                return;
            }

            let confirmTxt = prompt("Nhập CONFIRM để xác nhận");
            if (confirmTxt != 'CONFIRM') {
                alert('Không thể xác nhận');
                return;
            }
            if (account.loaitk === 3) {
                alert('Không thể cấp quyền cho tài khoản này');
                return;
            }

            let user = {
                MATK: account.matk,
                TENDANGNHAP: account.tendangnhap,
                MATKHAU: account.matkhau,
                LOAITK: 0,
            };
            if (this.selected === 'teacher') {
                user.LOAITK = 1;
            }
            if (this.selected === 'manager') {
                user.LOAITK = 2;
            }
            const new_user = JSON.stringify(user);
            await fetch(
                this.base_url + `/taikhoan/update?data=${new_user}`
            ).then((response) => response.json())
                .then((data) => {
                    if (data.status === 'ok') alert('Cấp quyền cho tài khoản thành công')
                    else alert('Cấp quyền cho tài khoản thất bại')
                });
            this.getAccountAll();
            this.permission = this.getLoaiTK(user.LOAITK);
        },
        async cancel() {
            let account = this.public_accountList.find((acc) => {
                return acc.tendangnhap === this.username;
            });
            if (account === undefined) {
                alert('Bạn chưa chọn tài khoản');
                return;
            }
            let confirmTxt = prompt("Nhập CONFIRM để xác nhận");
            if (confirmTxt != 'CONFIRM') {
                alert('Không thể xác nhận');
                return;
            }
            if (account.loaitk === 3) {
                alert('Không thể cấp quyền cho tài khoản này');
                return;
            }
            let user = {
                MATK: account.matk,
                TENDANGNHAP: account.tendangnhap,
                MATKHAU: account.matkhau,
                LOAITK: 0,
            };
            const new_user = JSON.stringify(user);
            await fetch(
                this.base_url + `/taikhoan/update?data=${new_user}`
            ).then((response) => response.json())
                .then((data) => {
                    if (data.status === 'ok') alert('Huỷ bỏ cấp quyền cho tài khoản thành công')
                    else alert('Huỷ bỏ cấp quyền cho tài khoản thất bại')
                });
            this.getAccountAll();
            this.permission = this.getLoaiTK(user.LOAITK);
        },
        checkValidInput() {
            this.minAge = parseInt(this.minAge);
            this.maxAge = parseInt(this.maxAge);
            this.maxStd = parseInt(this.maxStd);
            this.admMark = parseFloat(this.admMark);
            if (
                !this.minAge ||
                !this.maxAge ||
                !this.maxStd ||
                !this.admMark ||
                this.minAge < 0 ||
                this.maxAge < 0 ||
                this.minAge > this.maxAge ||
                this.maxStd < 0 ||
                this.admMark <= 0.0 ||
                this.admMark > 10.0
            ) return false;
            else return true;
        },
        fetchToInput() {
            try {
                this.minAge = this.public_regulationList.find(reg => reg.maquydinh === 'QD001').value;
                this.maxAge = this.public_regulationList.find(reg => reg.maquydinh === 'QD002').value;
                this.maxStd = this.public_regulationList.find(reg => reg.maquydinh === 'QD003').value;
                this.admMark = this.public_regulationList.find(reg => reg.maquydinh === 'QD004').value;
            }
            catch (err) {
                console.log('Failed to load data');
            }
        },
        async regApply() {
            if (!this.checkValidInput()) {
                alert('Giá trị nhập không hợp lệ');
                return;
            }
            let confirmTxt = prompt("Nhập CONFIRM để xác nhận");
            if (confirmTxt != 'CONFIRM') {
                alert('Không thể xác nhận');
                return;
            }

            let isSuccess = true;
            for (let index = 0; index < this.public_regulationList.length; index++) {
                const reg = this.public_regulationList[index];

                let inputValue = null;
                switch (reg.maquydinh) {
                    case 'QD001':
                        inputValue = parseInt(this.minAge)
                        break;
                    case 'QD002':
                        inputValue = parseInt(this.maxAge)
                        break;
                    case 'QD003':
                        inputValue = parseInt(this.maxStd)
                        break;
                    case 'QD004':
                        inputValue = parseFloat(this.admMark)
                        break;
                }
                if (!inputValue || inputValue === reg.value) {
                    continue;
                }

                let data = {
                    MAQUYDINH: reg.maquydinh,
                    TENQUYDINH: reg.tenquydinh,
                    VALUE: inputValue,
                }
                const new_data = JSON.stringify(data);
                await fetch(
                    this.base_url + `/quydinh/update?data=${new_data}`
                ).then((response) => response.json())
                    .then((data) => {
                        if (data.status != 'ok') isSuccess = false
                    });
                if (!isSuccess) break;
            }
            if (isSuccess) alert('Cập nhật thành công')
            else alert('Cập nhật thất bại')
            this.getRegulations();
        },

        incompleteFeature() {
            alert('Chức năng đang được phát triển.')
        }

    },
};
</script>
<style scoped>
/* CSS for tab */
.nav-group {
    display: flex;
    justify-content: center;
    margin-top: 40px;
}

.nav-group .nav-selected {
    color: #fff;
    background-color: var(--primary-color);
    opacity: 1;
}

.nav-group a {
    display: flex;
    align-items: center;
    height: 50px;
    text-decoration: none;
    color: var(--text-color);
    font-size: 1.25rem;
    padding: 0 25px 0 20px;
    opacity: 0.75;
    border-radius: 6px;
    transition: var(--tran-03);
    margin: 0 10px;
}

.nav-group .nav-selected:hover {
    color: #fff;
    background-color: var(--selected-hover-color);
    opacity: 1;
}

.nav-group a:hover {
    background-color: var(--hover-color);
    border-radius: 6px;
    opacity: 1;
}

.nav-group i {
    padding-right: 10px;
}

/* CSS for User permission tab */
.user {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 55px 0;
}

.user .title {
    font-size: 28px;
    color: var(--primary-color);
    font-weight: 900;
    padding: 0 10px;
}

.user select {
    height: 40px;
    font-size: 20px;
    background: var(--body-color);
    color: var(--text-color);
    margin-left: 10px;
    margin-right: 110px;
    padding: 10px;
    border: 1px solid var(--text-color);
    border-radius: 5px;
}

.info-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
}

.info-table table {
    border-spacing: 30px;
    border: 2px solid var(--text-color);
    border-radius: 25px;
    max-width: 1200px;
    width: 900px;
}

.info-table table label {
    color: var(--text-color);
}

.info tr {
    padding: 20px;
    margin: 50px;
}

.info-table td:first-child {
    padding-left: 40px;
    text-align: left;
    width: 300px;
}

.info-table td:nth-child(2) {
    width: 200px;
}

.info-table label {
    font-size: 23px;
}

.info-table table input {
    height: 30px;
    max-width: 300px;
    width: 100%;
    font-size: 20px;
    border-radius: 8px;
    padding: 10px;
    border: 0;
}

.avatar img,
.avatar span {
    display: block;
    margin-top: 20px;
    text-align: center;
    margin-left: auto;
    margin-right: auto;
    width: 15rem;
    color: var(--text-color);
    border-radius: 50%;
}

/* CSS title search email  */
.search-email-title {
    display: flex;
    justify-content: space-evenly;
    margin-top: 55px;
}

.search-email-title span {
    font-size: 28px;
    color: var(--primary-color);
    padding: 0 10px;
    font-weight: 900;
}

.search-email-title .search-input {
    display: flex;
    align-items: center;
}

.search-email-title input {
    height: 30px;
    width: 350px;
    font-size: 20px;
    border-radius: 8px;
    padding: 10px;
    border: 0;
}

.search-email-title button {
    background-color: var(--primary-color);
    height: 30px;
    width: 50px;
    font-size: 20px;
    border-radius: 8px;
    border: 0;
    margin-left: 5px;
}

.search-email-title button:hover {
    opacity: 0.5;
}

.search-email-title i {
    display: flex;
    color: #fff;
    justify-content: center;
    align-items: center;
}

.email-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    max-height: 40vh;
    overflow-y: auto;
}
.email-table table {
    margin-bottom: 50px;
}

#email-std {
    border: 2px solid var(--text-color);
    border-radius: 25px;
    padding: 10px 0 10px 40px;
    max-width: 1000px;
}

#email-std td:first-child {
    width: 300px;
}

#email-std td:nth-child(2) {
    width: 300px;
}

#email-std td:nth-child(3) {
    text-align: center;
    width: 180px;
}

#email-std td:last-child {
    width: 180px;
    text-align: center;
}

#email-std th {
    font-size: 25px;
    font-weight: 900;
    height: 70px;
    padding: 5px 0;
    color: var(--primary-color);
}

#email-std td {
    font-size: 20px;
    height: 70px;
    padding: 5px 0px;
    color: var(--text-color);
}

#email-std td button {
    max-width: 200px;
    height: 40px;
    margin: 0 10px;
    border-radius: 20px;
    font-size: 20px;
    padding: 5px;
    cursor: pointer;
    background: var(--body-color);
    padding: 0 15px;
}

#email-std td #change {
    border: 2px solid var(--change-btn);
    color: var(--change-btn);
}

#email-std td #change:hover {
    background-color: var(--change-btn);
    transition: var(--tran-03);
    color: var(--text-color);
}

/* CSS for change regulation tab */
.title-reg {
    display: flex;
    justify-content: space-around;
    margin-top: 55px;
}

.btn-group button {
    display: inline-flex;
    height: 40px;
    margin: 0 10px;
    border-radius: 20px;
    align-items: center;
    font-size: 20px;
    padding: 5px;
    cursor: pointer;
    border: 0;
    color: var(--text-color);
}

.btn-group .btn-text {
    color: var(--text-color);
    font-size: 20px;
    padding: 0px 15px 0px 0px;
}

.btn-group i {
    font-size: 20px;
    padding-left: 5px;
    padding-right: 5px;
}

.btn-group #undo {
    background-color: #777;

}

.btn-group #remove {
    background-color: var(--remove-btn);
}

.btn-group #change {
    background-color: var(--change-btn);
}

.btn-group button:hover {
    opacity: 0.75;
}

.title-reg span {
    font-size: 28px;
    color: var(--text-color);
    padding: 10px;
}

.notice {
    display: flex;
    justify-content: space-around;
    margin-top: 30px;
}

.notice p {
    border: 2px solid var(--text-color);
    border-radius: 10px;
    padding: 10px;
    font-size: 23px;
    line-height: 30px;
    color: var(--primary-color);
}

.input-reg {
    display: flex;
    flex-direction: row;
    justify-content: center;
}

.input-group {
    display: flex;
    flex-direction: column;
    border: 2px solid var(--text-color);
    margin-top: 30px;
    border-radius: 10px;
    padding: 10px 30px;
    font-size: 23px;
    color: var(--text-color);
    margin-bottom: 50px;
}

.input-group button {
    max-width: 200px;
    height: 40px;
    margin: 0 10px;
    border-radius: 10px;
    font-size: 20px;
    padding: 0 10px;
    cursor: pointer;
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
}

.input-group button:hover {
    background-color: var(--primary-color);
    color: var(--text-color);
}

.group {
    margin: 25px;
    font-weight: 700;
}

.input-group input {
    max-width: 120px;
    height: 30px;
    border-radius: 4px;
    font-size: 23px;
    text-align: center;
}

.input-group input,
.input-group button {
    float: right;
}

.input-group label {
    position: relative;
}

.input-group label,
.input-group input,
.input-group button {
    margin: 0 100px;
}

.input-group label::after {
    position: absolute;
    content: '';
    height: 3px;
    bottom: -10px;

    margin: -10px auto;
    left: 0;
    right: 0;
    width: 500px;
    background: var(--text-color);

    -o-transition: 0.5s;
    -ms-transition: 0.5s;
    -moz-transition: 0.5s;
    -webkit-transition: 0.5s;
    transition: 0.5s;
}
</style>
