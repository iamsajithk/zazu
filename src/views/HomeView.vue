<script setup lang="ts">
import { onMounted, ref } from "vue";
import Datepicker from "vue3-datepicker";
import swal from "sweetalert2";

interface Account {
  id?: number;
  title: string;
  accountBalance: number;
  minimumBalance?: number;
  isSynced?: boolean;
}

interface Income {
  id?: number;
  title: string;
  amount: number;
  isSynced?: boolean;
}

interface Expense {
  id?: number;
  title: string;
  amount: number;
  isSynced?: boolean;
}

interface UserProfile {
  id?: number;
  name?: string;
  email?: string;
  token?: string;
  profileName: string;
  accounts?: Account[];
  incomes?: Income[];
  expenses?: Expense[];
}

const accounts = ref<Account[]>([]);
const accountTitle = ref<string>("");
const accountBalance = ref<number>(0);
const minimumBalance = ref<number>(0);

const incomes = ref<Income[]>([]);
const incomeTitle = ref<string>("");
const incomeAmount = ref<number>(0);

const expenses = ref<Expense[]>([]);
const expenseTitle = ref<string>("");
const expenseAmount = ref<number>(0);

const userProfile = ref<UserProfile>({
  profileName: "My Profile",
  accounts: [],
  incomes: [],
  expenses: [],
});

onMounted(() => {
  loadUserProfile();
});
const addAccount = () => {
  if (accountTitle.value == "") {
    swal.fire({ title: "Please enter account title" });
    return;
  }
  if (!accountBalance.value) {
    accountBalance.value = 0;
  }
  if (!minimumBalance.value) {
    minimumBalance.value = 0;
  }
  accounts.value.push({
    title: accountTitle.value,
    accountBalance: accountBalance.value,
    minimumBalance: minimumBalance.value,
    isSynced: false,
  });
  accountTitle.value = "";
  accountBalance.value = 0;
  minimumBalance.value = 0;
  saveUserProfile();
};
const deleteAccount = (account: Account) => {
  //Ask swal confirm
  swal
    .fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Delete",
      cancelButtonText: "Cancel",
      confirmButtonColor: "#dc3545",
      cancelButtonColor: "#6c757d",
      reverseButtons: true,
    })
    .then((result) => {
      if (result.isConfirmed) {
        const index = accounts.value.indexOf(account);
        accounts.value.splice(index, 1);
        saveUserProfile();
      }
    });
};

const addIncome = () => {
  if (incomeTitle.value == "") {
    swal.fire({ title: "Please enter income title" });
    return;
  }
  if (!incomeAmount.value) {
    incomeAmount.value = 0;
  }
  incomes.value.push({
    title: incomeTitle.value,
    amount: incomeAmount.value,
    isSynced: false,
  });
  incomeTitle.value = "";
  incomeAmount.value = 0;
  saveUserProfile();
};
const deleteIncome = (income: Income) => {
  //Ask swal confirm
  swal
    .fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Delete",
      cancelButtonText: "Cancel",
      confirmButtonColor: "#dc3545",
      cancelButtonColor: "#6c757d",
      reverseButtons: true,
    })
    .then((result) => {
      if (result.isConfirmed) {
        const index = incomes.value.indexOf(income);
        incomes.value.splice(index, 1);
        saveUserProfile();
      }
    });
};

const addExpense = () => {
  if (expenseTitle.value == "") {
    swal.fire({ title: "Please enter expense title" });
    return;
  }
  if (!expenseAmount.value) {
    expenseAmount.value = 0;
  }
  expenses.value.push({
    title: expenseTitle.value,
    amount: expenseAmount.value,
    isSynced: false,
  });
  expenseTitle.value = "";
  expenseAmount.value = 0;
  saveUserProfile();
};
const deleteExpense = (expense: Expense) => {
  //Ask swal confirm
  swal
    .fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Delete",
      cancelButtonText: "Cancel",
      confirmButtonColor: "#dc3545",
      cancelButtonColor: "#6c757d",
      reverseButtons: true,
    })
    .then((result) => {
      if (result.isConfirmed) {
        const index = expenses.value.indexOf(expense);
        expenses.value.splice(index, 1);
        saveUserProfile();
      }
    });
};

const saveUserProfile = () => {
  const userProfile: UserProfile = {
    profileName: "My Profile",
    accounts: accounts.value,
    incomes: incomes.value,
    expenses: expenses.value,
  };
  localStorage.setItem("userProfile", JSON.stringify(userProfile));
};

const loadUserProfile = () => {
  const storedUserProfile = localStorage.getItem("userProfile");
  if (storedUserProfile) {
    const parsedUserProfile = JSON.parse(storedUserProfile);
    if (parsedUserProfile.accounts) {
      accounts.value = parsedUserProfile.accounts;
      userProfile.value.accounts = accounts.value;
    } else {
      accounts.value = [];
    }
    if (parsedUserProfile.incomes) {
      incomes.value = parsedUserProfile.incomes;
      userProfile.value.incomes = incomes.value;
    } else {
      incomes.value = [];
    }
    if (parsedUserProfile.expenses) {
      expenses.value = parsedUserProfile.expenses;
      userProfile.value.expenses = expenses.value;
    } else {
      expenses.value = [];
    }
    userProfile.value = parsedUserProfile;
  }
};
const numberFormatter = (value: number) => {
  const formatter = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "INR",
  });
  return formatter.format(value);
};
</script>

  <template>
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div>
          <img src="/src/assets/logo.png" class="logo dib" />
          <h1 class="dib">Zazu</h1>
        </div>
      </div>
    </div>
    <div class="row">
      <!-- Accounts section starts -->
      <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="form-wrap">
          <h5 class="mb-3">Accounts</h5>
          <!-- <div class="row g-3 mb-3">
            <div class="col-6">
              <input
                type="text"
                class="form-control"
                placeholder="Account Title"
                v-model="accountTitle"
              />
            </div>
          </div> -->
          <div class="row g-3">
            <div class="col-auto">
              <label>Account Title</label>
              <input
                type="text"
                class="form-control"
                placeholder="Account Title"
                v-model="accountTitle"
              />
            </div>
            <div class="col-auto">
              <label>Account Balance</label>
              <input
                type="number"
                class="form-control"
                placeholder="Account Balance"
                v-model="accountBalance"
              />
            </div>
            <div class="col-auto">
              <label>Minimum Balance</label>
              <input
                type="number"
                class="form-control"
                placeholder="Minimum Balance"
                v-model="minimumBalance"
              />
            </div>
            <div class="col-12">
              <button class="btn btn-primary" @click="addAccount">
                Add Account
              </button>
            </div>
          </div>
        </div>
        <div class="listing-wrap">
          <h5>Your Accounts</h5>
          <div
            class="data-card"
            v-for="account in accounts"
            v-bind:key="account.title"
          >
            <h5>{{ account.title }}</h5>
            <div class="content">
              <p>
                Balance:
                <b>{{
                  account.accountBalance !== undefined
                    ? numberFormatter(account.accountBalance)
                    : ""
                }}</b>
              </p>
              <p>
                Minimum Balance:
                <b>{{
                  account.minimumBalance !== undefined
                    ? numberFormatter(account.minimumBalance)
                    : ""
                }}</b>
              </p>
              <p>
                <!-- <button class="btn icon-button btn-info">
                  <v-icon name="fa-pencil-alt" />
                </button> -->
                <button
                  @click="deleteAccount(account)"
                  class="btn icon-button btn-danger"
                >
                  <v-icon name="fa-trash" />
                </button>
              </p>
            </div>
          </div>
          <div
            class="empty-state"
            style="text-align: center"
            v-if="accounts.length == 0"
          >
            <img src="../assets/no-data.png" alt="" />
          </div>
        </div>
      </div>
      <!-- Accounts section ends -->
      <!-- Incomes section starts -->
      <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="form-wrap">
          <h5 class="mb-3">Incomes</h5>
          <!-- <div class="row g-3 mb-3">
            <div class="col-6">
              <input
                type="text"
                class="form-control"
                placeholder="Income Title"
                v-model="accountTitle"
              />
            </div>
          </div> -->
          <div class="row g-3">
            <div class="col-auto">
              <label>Income Title</label>
              <input
                type="text"
                class="form-control"
                placeholder="Income Title"
                v-model="incomeTitle"
              />
            </div>
            <div class="col-auto">
              <label>Amount</label>
              <input
                type="number"
                class="form-control"
                placeholder="Amount"
                v-model="incomeAmount"
              />
            </div>
            <div class="col-12">
              <button class="btn btn-primary" @click="addIncome">
                Add Income
              </button>
            </div>
          </div>
        </div>
        <div class="listing-wrap">
          <h5>Your Incomes</h5>
          <div
            class="data-card"
            v-for="income in incomes"
            v-bind:key="income.title"
          >
            <h5>{{ income.title }}</h5>
            <div class="content">
              <p>
                Amount:
                <b>{{
                  income.amount !== undefined
                    ? numberFormatter(income.amount)
                    : ""
                }}</b>
              </p>
              <p>
                <!-- <button class="btn icon-button btn-info">
                  <v-icon name="fa-pencil-alt" />
                </button> -->
                <button
                  @click="deleteIncome(income)"
                  class="btn icon-button btn-danger"
                >
                  <v-icon name="fa-trash" />
                </button>
              </p>
            </div>
          </div>
          <div
            class="empty-state"
            style="text-align: center"
            v-if="incomes.length == 0"
          >
            <img src="../assets/no-data.png" alt="" />
          </div>
        </div>
      </div>
      <!-- Incomes section ends -->
      <!-- Expenses section starts -->
      <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="form-wrap">
          <h5 class="mb-3">Expenses</h5>
          <!-- <div class="row g-3 mb-3">
            <div class="col-6">
              <input
                type="text"
                class="form-control"
                placeholder="Expense Title"
                v-model="accountTitle"
              />
            </div>
          </div> -->
          <div class="row g-3">
            <div class="col-auto">
              <label>Expense Title</label>
              <input
                type="text"
                class="form-control"
                placeholder="Expense Title"
                v-model="expenseTitle"
              />
            </div>
            <div class="col-auto">
              <label>Amount</label>
              <input
                type="number"
                class="form-control"
                placeholder="Amount"
                v-model="expenseAmount"
              />
            </div>
            <!-- <div class="col-auto">
              <label>Select date</label>
              <datepicker />
            </div> -->
            <div class="col-12">
              <button class="btn btn-primary" @click="addExpense">
                Add Expense
              </button>
            </div>
          </div>
        </div>
        <div class="listing-wrap">
          <h5>Your Expenses</h5>
          <div
            class="data-card"
            v-for="expense in expenses"
            v-bind:key="expense.title"
          >
            <h5>{{ expense.title }}</h5>
            <div class="content">
              <p>
                Amount:
                <b>{{
                  expense.amount !== undefined
                    ? numberFormatter(expense.amount)
                    : ""
                }}</b>
              </p>
              <p>
                <!-- <button class="btn icon-button btn-info">
                  <v-icon name="fa-pencil-alt" />
                </button> -->
                <button
                  @click="deleteExpense(expense)"
                  class="btn icon-button btn-danger"
                >
                  <v-icon name="fa-trash" />
                </button>
              </p>
            </div>
          </div>
          <div
            class="empty-state"
            style="text-align: center"
            v-if="expenses.length == 0"
          >
            <img src="../assets/no-data.png" alt="" />
          </div>
        </div>
      </div>
      <!-- Expenses section ends -->
      <div class="col-12 text-center mb-5">
        <button class="btn btn-success btn-lg">Ask Zazu</button>
      </div>
    </div>
  </div>
</template>