<template>
    <div class="nav-group">
        <a
            href="#"
            :class="currentTag === 0 ? 'nav-selected' : ''"
            @click="onTagClicked($event, 0)"
            ><i class="bx bx-add-to-queue"></i
            ><span>Tiếp nhận học sinh</span></a
        >
        <a
            href="#"
            :class="currentTag === 1 ? 'nav-selected' : ''"
            @click="onTagClicked($event, 1)"
            ><i class="bx bx-user-pin"></i><span>Cập nhật học sinh</span></a
        >
        <a
            href="#"
            :class="currentTag === 2 ? 'nav-selected' : ''"
            @click="onTagClicked($event, 2)"
            ><i class="bx bx-notepad"></i><span>Lập danh sách lớp</span></a
        >
        <a
            href="#"
            :class="currentTag === 3 ? 'nav-selected' : ''"
            @click="onTagClicked($event, 3)"
            ><i class="bx bx-columns"></i><span>Nhập bảng điểm</span></a
        >
        <a
            href="#"
            :class="currentTag === 4 ? 'nav-selected' : ''"
            @click="onTagClicked($event, 4)"
            ><i class="bx bx-bar-chart-alt-2"></i><span>Lập báo cáo</span></a
        >
    </div>
    <!-- Tiếp nhận học sinh -->
    <div class="tag-content" v-if="currentTag === 0">
        <div class="title">
            <span>Thêm học sinh</span>
            <div class="btn-group">
                <button id="remove" @click="add_cancel">
                    <i class="bx bx-x"></i><span class="btn-text">Hủy bỏ</span>
                </button>
                <button id="change" @click="add_done">
                    <i class="bx bx-check"></i
                    ><span class="btn-text">Thêm học sinh</span>
                </button>
            </div>
        </div>
        <div class="info-table">
            <table>
                <tr>
                    <td>
                        <label>Họ và tên</label
                        ><input type="text" v-model="add_stdDetail.name" />
                    </td>
                    <td>
                        <label>Email</label
                        ><input type="text" v-model="add_stdDetail.email" />
                    </td>
                    <td style="width: 300px">
                        <label>Giới tính</label
                        ><input type="text" v-model="add_stdDetail.gender" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Lớp</label
                        ><input type="text" v-model="add_stdDetail.grade" />
                    </td>
                    <td>
                        <label>Ngày sinh</label
                        ><input type="date" v-model="add_stdDetail.birthdate" />
                    </td>
                    <td style="width: 300px">
                        <label>Số điện thoại</label>
                        <input type="text" v-model="add_stdDetail.phone" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <label style="margin-right: 20px">Địa chỉ</label
                        ><input
                            id="address"
                            type="text"
                            v-model="add_stdDetail.address"
                            style="min-width: 600px"
                        />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <!-- Cập nhật học sinh -->
    <div class="tag-content" v-if="currentTag === 1">
        <div class="update-student" v-if="edit_updateTable === 1">
            <div class="title">
                <span>Đã chọn</span>
                <div class="btn-group">
                    <button id="cancel" @click="edit_cancel">
                        <i class="bx bx-undo"></i
                        ><span class="btn-text">Hủy chọn</span>
                    </button>
                    <button id="remove" @click="edit_remove">
                        <i class="bx bx-x"></i
                        ><span class="btn-text">Xoá học sinh</span>
                    </button>
                    <button id="change" @click="edit_done">
                        <i class="bx bx-check"></i
                        ><span class="btn-text">Hoàn tất sửa đổi</span>
                    </button>
                </div>
            </div>
            <div class="info-table">
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <label>Họ và tên</label
                                ><input
                                    type="text"
                                    v-model="edit_stdDetail.name"
                                />
                            </td>
                            <td>
                                <label>Email</label
                                ><input
                                    type="text"
                                    v-model="edit_stdDetail.email"
                                />
                            </td>
                            <td>
                                <label style="width: 300px">Giới tính</label
                                ><input
                                    type="text"
                                    v-model="edit_stdDetail.gender"
                                />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Lớp</label
                                ><input
                                    type="text"
                                    v-model="edit_stdDetail.grade"
                                />
                            </td>
                            <td>
                                <label>Ngày sinh</label
                                ><input
                                    type="date"
                                    v-model="edit_stdDetail.birthdate"
                                />
                            </td>
                            <td>
                                <label style="width: 300px">Số điện thoại</label
                                ><input
                                    type="text"
                                    v-model="edit_stdDetail.phone"
                                />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <label style="margin-right: 20px">Địa chỉ</label
                                ><input
                                    id="address"
                                    type="text"
                                    v-model="edit_stdDetail.address"
                                    style="min-width: 600px"
                                />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="search-insert">
            <div class="search-insert-title">
                <span>Tìm kiếm học sinh</span>
                <div class="search-input">
                    <input
                        id="input-search"
                        type="text"
                        placeholder="Nhập tên học sinh ..."
                        v-model="edit_schKeyword"
                        v-on:keyup.enter="edit_onSearch"
                    />
                    <label for="input-search"
                        ><button @click="edit_onSearch">
                            <i class="bx bx-search"></i></button
                    ></label>
                </div>
            </div>
            <div class="update-table">
                <table>
                    <thead>
                        <th>Tên</th>
                        <th>Lớp</th>
                        <th>Giới tính</th>
                        <th>Ngày sinh</th>
                        <th style="padding-right: 40px">Điện thoại</th>
                        <th hidden>Email</th>
                        <th hidden>Địa chỉ</th>
                    </thead>
                    <tbody>
                        <tr
                            @click="edit_showDetails($event, std.mahs)"
                            v-for="std in studentShow"
                            :key="std.mahs"
                        >
                            <td>{{ std.hoten }}</td>
                            <td>{{ std.tenlop }}</td>
                            <td>{{ std.gioitinh }}</td>
                            <td>{{ std.ngaysinh }}</td>
                            <td>---</td>
                            <td hidden>{{ std.email }}</td>
                            <td hidden>{{ std.diachi }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Lâp danh sách lớp -->
    <div class="tag-content" v-if="currentTag === 2">
        <div class="class-list">
            <div class="class-select">
                <span class="class-list-title">Danh sách lớp</span>
                <select
                    name="class"
                    v-model="class_classSelected"
                    @change="class_selectClass"
                >
                    <option
                        v-for="_class in public_classList"
                        :value="_class.malop"
                        :key="_class.malop"
                    >
                        {{ _class.tenlop }}
                    </option>
                </select>
            </div>
            <div class="btn-group">
                <button id="cancel" @click="class_cancel">
                    <i class="bx bx-undo"></i><span class="btn-text">Hủy</span>
                </button>
                <button id="remove" @click="class_removeAll">
                    <i class="bx bx-x"></i
                    ><span class="btn-text">Xoá toàn bộ HS</span>
                </button>
                <button id="change">
                    <i class="bx bx-check"></i
                    ><span class="btn-text" @click="class_done">Xong</span>
                </button>
            </div>
        </div>
        <div class="insert-table">
            <table id="table-std">
                <thead>
                    <th style="text-align: left">Tên</th>
                    <th>Lớp</th>
                    <th>Giới tính</th>
                    <th></th>
                </thead>
                <tbody>
                    <tr v-for="std in class_stdInClass" :key="std.mahs">
                        <td>{{ std.hoten }}</td>
                        <td>{{ std.tenlop }}</td>
                        <td>{{ std.gioitinh }}</td>
                        <td>
                            <button
                                id="remove"
                                @click="class_removeStudent($event, std.mahs)"
                            >
                                Xoá khỏi lớp
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="search-insert">
            <div class="search-insert-title">
                <span>Tìm kiếm học sinh</span>
                <div class="search-input">
                    <input
                        id="input-search"
                        type="text"
                        placeholder="Nhập tên học sinh ..."
                        v-model="class_schKeyword"
                        v-on:keyup.enter="class_onSearch"
                    />
                    <label for="input-search"
                        ><button @click="class_onSearch">
                            <i class="bx bx-search"></i></button
                    ></label>
                </div>
            </div>
            <div class="insert-table">
                <table id="table-std" style="margin-bottom: 50px">
                    <thead>
                        <th style="text-align: left">Tên</th>
                        <th>Lớp</th>
                        <th>Giới tính</th>
                        <th></th>
                    </thead>
                    <tbody>
                        <tr v-for="std in studentShow" :key="std.mahs">
                            <td>{{ std.hoten }}</td>
                            <td>{{ std.tenlop }}</td>
                            <td>{{ std.gioitinh }}</td>
                            <td>
                                <button
                                    id="change"
                                    @click="class_addStudent($event, std.mahs)"
                                >
                                    Thêm vào lớp
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Nhập bảng điểm -->
    <div class="tag-content" v-if="currentTag === 3">
        <div class="mark-title">
            <span>Lựa chọn</span>
        </div>
        <div class="mark-select">
            <div class="select-group">
                <label for="class">Lớp</label>
                <select
                    name="class"
                    id="class"
                    v-model="mark_classSel"
                    @change="mark_selectContext"
                >
                    <option
                        v-for="_class in public_classList"
                        :value="_class.malop"
                        :key="_class.malop"
                    >
                        {{ _class.tenlop }}
                    </option>
                </select>
            </div>
            <div class="select-group">
                <label for="term">Học kì</label>
                <select
                    name="term2"
                    id="term2"
                    v-model="mark_semesterSel"
                    @change="mark_selectContext"
                >
                    <option
                        v-for="semester in public_semesterList"
                        :value="semester.mahk"
                        :key="semester.mahk"
                    >
                        {{ semester.tenhk }}
                    </option>
                </select>
            </div>
            <div class="select-group">
                <label for="subject">Môn</label>
                <select
                    name="subject"
                    id="subject"
                    v-model="mark_subjectSel"
                    @change="mark_selectContext"
                    style="width: 120px"
                >
                    <option
                        v-for="subject in public_subjectList"
                        :value="subject.mamh"
                        :key="subject.mamh"
                    >
                        {{ subject.tenmh }}
                    </option>
                </select>
            </div>
        </div>
        <div class="mark-title-table">
            <span>{{ mark_getContextName }}</span>
            <div class="btn-group-mark">
                <button @click="mark_Refresh" id="refresh">
                    <i class="bx bx-refresh"></i><i>Làm mới</i>
                </button>
                <button id="change" @click="mark_done">
                    <i class="bx bx-check"></i><i>Xong</i>
                </button>
            </div>
        </div>
        <div class="mark-table">
            <table>
                <thead>
                    <th style="text-align: left">Tên</th>
                    <th>Điểm 15'</th>
                    <th>Điểm 1 tiết</th>
                    <th>Điểm học kì</th>
                </thead>
                <tbody>
                    <tr v-for="std in mark_newStudents" :key="std.mahs">
                        <td>
                            <label for="">{{ std.hoten }}</label>
                        </td>
                        <td>
                            <input v-model="std.exam_1" type="text" />
                        </td>
                        <td>
                            <input v-model="std.exam_2" type="text" />
                        </td>
                        <td>
                            <input v-model="std.exam_3" type="text" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- Lập báo cáo -->
    <div class="tag-content" v-if="currentTag === 4">
        <div class="report-title">
            <span>Lựa chọn</span>
        </div>
        <div class="report-select">
            <div class="select-group">
                <label for="term1">Học kì</label>
                <select name="term" id="term1" v-model="report_semesterSel">
                    <option
                        v-for="semester in public_semesterList"
                        :value="semester.mahk"
                        :key="semester.mahk"
                    >
                        {{ semester.tenhk }}
                    </option>
                </select>
            </div>
            <div class="select-group">
                <label for="subject">Môn</label>
                <select name="subject" id="subject" v-model="report_subjectSel">
                    <option
                        v-for="subject in public_subjectList"
                        :value="subject.mamh"
                        :key="subject.mamh"
                    >
                        {{ subject.tenmh }}
                    </option>
                </select>
            </div>
        </div>
        <div class="report-title-table">
            <span>Báo cáo tổng kết {{ report_getSubSemName }}</span>
            <div class="btn-group-report">
                <button @click="report_done" id="change">
                    <i class="bx bx-check"></i><i>Xong</i>
                </button>
            </div>
        </div>
        <div class="report-table">
            <table>
                <thead>
                    <th>Lớp</th>
                    <th>Sĩ số</th>
                    <th>Số lượng đạt</th>
                    <th>Tỉ lệ (%)</th>
                </thead>
                <tbody>
                    <tr v-for="(item, key) in report_classList" :key="key">
                        <td>{{ key }}</td>
                        <td>{{ item.total }}</td>
                        <td>{{ item.passed }}</td>
                        <td>{{ item.rate }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>
<script>
export default {
    name: 'ManagementComponent',
    data() {
        return {
            currentTag: 0,
            studentShow: [],
            public_classList: [], // danh sách các lớp
            public_semesterList: [], // danh sách các lớp
            public_subjectList: [], // danh sách các môn học
            public_studentList: [], // danh sách học sinh
            public_detailsMark: [], // danh sách chi tiết điểm
            public_finalMark: [], // danh sách điểm tk
            public_regList: [], // danh sách các quy định

            // dữ liệu phần tiếp nhận học sinh
            add_stdDetail: {}, // chứa thông tin của 1 học sinh khi thêm

            // dữ liệu phần cập nhật học sinh
            edit_updateTable: 0, // trạng thái đóng mở của bảng thông tin chi tiết
            edit_stdDetail: {}, // thông tin chi tiết của học sinh khi chỉnh sửa
            edit_schKeyword: '', // từ khóa search
            edit_selectedID: '', // từ khóa search

            // dữ liệu phần lập danh sách lớp
            class_classSelected: '', // lớp được chọn
            class_stdInClass: {}, // danh sách các học sinh trong lớp
            class_stdNoClass: {}, // danh sách các học sinh không thuộc lớp nào
            class_stdWantRm: [], // danh sách mã học sinh muốn xóa khỏi lớp
            class_stdWantAdd: [], // danh sách mã học sinh muốn thêm vào lớp
            class_schKeyword: '', // từ khóa search

            // dữ liệu phần nhập bảng điểm
            mark_classSel: '',
            mark_semesterSel: '',
            mark_subjectSel: '',
            mark_inputMark: [], // dữ liệu học sinh khi nhập điểm
            mark_newStudents: [],
            mark_lastID: null,

            // dữ liệu phần báo cáo
            report_semesterSel: '',
            report_subjectSel: '',
            report_inputMark: [], // dữ liệu học sinh khi nhập điểm
            report_classList: {},
        };
    },
    beforeMount() {
        this.getStudentAll();
        this.getClassAll();
        this.getSemesterAll();
        this.getSubjectAll();
        this.getDetailsMark();
        this.getFinalMark();
        this.getLastID();
        this.getRegulations();

        // Thêm học sinh
        this.add_stdDetail = {
            name: '',
            grade: '',
            gender: '',
            birthdate: '',
            phone: '',
            email: '',
            address: '',
        };

        // Cập nhật học sinh
        this.edit_stdDetail = {
            name: '',
            grade: '',
            gender: '',
            birthdate: '',
            phone: '',
            email: '',
            address: '',
        };

        // this.class_classSelected = this.public_classList[0].id;
    },
    computed: {
        mark_getContextName() {
            let classList = this.public_classList.find((grade) => {
                return grade.malop === this.mark_classSel;
            });
            let semList = this.public_semesterList.find((semester) => {
                return semester.mahk === this.mark_semesterSel;
            });
            let subList = this.public_subjectList.find((subject) => {
                return subject.mamh === this.mark_subjectSel;
            });
            if (subList && semList)
                return (
                    'Bảng điểm lớp ' +
                    classList.tenlop +
                    ' - ' +
                    semList.tenhk +
                    ' - ' +
                    subList.tenmh
                );
            else return '';
        },
        report_getSubSemName() {
            let subList = this.public_subjectList.find((subject) => {
                return subject.mamh === this.report_subjectSel;
            });
            let semList = this.public_semesterList.find((semester) => {
                return semester.mahk === this.report_semesterSel;
            });
            if (subList && semList)
                return semList.tenhk + ' - ' + subList.tenmh;
            else return '';
        },
    },
    methods: {
        // ================ Xử lý chung ===================================
        /**
         * Xử lý chuyển Tag
         *
         * @param {object} e Event khi gọi hàm
         * @param {number} tagId Id của tag, 0 -> 4
         */
        onTagClicked(e, tagId) {
            let tagNumber = parseInt(tagId);
            if (tagNumber >= 0 && tagNumber <= 4) {
                this.edit_updateTable = 0;
                this.currentTag = tagNumber;
            }
            switch (tagNumber) {
                case 0:
                    break;
                case 1:
                    this.studentShow = this.public_studentList;
                    break;
                case 2:
                    this.studentShow = [];
                    break;
                case 3:
                    this.studentShow = [];
                    break;
                case 4:
                    break;
            }
        },

        getStudentAll() {
            this.public_studentList = [];
            fetch(this.base_url + '/hocsinh/all')
                .then((res) => res.json())
                .then((api) => {
                    for (let i = 0; i < api.data.length; i++) {
                        let element = api.data[i];
                        let tenlop;
                        if (element.malop === null) {
                            tenlop = '-';
                        } else tenlop = String(element.malop).substring(1, 5);
                        let ngaysinh = String(element.ngaysinh).substring(
                            0,
                            10
                        );
                        let std = {
                            mahs: element.mahs,
                            hoten: element.hoten,
                            gioitinh: element.gioitinh,
                            ngaysinh,
                            diachi: element.diachi,
                            email: element.email,
                            malop: element.malop,
                            tenlop,
                        };
                        this.public_studentList.push(std);
                    }
                });
        },

        getClassAll() {
            fetch(this.base_url + '/lop/all')
                .then((res) => res.json())
                .then(
                    (api) => (this.public_classList = api.data.map((x) => x))
                );
        },

        getSemesterAll() {
            fetch(this.base_url + '/hocki/all')
                .then((res) => res.json())
                .then(
                    (api) => (this.public_semesterList = api.data.map((x) => x))
                );
        },

        getSubjectAll() {
            fetch(this.base_url + '/monhoc/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_subjectList = api.data.map((std) => std);
                });
        },

        getDetailsMark() {
            fetch(this.base_url + '/chitietdiem/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_detailsMark = api.data.map((std) => std);
                });
        },

        getFinalMark() {
            fetch(this.base_url + '/diemtk/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_finalMark = api.data.map((std) => std);
                });
        },

        getLastID() {
            fetch(this.base_url + '/diemtk/max')
                .then((res) => res.json())
                .then((api) => {
                    this.mark_lastID = api.data.map((std) => std);
                });
        },

        getRegulations() {
            fetch(this.base_url + '/quydinh/all')
                .then((res) => res.json())
                .then((api) => {
                    this.public_regList = api.data.map((std) => std);
                });
        },

        /**
         * Lọc ra học sinh có tên chứa từ khóa trong danh sách
         *
         * @param {array} stdArr danh sách học sinh cần tra cứu
         * @param {string} keyword Từ khóa tìm kiếm học sinh
         *
         * @return {array} Danh sách học sinh sau khi lọc
         */
        searchStudent(stdArr, keyword) {
            return stdArr.filter((student) => {
                return student.hoten
                    .toLowerCase()
                    .includes(keyword.toLowerCase());
            });
        },

        /**
         * Tìm học sinh theo giá trị thuộc tính
         *
         * @param {array} stdArr danh sách học cần tìm
         * @param {string} attr thuộc tính tìm
         * @param {string} value giá trị muốn tìm
         *
         * @return {object} Học sinh cần tìm
         */
        findStdByAttrValue(stdArr, attr, value) {
            let std = stdArr.find((student) => student[attr] === value);
            return Object.assign({}, std);
        },

        /**
         * Lọc ra học sinh theo giá trị thuộc tính
         *
         * @param {array} stdArr danh sách học cần lọc
         * @param {string} attr thuộc tính lọc
         * @param {string} value giá trị muốn lọc
         *
         * @return {array} Danh sách học sinh sau khi lọc
         */
        filterStdByAttrValue(stdArr, attr, value) {
            const returnArr = [];
            for (let i = 0; i < stdArr.length; i++) {
                if (stdArr[i][attr] === value) {
                    let stdCpy = Object.assign({}, stdArr[i]);
                    returnArr.push(stdCpy);
                }
            }
            return returnArr;
        },

        /**
         * Xóa học sinh có thuộc tính attr bằng value
         *
         * @param {array} stdArr danh sách học sinh cần xóa
         * @param {string} attr thuộc tính so sánh
         * @param {string} value giá trị muốn xóa
         *
         * @return {array} danh sách học sinh sau khi xóa
         *
         */
        removeStdByAttr(stdArr, attr, value) {
            var i = stdArr.length;
            while (i--) {
                if (
                    stdArr[i] &&
                    arguments.length > 2 &&
                    stdArr[i][attr] === value
                ) {
                    stdArr.splice(i, 1);
                }
            }
            return stdArr;
        },

        // ================ Tiếp nhận học sinh ============================
        /**
         * Hủy thêm học sinh: Xóa toàn bộ thông tin vừa nhập
         *
         */
        add_cancel() {
            this.add_stdDetail = {
                name: '',
                grade: '',
                gender: '',
                birthdate: '',
                phone: '',
                email: '',
                address: '',
            };
            // console.log(this.add_stdDetail);
        },

        /**
         * Hoàn tất thêm học sinh: Kiểm tra và thêm thông tin học sinh
         *
         */
        async add_done() {
            let sentinel = this.public_studentList[0].mahs;
            for (let i = 1; i < this.public_studentList.length; i++) {
                const element = this.public_studentList[i];
                if (sentinel < element.mahs) sentinel = element.mahs;
            }

            let last_id = String(sentinel).substring(2, 5);
            last_id = parseInt(last_id) + 1;
            if (last_id < 10) last_id = '00' + String(last_id);
            else if (last_id >= 10 && last_id <= 99)
                last_id = '0' + String(last_id);
            else last_id = String(last_id);

            const found = this.public_classList.some(
                (el) => el.tenlop === this.add_stdDetail.grade
            );
            let gradeID = this.add_stdDetail.grade;
            if (!found) {
                gradeID = null;
            } else {
                gradeID = 'L' + gradeID;
            }
            const new_student = {
                MAHS: 'HS' + last_id,
                HOTEN: this.add_stdDetail.name,
                GIOITINH: this.add_stdDetail.gender,
                NGAYSINH: this.add_stdDetail.birthdate,
                DIACHI: this.add_stdDetail.address,
                EMAIL: this.add_stdDetail.email,
                MALOP: gradeID,
            };
            const new_data = JSON.stringify(new_student);
            await fetch(this.base_url + `/hocsinh/create?data=${new_data}`)
                .then((response) => response.json())
                .then((data) => {
                    if (data.status === 'ok') alert('Thêm học sinh thành công');
                    else if (data.status) alert(data.status);
                    else alert('Thêm học sinh thất bại');
                });
            this.getStudentAll();
            this.add_stdDetail = {
                name: '',
                grade: '',
                gender: '',
                birthdate: '',
                phone: '',
                email: '',
                address: '',
            };
        },
        // ================ Cập nhật học sinh =============================
        /**
         * Hiển thị thông tin chi tiết của học sinh trên thẻ cập nhật
         *
         * @param {object} e Event khi gọi hàm
         * @param {string} stdId Mã số học sinh
         */
        edit_showDetails(e, stdId) {
            this.edit_selectedID = stdId;
            let selectedStd = this.findStdByAttrValue(
                this.studentShow,
                'mahs',
                stdId
            );
            this.edit_stdDetail.name = selectedStd.hoten;
            this.edit_stdDetail.grade = selectedStd.tenlop;
            this.edit_stdDetail.gender = selectedStd.gioitinh;
            this.edit_stdDetail.birthdate = selectedStd.ngaysinh;
            this.edit_stdDetail.phone = '';
            this.edit_stdDetail.email = selectedStd.email;
            this.edit_stdDetail.address = selectedStd.diachi;
            this.edit_updateTable = 1;
        },
        /**
         * Tìm kiếm học sinh
         *
         */
        edit_onSearch() {
            // console.log(this.edit_schKeyword);
            this.studentShow = this.searchStudent(
                this.public_studentList,
                this.edit_schKeyword
            );
        },

        /**
         * Hủy chọn: Xóa toàn bộ thông tin vừa nhập, hủy chọn HS
         *
         */
        edit_cancel() {
            this.edit_stdDetail = {
                name: '',
                grade: '',
                gender: '',
                birthdate: '',
                phone: '',
                email: '',
                address: '',
            };
            this.edit_selectedID = '';
            this.edit_updateTable = 0;
        },

        /**
         * Xóa học sinh: Xóa thông tin học sinh
         *
         */
        async edit_remove() {
            let text = 'Bạn có chắc chắn muốn xóa thông tin học sinh này?';
            if (confirm(text) == false) {
                return;
            }
            this.edit_stdDetail = {
                name: '',
                grade: '',
                gender: '',
                birthdate: '',
                phone: '',
                email: '',
                address: '',
            };
            // console.log('Remove ', this.edit_selectedID);
            await fetch(
                this.base_url + `/hocsinh/delete?id=${this.edit_selectedID}`
            )
                .then((response) => response.json())
                .then((data) => {
                    if (data.status === 'ok') alert('Xóa học sinh thành công');
                    else alert('Xóa học sinh thất bại');
                });
            this.getStudentAll();
            this.studentShow = this.public_studentList;
            this.edit_selectedID = '';
            this.edit_updateTable = 0;
        },

        /**
         * Hoàn tất chỉnh sửa: Cập nhật lại thông tin học sinh
         *
         */
        async edit_done() {
            let text = 'Bạn có chắc chắn muốn lưu những thay đổi?';
            if (confirm(text) == false) {
                return;
            }
            const found = this.public_classList.some(
                (el) => el.tenlop === this.edit_stdDetail.grade
            );
            let gradeID = this.edit_stdDetail.grade;
            if (!found) {
                gradeID = null;
            } else {
                gradeID = 'L' + gradeID;
            }
            const new_student = {
                MAHS: this.edit_selectedID,
                HOTEN: this.edit_stdDetail.name,
                GIOITINH: this.edit_stdDetail.gender,
                NGAYSINH: this.edit_stdDetail.birthdate,
                DIACHI: this.edit_stdDetail.address,
                EMAIL: this.edit_stdDetail.email,
                MALOP: gradeID,
            };
            const new_data = JSON.stringify(new_student);
            await fetch(this.base_url + `/hocsinh/update?data=${new_data}`)
                .then((response) => response.json())
                .then((data) => {
                    if (data.status === 'ok')
                        alert('Chỉnh sửa thông tin sinh thành công');
                    else alert('Chỉnh sửa thông tin học sinh thất bại');
                });
            this.getStudentAll();
            this.studentShow = this.public_studentList;
        },

        // ================ Lập danh sách lớp ==============================
        /**
         * Chọn lớp: Lọc danh sách học sinh thuộc lớp đã chọn
         *
         */
        class_selectClass() {
            // console.log(this.class_classSelected);
            // this.getStudentAll();
            this.class_stdInClass = this.filterStdByAttrValue(
                this.public_studentList,
                'malop',
                this.class_classSelected
            );
            this.class_stdNoClass = this.filterStdByAttrValue(
                this.public_studentList,
                'malop',
                null
            );
            this.studentShow = this.class_stdNoClass;
            this.class_stdWantAdd = [];
            this.class_stdWantRm = [];
        },

        /**
         * Thêm học sinh vào lớp
         *
         * @param {object} e Event khi gọi hàm
         * @param {string} stdId Mã học sinh cần thêm
         */
        class_addStudent(e, stdId) {
            // console.log(stdId);
            this.class_stdWantAdd.push(stdId);
            let addStd = this.findStdByAttrValue(
                this.public_studentList,
                'mahs',
                stdId
            );
            addStd.malop = this.class_classSelected;
            addStd.tenlop = String(this.class_classSelected).substring(1, 5);

            this.class_stdInClass.unshift(addStd);
            this.removeStdByAttr(this.class_stdNoClass, 'mahs', stdId);
            this.studentShow = this.class_stdNoClass;
            console.log(addStd);
        },

        /**
         * Xóa học sinh khỏi lớp
         *
         * @param {object} e Event khi gọi hàm
         * @param {string} stdId Mã học sinh cần thêm
         */
        class_removeStudent(e, stdId) {
            // console.log(stdId);
            this.class_stdWantRm.push(stdId);
            let removeStd = this.findStdByAttrValue(
                this.public_studentList,
                'mahs',
                stdId
            );
            removeStd.malop = null;
            removeStd.tenlop = '-';
            this.class_stdNoClass.unshift(removeStd);
            this.removeStdByAttr(this.class_stdInClass, 'mahs', stdId);
            this.studentShow = this.class_stdNoClass;
            // console.log(addStd);
        },

        /**
         * Tìm kiếm học sinh
         *
         */
        class_onSearch() {
            // console.log(this.class_schKeyword);
            this.studentShow = this.searchStudent(
                this.class_stdNoClass,
                this.class_schKeyword
            );
        },

        /**
         * Hủy bỏ thay đổi
         *
         */
        class_cancel() {
            this.class_classSelected = '';
            this.class_stdInClass = [];
            this.class_stdNoClass = [];
            this.studentShow = [];
            this.class_stdWantAdd = [];
            this.class_stdWantRm = [];
        },

        /**
         * Xóa toàn bộ học sinh khỏi lớp
         *
         */
        class_removeAll() {
            let text =
                'Bạn có chắc chắn muốn xóa toàn bộ học sinh khỏi lớp này?\n Thông tin chỉ được lưu khi bạn nhấn "Xong".';
            if (confirm(text) == false) {
                return;
            }
            this.class_stdInClass.forEach((student) => {
                this.class_stdWantRm.push(student.id);
                student.class = null;
                this.class_stdNoClass.unshift(student);
            });
            this.class_stdInClass = [];
            // console.log(this.class_stdWantRm);
        },

        /**
         * Hoàn tất sửa đổi lớp, cập nhật dữ liệu
         *
         */
        async class_done() {
            let text = 'Bạn có chắc chắn muốn lưu những thay đổi?';
            if (confirm(text) == false) {
                return;
            }
            let isSuccess = true;
            for (let i = 0; i < this.class_stdInClass.length; i++) {
                const element = this.class_stdInClass[i];
                const new_student = {
                    MAHS: element.mahs,
                    HOTEN: element.hoten,
                    GIOITINH: element.gioitinh,
                    NGAYSINH: element.ngaysinh,
                    DIACHI: element.diachi,
                    EMAIL: element.email,
                    MALOP: element.malop,
                };
                const new_data = JSON.stringify(new_student);
                await fetch(this.base_url + `/hocsinh/update?data=${new_data}`)
                    .then((response) => response.json())
                    .then((data) => {
                        if (data.status != 'ok') isSuccess = false;
                    });
            }
            for (let i = 0; i < this.class_stdNoClass.length; i++) {
                const element = this.class_stdNoClass[i];
                let temp = null;
                const new_student = {
                    MAHS: element.mahs,
                    HOTEN: element.hoten,
                    GIOITINH: element.gioitinh,
                    NGAYSINH: element.ngaysinh,
                    DIACHI: element.diachi,
                    EMAIL: element.email,
                    MALOP: temp,
                };
                const new_data = JSON.stringify(new_student);
                await fetch(this.base_url + `/hocsinh/update?data=${new_data}`)
                    .then((response) => response.json())
                    .then((data) => {
                        if (data.status != 'ok') isSuccess = false;
                    });
            }
            if (isSuccess) {
                alert('Dữ liệu của bạn đã được cập nhật');
            } else {
                alert('Dữ liệu cập nhật không thành công');
            }
            this.class_classSelected = '';
            this.class_stdInClass = [];
            this.class_stdNoClass = [];
            this.studentShow = [];
            this.getStudentAll();
        },

        // ================ Nhập bảng điểm =================================
        /**
         * Chọn Lớp, Học kì và Môn học cần nhập điểm
         *
         */
        mark_selectContext() {
            if (
                this.mark_classSel &&
                this.mark_semesterSel &&
                this.mark_subjectSel
            ) {
                this.mark_context =
                    this.mark_classSel +
                    this.mark_semesterSel +
                    this.mark_subjectSel;
                fetch(
                    this.base_url +
                        `/diemtheolop/search?MALOP=${this.mark_classSel}&MAHK=${this.mark_semesterSel}&MAMH=${this.mark_subjectSel}`
                )
                    .then((res) => res.json())
                    .then(
                        (api) => (this.mark_inputMark = api.data.map((x) => x))
                    );
            }
        },

        mark_Refresh() {
            this.mark_newStudents = this.filterStdByAttrValue(
                this.public_studentList,
                'malop',
                this.mark_classSel
            );
            for (let i = 0; i < this.mark_newStudents.length; i++) {
                let element = this.mark_newStudents[i];
                let detailsMark = this.mark_inputMark.find((el) => {
                    return el.mahs === element.mahs;
                });
                let isListEmpty = false;
                if (detailsMark) {
                    if (detailsMark.chitietdiem.length === 0) {
                        element.exam_1 = null;
                        element.exam_2 = null;
                        element.exam_3 = null;
                        isListEmpty = true;
                    } else {
                        element.exam_1 = detailsMark.chitietdiem[0].diemkt;
                        element.exam_2 = detailsMark.chitietdiem[1].diemkt;
                        element.exam_3 = detailsMark.chitietdiem[2].diemkt;
                    }
                    element.madiemtk = detailsMark.madiemtk;
                } else {
                    element.exam_1 = null;
                    element.exam_2 = null;
                    element.exam_3 = null;
                    element.madiemtk = null;
                }
                element.isEmpty = isListEmpty;
            }
        },
        /**
         * Hoàn tất nhập điểm, cập nhật dữ liệu
         *
         */
        async mark_done() {
            let text = 'Bạn có chắc chắn muốn lưu những thay đổi?';
            if (confirm(text) == false) {
                return;
            }
            let last_id = String(this.mark_lastID[0].madiemtk).substring(2, 5);
            last_id = parseInt(last_id);
            if (last_id < 10) last_id = '00' + String(last_id);
            else if (last_id >= 10 && last_id <= 99)
                last_id = '0' + String(last_id);
            else last_id = String(last_id);

            let isSuccess = true;
            for (let i = 0; i < this.mark_newStudents.length; i++) {
                let element = this.mark_newStudents[i];

                let new_exam = [0.0, 0.0, 0.0];

                new_exam[0] = parseFloat(element.exam_1);
                new_exam[1] = parseFloat(element.exam_2);
                new_exam[2] = parseFloat(element.exam_3);

                if (
                    isNaN(new_exam[0]) ||
                    new_exam[0] < 0.0 ||
                    new_exam[0] > 10.0
                )
                    new_exam[0] = null;
                if (
                    isNaN(new_exam[1]) ||
                    new_exam[1] < 0.0 ||
                    new_exam[1] > 10.0
                )
                    new_exam[1] = null;
                if (
                    isNaN(new_exam[2]) ||
                    new_exam[2] < 0.0 ||
                    new_exam[2] > 10.0
                )
                    new_exam[2] = null;
                if (element.madiemtk) {
                    for (let i = 0; i < 3; i++) {
                        if (i === 0 && new_exam[0] === element.exam_1) {
                            continue;
                        }
                        if (i === 1 && new_exam[1] === element.exam_2) {
                            continue;
                        }
                        if (i === 2 && new_exam[2] === element.exam_3) {
                            continue;
                        }
                        let record = {
                            MADIEMKT: element.madiemtk,
                            MAKT: `KT00${i + 1}`,
                            DIEMKT: new_exam[i],
                        };
                        const new_record = JSON.stringify(record);
                        await fetch(
                            this.base_url +
                                `/chitietdiem/update?data=${new_record}`
                        )
                            .then((response) => response.json())
                            .then((data) => {
                                if (data.status != 'ok') isSuccess = false;
                            });
                    }
                } else {
                    if (
                        element.exam_1 === null &&
                        element.exam_2 === null &&
                        element.exam_3 === null
                    ) {
                        console.log('hoc sinh chua dc nhap');
                        continue;
                    }
                    let newMADIEMKT = 'DT' + ++last_id;
                    const record = {
                        MADIEMTK: newMADIEMKT,
                        DIEMTK: null,
                        MAHK: this.mark_semesterSel,
                        MAMH: this.mark_subjectSel,
                        MAHS: element.mahs,
                    };
                    const new_record = JSON.stringify(record);
                    await fetch(
                        this.base_url + `/diemtk/create?data=${new_record}`
                    )
                        .then((response) => response.json())
                        .then((data) => {
                            if (data.status != 'ok') isSuccess = false;
                        });

                    for (let i = 0; i < 3; i++) {
                        let record = {
                            MADIEMKT: newMADIEMKT,
                            MAKT: `KT00${i + 1}`,
                            DIEMKT: new_exam[i],
                        };
                        console.log(record);
                        const new_record = JSON.stringify(record);
                        await fetch(
                            this.base_url +
                                `/chitietdiem/create?data=${new_record}`
                        )
                            .then((response) => response.json())
                            .then((data) => {
                                if (data.status != 'ok') isSuccess = false;
                            });
                    }
                }
            }
            if (isSuccess) alert('Cập nhật thành công');
            else alert('Cập nhật không thành công');
            this.mark_selectContext();
            this.getLastID();
        },

        // ================ Lập báo cáo ====================================
        /**
         * Lập báo cáo theo yêu cầu đã chọn
         *
         */
        report_done() {
            if (!this.report_semesterSel || !this.report_subjectSel) {
                alert('Bạn chưa chọn học kì và môn!');
                return;
            }

            let admMark = null;
            try {
                admMark = parseFloat(
                    this.public_regList.find((reg) => reg.maquydinh === 'QD004')
                        .value
                );
            } catch (err) {
                console.log('Không thể lấy điểm chuẩn đạt môn');
                return;
            }

            console.log(admMark);

            for (let i = 0; i < this.public_studentList.length; i++) {
                let element = this.public_studentList[i];
                let totalMark = this.public_finalMark.filter((mark) => {
                    return mark.mahs === element.mahs;
                });
                let _mark = totalMark.find((mark) => {
                    return (
                        mark.mahk === this.report_semesterSel &&
                        mark.mamh === this.report_subjectSel
                    );
                });
                if (!_mark) element.final = 0.0;
                else if (!_mark.diemtk) element.final = 0.0;
                else element.final = _mark.diemtk;
            }

            this.public_classList.forEach((el) => {
                let new_class = {
                    total: 0,
                    passed: 0,
                };
                this.report_classList[el.tenlop] = new_class;
            });

            for (let i = 0; i < this.public_studentList.length; i++) {
                const element = this.public_studentList[i];
                if (element.malop) {
                    this.report_classList[element.tenlop].total += 1;
                    if (parseFloat(element.final) >= admMark)
                        this.report_classList[element.tenlop].passed += 1;
                }
            }
            for (const key in this.report_classList) {
                let _total = parseFloat(this.report_classList[key].total);
                let _passed = parseFloat(this.report_classList[key].passed);
                this.report_classList[key]['rate'] = (
                    (_passed / _total) *
                    100.0
                ).toFixed(0);
            }
        },
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
.nav-group a:hover {
    background-color: var(--hover-color);
    color: var(--text-color);
    opacity: 1;
}
.nav-group .nav-selected:hover {
    background-color: var(--selected-hover-color);
    color: #fff;
    opacity: 1;
}

.nav-group i {
    padding-right: 10px;
}

/* CSS for Insert student tab */
.title {
    display: flex;
    justify-content: space-around;
    margin-top: 55px;
}
.title span {
    font-size: 28px;
    color: var(--text-color);
    padding: 10px;
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
    font-size: 20px;
    padding: 0px 15px 0px 0px;
}
.btn-group i {
    font-size: 20px;
    padding-left: 5px;
    padding-right: 5px;
}
.btn-group #cancel {
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

.info-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
}

.info-table table {
    border-spacing: 40px;
    border: 2px solid var(--text-color);
    border-radius: 25px;
}

.info-table table label {
    color: var(--text-color);
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

.info-table table #address {
    width: 600px;
    margin-bottom: -25px;
    margin-left: 5px;
    font-size: 20px;
    height: 50px;
    border-radius: 8px;
    padding: 10px;
    border: 0;
}

/* CSS for update students tab  */
.update-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    max-height: 50vh;
    overflow-y: auto;
}

.update-table table {
    border: 2px solid var(--text-color);
    border-radius: 25px;
    padding: 10px 0;
    max-width: 1060px;
    text-align: center;
    margin-bottom: 50px;
}

.update-table td:first-child,
.update-table th:first-child {
    padding-left: 40px;
    text-align: left;
    width: 340px;
}

.update-table th:nth-child(2) {
    width: 150px;
}

.update-table th:nth-child(3) {
    width: 150px;
}
.update-table th:nth-child(4) {
    width: 200px;
}

.update-table th:nth-child(5),
.update-table td:nth-child(5) {
    width: 200px;
    padding-right: 40px;
}
.update-table table th {
    font-size: 25px;
    font-weight: 900;
    height: 60px;
    color: var(--primary-color);
}
.update-table table tr {
    height: 60px;
}
.update-table table tr:hover {
    background: var(--hover-color);
}

.update-table table td {
    font-size: 20px;
    color: var(--text-color);
}

.update-table table td #remove {
    border: 2px solid var(--remove-btn);
    color: var(--remove-btn);
}

.update-table table td #remove:hover {
    background-color: var(--remove-btn);
    transition: var(--tran-03);
    color: var(--text-color);
}

.update-table table td #change {
    border: 2px solid var(--change-btn);
    color: var(--change-btn);
}

.update-table table td #change:hover {
    background-color: var(--change-btn);
    transition: var(--tran-03);
    color: var(--text-color);
}

/* CSS for Create classes tab */
.class-list {
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    margin: 55px 0;
}
.class-list .class-list-title {
    font-size: 28px;
    color: var(--primary-color);
    font-weight: 900;
    padding: 0 10px;
    line-height: 15px;
}

select {
    height: 40px;
    font-size: 20px;
    background: var(--body-color);
    color: var(--text-color);
    margin-left: 10px;
    padding: 10px;
    border: 1px solid var(--text-color);
    border-radius: 5px;
}

.insert-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    max-height: 50vh;
    overflow-y: auto;
}

#table-std {
    border: 2px solid var(--text-color);
    border-radius: 25px;
    padding: 10px 0;
    max-width: 960px;
    text-align: center;
    margin-bottom: 10px;
}

#table-std td:first-child,
#table-std th:first-child {
    text-align: left;
    width: 360px;
    padding-left: 60px;
}

#table-std th:nth-child(2) {
    text-align: center;
    width: 150px;
}

#table-std th:nth-child(3) {
    text-align: center;
    width: 150px;
}

#table-std th:nth-child(4) {
    width: 280px;
    text-align: center;
}

#table-std th {
    font-size: 25px;
    font-weight: 900;
    height: 70px;
    color: var(--primary-color);
}

#table-std td {
    font-size: 20px;
    padding: 0;
    height: 70px;
    color: var(--text-color);
}

.search-insert-title {
    display: flex;
    justify-content: space-evenly;
    margin-top: 55px;
}
.search-insert-title span {
    font-size: 28px;
    color: var(--primary-color);
    padding: 0 10px;
    font-weight: 900;
}
.search-insert-title .search-input {
    display: flex;
    align-items: center;
}

.search-insert-title input {
    height: 30px;
    width: 350px;
    font-size: 20px;
    border-radius: 8px;
    padding: 10px;
    border: 0;
}
.search-insert-title button {
    background-color: var(--primary-color);
    height: 30px;
    width: 50px;
    font-size: 20px;
    border-radius: 8px;
    border: 0;
    margin-left: 5px;
}
.search-insert-title button:hover {
    opacity: 0.5;
}

.search-insert-title i {
    display: flex;
    color: #fff;
    justify-content: center;
    align-items: center;
}

#table-std td button {
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

#table-std td #remove {
    border: 2px solid var(--remove-btn);
    color: var(--remove-btn);
}

#table-std td #remove:hover {
    background-color: var(--remove-btn);
    transition: var(--tran-03);
    color: var(--text-color);
}

#table-std td #change {
    border: 2px solid var(--change-btn);
    color: var(--change-btn);
}

#table-std td #change:hover {
    background-color: var(--change-btn);
    transition: var(--tran-03);
    color: var(--text-color);
}

/* CSS for mark insert tab */

.mark-title {
    display: flex;
    justify-content: space-around;
    margin-top: 55px;
}

.mark-title span {
    font-size: 33px;
    color: var(--primary-color);
    font-weight: 900;
    line-height: 15px;
}

.mark-select {
    display: flex;
    justify-content: center;
    margin: 30px;
}

.select-group {
    padding: 40px;
    border-bottom: 3px solid var(--text-color);
}

.select-group label {
    font-size: 28px;
    color: var(--text-color);
    font-weight: 900;
    padding: 20px;
}

.select-group #subject {
    width: 100px;
}

.mark-title-table {
    display: flex;
    justify-content: center;
    margin-top: 55px;
}

.mark-title-table span {
    position: absolute;
    left: 220px;
    font-size: 28px;
    color: var(--text-color);
    padding: 10px;
}

.btn-group-mark button {
    display: inline-flex;
    position: relative;
    right: -350px;
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
.btn-group-mark .btn-text {
    font-size: 20px;
    padding: 0px 15px 0px 0px;
}
.btn-group-mark i {
    font-size: 20px;
    padding-right: 5px;
    font-style: normal;
}
.btn-group-mark #refresh {
    background-color: #777;
}
.btn-group-mark #change {
    background-color: var(--change-btn);
}
.btn-group-mark button:hover {
    opacity: 0.75;
}

.mark-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    max-height: 50vh;
    overflow-y: auto;
}

.mark-table table {
    border: 2px solid var(--text-color);
    border-radius: 25px;
    padding: 10px 0;
    max-width: 960px;
    margin-bottom: 50px;
}

.mark-table td:first-child,
.mark-table th:first-child {
    width: 340px;
    padding-left: 40px;
}

.mark-table td:nth-child(2),
.mark-table th:nth-child(2) {
    width: 200px;
    text-align: center;
}
.mark-table td:nth-child(3),
.mark-table th:nth-child(3) {
    width: 200px;
    text-align: center;
}
.mark-table td:nth-child(4),
.mark-table th:nth-child(4) {
    width: 200px;
    text-align: center;
}

.mark-table th {
    height: 60px;
    font-size: 27px;
    color: var(--primary-color);
}

.mark-table td {
    height: 60px;
}

.mark-table table label {
    color: var(--text-color);
    font-size: 23px;
}

.mark-table table input {
    height: 30px;
    max-width: 120px;
    width: 100%;
    font-size: 20px;
    border-radius: 8px;
    padding: 10px;
    border: 0;
    text-align: center;
}

/* CSS for report tab */

.report-title {
    display: flex;
    justify-content: space-around;
    margin-top: 55px;
}

.report-title span {
    font-size: 33px;
    color: var(--primary-color);
    font-weight: 900;
    line-height: 15px;
}

.report-select {
    display: flex;
    justify-content: center;
    margin: 30px;
}

.select-group {
    padding: 40px;
    border-bottom: 3px solid var(--text-color);
}

.select-group label {
    font-size: 28px;
    color: var(--text-color);
    font-weight: 900;
    padding: 20px;
}

.select-group #subject {
    width: 100px;
}

.report-title-table {
    display: flex;
    justify-content: space-evenly;
    margin-top: 55px;
}

.report-title-table span {
    position: absolute;
    left: 300px;
    font-size: 28px;
    color: var(--text-color);
    padding: 10px;
}

.btn-group-report button {
    display: inline-flex;
    position: relative;
    right: -300px;
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
.btn-group-report .btn-text {
    font-size: 20px;
    padding: 0px 15px 0px 0px;
}
.btn-group-report i {
    font-size: 20px;
    padding-right: 5px;
    font-style: normal;
}
.btn-group-report #remove {
    background-color: var(--remove-btn);
}
.btn-group-report #change {
    background-color: var(--change-btn);
}
.btn-group-report button:hover {
    opacity: 0.75;
}

.report-table {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    max-height: 50vh;
    overflow-y: auto;
}

.report-table table {
    border: 2px solid var(--text-color);
    border-radius: 25px;
    margin-bottom: 50px;
}

.report-table th:nth-child(1) {
    width: 160px;
}
.report-table th:nth-child(2) {
    width: 160px;
}
.report-table th:nth-child(3) {
    width: 200px;
}
.report-table th:nth-child(4) {
    width: 160px;
}

.report-table table label {
    color: var(--text-color);
    font-size: 23px;
}

.report-table th {
    font-size: 27px;
    color: var(--primary-color);
}

.report-table table input {
    height: 30px;
    max-width: 250px;
    width: 100%;
    font-size: 20px;
    border-radius: 8px;
    padding: 10px;
    border: 0;
    text-align: center;
}

.report-table th,
td {
    height: 50px;
}
.report-table td {
    text-align: center;
    font-size: 20px;
    color: var(--text-color);
}
</style>
