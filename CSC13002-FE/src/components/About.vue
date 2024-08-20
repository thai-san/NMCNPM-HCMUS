<template>
    <!-- About Tab -->
    <div class="info">
        <div class="info-text">
            <h1 class="title">Nhóm 14</h1>
            <ul class="member-name">
                <li class="duty">Leader</li>
                <li class="name">19120268 <span>Ngô Đặng Gia Lâm</span></li>
                <li class="duty">Back-end Developer</li>
                <li class="name">20120177 <span>Trần Thái San</span></li>
                <li class="duty">Front-end Developer</li>
                <li class="name">20120298 <span>Phạm Bảo Huy</span></li>
                <li class="name">20120326 <span>Phan Phong Lưu</span></li>
            </ul>
        </div>
        <div class="logo">
            <img src="img/logo.png" alt="" class="img-logo">
        </div>
    </div>
</template>

<script>
export default {
    name: 'AboutComponent',
};
</script>
<style scoped>
.info {
    position: relative;
    height: 100vh;

}

.info-text {
    position: absolute;
    width: 80%;
    max-width: 700px;
    top: 50%;
    left: 35%;
    padding-left: 80px;
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    color: var(--text-color);
    font-weight: 500;
}

.info-text .title {
    font-size: 50px;
    text-align: center;
    color: var(--primary-color);
}

ul {
    list-style-type: none;
    width: 100%;
    font-size: 40px;
    line-height: 75px;
    text-align: left;
}

.info-text .duty {
    font-size: 36px;
    margin-top: 20px;
    max-height: 60px;
}
.info-text .name {
    max-height: 60px;
    padding-left: 60px;
    text-align: left;
}
.info-text .name span {
    color: var(--primary-color);
}

.img-logo {
    width: 350px;
    height: inherit;
    position: absolute;
    top: 50%;
    left: 85%;
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    color: var(--text-color);
    font-weight: 500;
    background: var(--sidebar-color);
}

</style>
