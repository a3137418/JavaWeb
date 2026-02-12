<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

        <t:base pageTitle="客戶端首頁">
            <jsp:attribute name="head_scripts">
                <style>
                    .customer-table-container {
                        border: 1px solid var(--cyber-cyan);
                        background: rgba(13, 2, 8, 0.9);
                        backdrop-filter: blur(10px);
                        padding: 20px;
                        border-radius: 10px;
                        box-shadow: 0 0 20px rgba(0, 240, 255, 0.2);
                        margin-top: 20px;
                    }

                    .table {
                        color: var(--cyber-cyan);
                    }

                    .table-hover tbody tr:hover {
                        background-color: rgba(0, 240, 255, 0.1);
                        color: white;
                    }

                    .pagination .page-link {
                        background-color: var(--cyber-dark);
                        border-color: var(--cyber-cyan);
                        color: var(--cyber-cyan);
                    }

                    .pagination .page-item.active .page-link {
                        background-color: var(--cyber-cyan);
                        border-color: var(--cyber-cyan);
                        color: var(--cyber-dark);
                    }

                    .pagination .page-item.disabled .page-link {
                        background-color: #333;
                        border-color: #444;
                        color: #666;
                    }

                    .loading-spinner {
                        color: var(--cyber-pink);
                    }
                </style>
            </jsp:attribute>

            <jsp:attribute name="footer_scripts">
                <script>
                    const { createApp } = Vue;
                    createApp({
                        //建構Vue物件的初始化(採用JavaScript物件架構)
                        //宣告資料模組
                        data() {
                            return {
                                customers: [],      // 原始資料(等待回呼多筆多欄客戶資料 建構陣列)
                                isLoading: true,    // 載入狀態
                                currentPage: 1,     // 目前頁碼
                                pageSize: 10,       // 每頁筆數
                                editingCustomer: {} // 當前編輯的客戶資料
                            }
                        },
                        //JS物件客製化物件屬性 規劃唯讀計算功能
                        computed: {
                            // 根據目前頁碼計算呈現的資料
                            pagedCustomers() {
                                const start = (this.currentPage - 1) * this.pageSize;
                                const end = start + this.pageSize;
                                return this.customers.slice(start, end);
                            },
                            // 總頁數
                            totalPages() {
                                return Math.ceil(this.customers.length / this.pageSize);
                            }
                        },
                        methods: {
                            // 呼叫後端 API 非同步定義函數
                            async fetchCustomers() {
                                this.isLoading = true;
                                try {
                                    //採用axios 進行ajax呼喚 後端服務 採用Request Method-GET
                                    const response = await axios.get('${pageContext.request.contextPath}/api/v1/customers/all');
                                    //正常執行callbck 透過XMLHttpRequest.response物件
                                    this.customers = response.data;
                                    //蹦出對話盒

                                    Swal.fire({
                                        icon: 'success',
                                        title: '下載完成',
                                        text: '成功同步 ' + this.customers.length + ' 筆客戶資料。',
                                        confirmButtonText: '確定',
                                        background: '#1a1a1a',
                                        color: '#00f0ff',
                                        confirmButtonColor: '#00f0ff'
                                    });



                                } catch (error) {
                                    //後端執行有錯誤 http status code 4xx or 5xx
                                    console.error('獲取客戶資料失敗:', error); //瀏覽器主控台
                                    //呼叫SweetAlert2 啟動對話盒
                                    Swal.fire({
                                        icon: 'error',
                                        title: '連線失敗',
                                        text: '無法從伺-端獲取客戶資料，請稍後再試。',
                                        background: '#1a1a1a',
                                        color: '#00f0ff',
                                        confirmButtonColor: '#ff003c'
                                    });
                                } finally {
                                    this.isLoading = false;
                                }
                            },
                            // 跳轉頁面
                            changePage(page) {
                                if (page < 1 || page > this.totalPages) return;
                                this.currentPage = page;
                            },
                            // 編輯客戶
                            editCustomer(customer) {
                                // 複製一份資料避免直接修改 table 中的原始資料
                                this.editingCustomer = { ...customer };

                                // 取得 Modal 實體並顯示
                                const editModalElement = document.getElementById('editCustomerModal');
                                const modal = new bootstrap.Modal(editModalElement);
                                modal.show();
                            },
                            // 儲存編輯結果 (模擬)
                            async saveCustomer() {
                                // 這裡未來可以加入 API 更新邏輯
                                Swal.fire({
                                    title: '儲存成功',
                                    text: '客戶「' + this.editingCustomer.companyName + '」資料已更新 (模擬)。',
                                    icon: 'success',
                                    background: '#1a1a1a',
                                    color: '#00f0ff',
                                    confirmButtonColor: '#00f0ff'
                                });

                                // 關閉 Modal (手動操作 DOM)
                                const modalElement = document.getElementById('editCustomerModal');
                                const modalInstance = bootstrap.Modal.getInstance(modalElement);
                                modalInstance.hide();

                                // 同步更新本地資料陣列
                                const index = this.customers.findIndex(c => c.customerID === this.editingCustomer.customerID);
                                if (index !== -1) {
                                    this.customers[index] = { ...this.editingCustomer };
                                }
                            },
                            // 刪除客戶
                            deleteCustomer(customer) {
                                Swal.fire({
                                    title: '確認刪除？',
                                    text: '您確定要刪除「' + customer.companyName + '」嗎？',
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#ff003c',
                                    cancelButtonColor: '#333',
                                    confirmButtonText: '確定刪除',
                                    cancelButtonText: '取消',
                                    background: '#1a1a1a',
                                    color: '#00f0ff'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        // 這裡未來可以加入 API 刪除邏輯
                                        Swal.fire({
                                            title: '已刪除',
                                            text: '客戶資料已從系統移除 (模擬)。',
                                            icon: 'success',
                                            background: '#1a1a1a',
                                            color: '#00f0ff'
                                        });
                                    }
                                });
                            }
                        },
                        //Vue 生命週期引發的事件 當Vue掛載在DOM標籤完成引發事件程序
                        mounted() {
                            // 初始化時呼叫
                            this.fetchCustomers();
                        }
                    }).mount('#app-content'); //掛載DOM 進行Binding與Rendering
                </script>
            </jsp:attribute>

            <jsp:body>
                <div id="app-content">
                    <div class="customer-table-container">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2 class="glitch-text mb-0">客戶資料清單</h2>
                            <span class="badge bg-info text-dark">共 {{ customers.length }} 筆資料</span>
                        </div>

                        <!-- 載入中狀態 -->
                        <div v-if="isLoading" class="text-center my-5">
                            <div class="spinner-border loading-spinner" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2 text-info">正在同步網路資料庫資料...</p>
                        </div>

                        <!-- 資料表格 -->
                        <div v-else class="table-responsive">
                            <table class="table table-dark table-hover table-striped align-middle">
                                <thead class="table-pink">
                                    <tr>
                                        <th>操作</th>
                                        <th>客戶編號</th>
                                        <th>公司名稱</th>
                                        <th>地址</th>
                                        <th>電話</th>
                                        <th>國家</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!--MVVM 一般使用 tag 擴充attribute當作指令操作-->
                                    <tr v-for="c in pagedCustomers" :key="c.customerID">
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <button class="btn btn-outline-info" @click="editCustomer(c)">
                                                    <i class="bi bi-pencil-square me-1"></i> 編輯
                                                </button>
                                                <button class="btn btn-outline-danger" @click="deleteCustomer(c)">
                                                    <i class="bi bi-trash me-1"></i> 刪除
                                                </button>
                                            </div>
                                        </td>
                                        <td class="text-info fw-bold">{{ c.customerID }}</td>
                                        <td>{{ c.companyName }}</td>
                                        <td>{{ c.address }}</td>
                                        <td>{{ c.phone }}</td>
                                        <td>
                                            <span class="badge border border-cyan">{{ c.country }}</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <!-- 分頁控制項 -->
                            <nav aria-label="Page navigation" class="mt-4">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item" :class="{ disabled: currentPage === 1 }">
                                        <a class="page-link" href="#" @click.prevent="changePage(currentPage - 1)">
                                            <i class="bi bi-chevron-left"></i> 上一頁
                                        </a>
                                    </li>

                                    <li v-for="p in totalPages" :key="p" class="page-item"
                                        :class="{ active: p === currentPage }">
                                        <a class="page-link" href="#" @click.prevent="changePage(p)">{{ p }}</a>
                                    </li>

                                    <li class="page-item" :class="{ disabled: currentPage === totalPages }">
                                        <a class="page-link" href="#" @click.prevent="changePage(currentPage + 1)">
                                            下一頁 <i class="bi bi-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                        <div class="mt-4 text-center">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-info">
                                <i class="bi bi-house-door me-1"></i> 回到系統首頁
                            </a>
                        </div>

                        <!-- 編輯客戶資料 Modal -->
                        <div class="modal fade" id="editCustomerModal" tabindex="-1"
                            aria-labelledby="editCustomerModalLabel" aria-hidden="true" data-bs-backdrop="static">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content bg-dark text-info border border-cyan">
                                    <div class="modal-header border-bottom border-secondary">
                                        <h5 class="modal-title" id="editCustomerModalLabel">
                                            <i class="bi bi-pencil-square me-2"></i>編輯客戶資料
                                        </h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form @submit.prevent="saveCustomer">
                                            <div class="mb-3">
                                                <label for="customerID" class="form-label">客戶編號 (唯讀)</label>
                                                <input type="text" class="form-control bg-secondary text-white"
                                                    id="customerID" v-model="editingCustomer.customerID" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="companyName" class="form-label">公司名稱</label>
                                                <input type="text" class="form-control bg-dark text-white border-cyan"
                                                    id="companyName" v-model="editingCustomer.companyName" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="address" class="form-label">地址</label>
                                                <input type="text" class="form-control bg-dark text-white border-cyan"
                                                    id="address" v-model="editingCustomer.address">
                                            </div>
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">電話</label>
                                                <input type="text" class="form-control bg-dark text-white border-cyan"
                                                    id="phone" v-model="editingCustomer.phone">
                                            </div>
                                            <div class="mb-3">
                                                <label for="country" class="form-label">國家</label>
                                                <input type="text" class="form-control bg-dark text-white border-cyan"
                                                    id="country" v-model="editingCustomer.country">
                                            </div>
                                            <div class="text-end mt-4">
                                                <button type="button" class="btn btn-secondary me-2"
                                                    data-bs-dismiss="modal">取消</button>
                                                <button type="submit" class="btn btn-info">儲存變更</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </jsp:body>

        </t:base>