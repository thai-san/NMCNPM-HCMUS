<template>
    <!-- Search Tab -->
    <section id="searchtab" class="search">
        <div class="text">
            <h1>Tra cứu thông tin học sinh</h1>
            <h3>
                Nhập vào tên học sinh hoặc mã số học sinh. Bạn có thể chọn lớp ở
                nút phía dưới
            </h3>
        </div>
        <!-- <form action="" method=""> -->
        <div class="search-container">
            <div class="input-box">
                <input
                    v-model="keyword"
                    v-on:keyup.enter="onSearch"
                    type="text"
                    placeholder="Tên học sinh..."
                />
                <span class="icon">
                    <i class="bx bx-search search-icon"></i>
                </span>
            </div>
            <button @click="onSearch" id="btn-search">Tìm kiếm</button>
        </div>
        <!-- </form> -->

        <div class="table-content">
            <table id="table-std">
                <thead>
                    <th class="text">STT</th>
                    <th class="text" style="text-align: left">Tên</th>
                    <th class="text">Lớp</th>
                    <th class="text">Học kì 1</th>
                    <th class="text">Học kì 2</th>
                </thead>
                <tbody>
                    <tr
                        v-for="(student, index) in students"
                        :key="student.mahs"
                    >
                        <td class="text">{{ index + 1 }}</td>
                        <td class="text">{{ student.hoten }}</td>
                        <td class="text">{{ student.tenlop ? student.tenlop : '-' }}</td>
                        <td class="text">{{ student.final1 ? student.final1 : '-' }}</td>
                        <td class="text">{{ student.final2 ? student.final2 : '-'}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
</template>

<script>
export default {
    name: 'SearchComponent',

    data() {
        return {
            students: [],
            keyword: '',
            root_students: [],
            finalMark: [],
            isFirst: true,
        };
    },
    beforeMount() {
        this.fetchRootData();
    },
    methods: {
        fetchRootData () {
            fetch(this.base_url + '/hocsinh/all')
                .then((res) => res.json())
                .then((api) => {
                    this.root_students = api.data.map((x) => x);
                });
            fetch(this.base_url + '/diemtk/all')
                .then((res) => res.json())
                .then((api) => {
                    this.finalMark = api.data.map((x) => x);
                });
        },
        getData() {
            if (this.isFirst) {
                this.isFirst = false;
                for (let i = 0; i < this.root_students.length; i++) {
                    let element = this.root_students[i];
                    let totalMark = this.finalMark.filter((mark) => {
                        return mark.mahs === element.mahs;
                    });
                    let totalMark_term1 = totalMark.filter((mark) => {
                        return mark.mahk === 'HK001';
                    });
                    let totalMark_term2 = totalMark.filter((mark) => {
                        return mark.mahk === 'HK002';
                    });
                    let sum1 = 0.0;
                    let numOfSubject1 = 0;
                    totalMark_term1.forEach((el) => {
                        sum1 += parseFloat(el.diemtk);
                        numOfSubject1++;
                    });
                    let sum2 = 0.0;
                    let numOfSubject2 = 0;
                    totalMark_term2.forEach((el) => {
                        sum2 += parseFloat(el.diemtk);
                        numOfSubject2++;
                    });
                    if (numOfSubject1 === 0 || isNaN(sum1)) element.final1 = null;
                    else element.final1 = (sum1 / numOfSubject1).toFixed(2);
                    if (numOfSubject2 === 0 || isNaN(sum2)) element.final2 = null;
                    else element.final2 = (sum2 / numOfSubject2).toFixed(2);
                    if (element.malop) {
                        element.tenlop = String(element.malop).substring(1, 5);
                    }
                    else element.tenlop = '';
                }
            }
        },
        onSearch() {
            this.getData();
            this.students = this.root_students.filter((student) => {
                return student.hoten
                    .toLowerCase()
                    .includes(this.keyword.toLowerCase());
            });
            if(this.students.length === 0) {
                alert('Không tìm thấy')
            }
        },
    },
};
</script>
<style scoped>
body.dark .main-content .text {
    color: var(--text-color);
}

/* search */
.search .text {
    margin-top: 20px;
    font-size: 30px;
    font-weight: 500;
    color: var(--text-color);
    padding: 12px 60px;
    text-align: center;
}

h3 {
    margin-top: 20px;
    font-size: 30px;
    font-weight: 200;
}

.search .input-box {
    position: relative;
    height: 65px;
    max-width: 50%;
    width: 100%;
    margin: 0 5px;
    border: 1px solid var(--text-color);
    border-radius: 10px;
    transition: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
    padding: 0 15px 0 65px;
}

#btn-search {
    margin-left: 20px;
    display: block;
    float: right;
    width: 150px;
    font-size: 1.5rem;
    border-radius: 10px;
    border-width: 0;
    color: #fff;
    background: var(--primary-color);
}

#btn-search:hover {
    background: var(--selected-hover-color);
}

.search input {
    position: relative;
    outline: none;
    border: none;
    height: 100%;
    width: 100%;
    border-radius: 10px;
    font-size: 24px;
    font-weight: 400;
    color: var(--text-color);
    background-color: var(--body-color);
}

.search .icon {
    position: absolute;
    height: 100%;
    top: 0;
    left: 0;
    width: 60px;
    border-radius: 10px;
    display: flex;
    justify-content: center;
    background-color: var(--body-color);
}

.search-container {
    margin-top: 50px;
    display: flex;
    justify-content: center;
}

.search .search-icon {
    position: absolute;
    top: 50%;
    font-size: 30px;
    transition: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

.search .search-icon {
    color: var(--primary-color);
    transform: translateY(-50%) rotate(90deg);
}

.search .input-box .search-icon {
    transform: translateY(-50%) rotate(0);
}

.search .btn-group {
    margin-left: 100px;
}

.table-content {
    margin-top: 50px;
    display: flex;
    justify-content: center;
}

#table-std {
    border-spacing: 0;
    border-collapse: separate;
    border: 2px solid var(--text-color);
    border-radius: 15px;
    margin-bottom: 50px;
}

#table-std .text {
    padding: 0;
}

#table-std th:first-child {
    text-align: center;
    width: 120px;
}

#table-std th:nth-child(2),
#table-std td:nth-child(2) {
    text-align: left;
    width: 400px;
    padding-left: 20px;
}

#table-std th:nth-child(3) {
    text-align: center;
    width: 200px;
}
#table-std th:nth-child(4) {
    text-align: center;
    width: 200px;
}
#table-std th:nth-child(5) {
    text-align: center;
    width: 200px;
}

#table-std th {
    color: var(--primary-color);
}

td,
th {
    height: 60px;
}

th:not(:last-child),
td:not(:last-child) {
    border-right: 1px solid var(--text-color);
}

tr:not(:last-child) > td {
    border-bottom: 1px solid var(--text-color);
}

tr:first-child > td {
    border-top: 1px solid var(--text-color);
}
</style>
