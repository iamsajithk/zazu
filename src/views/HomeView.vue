<script setup lang="ts">
import { onMounted, ref } from "vue";
import Datepicker from "vue3-datepicker";
import swal from "sweetalert2";
import axios from "axios";
import { useProgress } from "@marcoschulte/vue3-progress";

interface Account {
  id?: number;
  title: string;
  accountBalance: number;
  minimumBalance?: number;
  isSynced?: boolean;
  isSyncing?: boolean;
}

interface Income {
  id?: number;
  title: string;
  amount: number;
  isSynced?: boolean;
  isSyncing?: boolean;
}

interface Expense {
  id?: number;
  title: string;
  amount: number;
  isSynced?: boolean;
  isSyncing?: boolean;
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

const signInEmail = ref<string>("");
const signInPassword = ref<string>("");
const isSigningIn = ref<boolean>(false);

const signUpName = ref<string>("");
const signUpEmail = ref<string>("");
const signUpPassword = ref<string>("");

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
    isSyncing: false,
  });
  accountTitle.value = "";
  accountBalance.value = 0;
  minimumBalance.value = 0;
  saveUserProfile(true);
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
        saveUserProfile(false);
        if (account.id && account.id > 0 && userProfile.value.token) {
          //Do axios API call
          const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
          console.log(apiBaseUrl);
          axios
            .post(
              `${apiBaseUrl}/api/account/delete`,
              {
                id: account.id,
              },
              {
                headers: {
                  Authorization: `${userProfile.value.token}`,
                },
              }
            )
            .then(function (response: any) {})
            .catch(function (error: any) {
              console.log(error);
            });
        }
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
    isSyncing: false,
  });
  incomeTitle.value = "";
  incomeAmount.value = 0;
  saveUserProfile(true);
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
        saveUserProfile(false);
        if (income.id && income.id > 0 && userProfile.value.token) {
          //Do axios API call
          const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
          console.log(apiBaseUrl);
          axios
            .post(
              `${apiBaseUrl}/api/income/delete`,
              {
                id: income.id,
              },
              {
                headers: {
                  Authorization: `${userProfile.value.token}`,
                },
              }
            )
            .then(function (response: any) {})
            .catch(function (error: any) {
              console.log(error);
            });
        }
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
    isSyncing: false,
  });
  expenseTitle.value = "";
  expenseAmount.value = 0;
  saveUserProfile(true);
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
        saveUserProfile(false);
        if (expense.id && expense.id > 0 && userProfile.value.token) {
          //Do axios API call
          const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
          console.log(apiBaseUrl);
          axios
            .post(
              `${apiBaseUrl}/api/expense/delete`,
              {
                id: expense.id,
              },
              {
                headers: {
                  Authorization: `${userProfile.value.token}`,
                },
              }
            )
            .then(function (response: any) {})
            .catch(function (error: any) {
              console.log(error);
            });
        }
      }
    });
};

const saveUserProfile = (sync?: boolean) => {
  const userProfileToSave: UserProfile = {
    name: userProfile.value.name,
    email: userProfile.value.email,
    token: userProfile.value.token,
    profileName: userProfile.value.profileName,
    accounts: accounts.value,
    incomes: incomes.value,
    expenses: expenses.value,
  };
  localStorage.setItem("userProfile", JSON.stringify(userProfileToSave));
  if (sync && userProfile.value.token) {
    syncData();
  }
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

const saveAccount = (account: Account) => {
  //Set isSyncing to true
  const index = accounts.value.indexOf(account);
  accounts.value[index].isSyncing = true;
  const progress = useProgress().start();
  //Do axios API call
  const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
  console.log(apiBaseUrl);
  axios
    .post(
      `${apiBaseUrl}/api/account/save`,
      {
        id: account.id,
        name: account.title,
        account_balance: account.accountBalance,
        minimum_balance: account.minimumBalance,
      },
      {
        headers: {
          Authorization: `${userProfile.value.token}`,
        },
      }
    )
    .then(function (response: any) {
      progress.finish();
      console.log(response);
      if (response.data.status == "success") {
        if (response.data.id) {
          accounts.value[index].id = response.data.id;
          accounts.value[index].isSynced = true;
          accounts.value[index].isSyncing = false;
          saveUserProfile(false);
        }
      } else {
        swal.fire({ title: response.data.message });
      }
    })
    .catch(function (error: any) {
      progress.finish();
      console.log(error);
    });
};

const saveIncome = (income: Income) => {
  //Set isSyncing to true
  const index = incomes.value.indexOf(income);
  incomes.value[index].isSyncing = true;
  const progress = useProgress().start();
  //Do axios API call
  const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
  console.log(apiBaseUrl);
  axios
    .post(
      `${apiBaseUrl}/api/income/save`,
      {
        id: income.id,
        name: income.title,
        amount: income.amount,
      },
      {
        headers: {
          Authorization: `${userProfile.value.token}`,
        },
      }
    )
    .then(function (response: any) {
      progress.finish();
      console.log(response);
      if (response.data.status == "success") {
        if (response.data.id) {
          incomes.value[index].id = response.data.id;
          incomes.value[index].isSynced = true;
          incomes.value[index].isSyncing = false;
          saveUserProfile(false);
        }
      } else {
        swal.fire({ title: response.data.message });
      }
    })
    .catch(function (error: any) {
      progress.finish();
      console.log(error);
    });
};

const saveExpense = (expense: Expense) => {
  //Set isSyncing to true
  const index = expenses.value.indexOf(expense);
  expenses.value[index].isSyncing = true;
  const progress = useProgress().start();
  //Do axios API call
  const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
  console.log(apiBaseUrl);
  axios
    .post(
      `${apiBaseUrl}/api/expense/save`,
      {
        id: expense.id,
        name: expense.title,
        amount: expense.amount,
      },
      {
        headers: {
          Authorization: `${userProfile.value.token}`,
        },
      }
    )
    .then(function (response: any) {
      progress.finish();
      console.log(response);
      if (response.data.status == "success") {
        if (response.data.id) {
          expenses.value[index].id = response.data.id;
          expenses.value[index].isSynced = true;
          expenses.value[index].isSyncing = false;
          saveUserProfile(false);
        }
      } else {
        swal.fire({ title: response.data.message });
      }
    })
    .catch(function (error: any) {
      progress.finish();
      console.log(error);
    });
};

const syncData = () => {
  for (let account of accounts.value) {
    if (!account.isSynced) {
      saveAccount(account);
    }
  }
  for (let income of incomes.value) {
    if (!income.isSynced) {
      saveIncome(income);
    }
  }
  for (let expense of expenses.value) {
    if (!expense.isSynced) {
      saveExpense(expense);
    }
  }
};
const numberFormatter = (value: number) => {
  const formatter = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "INR",
  });
  return formatter.format(value);
};

const openAuthModal = () => {
  const authModal = document.getElementById("authModal");
  const authTabs = document.getElementById("authTabs");
  const authTabContent = document.getElementById("authTabContent");
  const signInTab = document.getElementById("signin-tab");
  const signInPane = document.getElementById("signin");
  const signUpTab = document.getElementById("signup-tab");
  const signUpPane = document.getElementById("signup");
  authModal?.classList.add("show");
  authModal?.setAttribute("aria-modal", "true");
  authModal?.setAttribute("style", "display: block");
  authModal?.setAttribute("aria-hidden", "false");
  authTabs?.classList.remove("fade");
  authTabContent?.classList.remove("fade");
  signInTab?.classList.add("active");
  signInPane?.classList.add("active");
  signInPane?.classList.add("show");
  signUpTab?.classList.remove("active");
  signUpPane?.classList.remove("active");
  signUpPane?.classList.remove("show");
};
const closeAuthModal = () => {
  const authModal = document.getElementById("authModal");
  const authTabs = document.getElementById("authTabs");
  const authTabContent = document.getElementById("authTabContent");
  const signInTab = document.getElementById("signin-tab");
  const signInPane = document.getElementById("signin");
  const signUpTab = document.getElementById("signup-tab");
  const signUpPane = document.getElementById("signup");
  authModal?.classList.remove("show");
  authModal?.setAttribute("aria-modal", "false");
  authModal?.setAttribute("style", "display: none");
  authModal?.setAttribute("aria-hidden", "true");
  authTabs?.classList.add("fade");
  authTabContent?.classList.add("fade");
  signInTab?.classList.add("active");
  signInPane?.classList.add("active");
  signInPane?.classList.add("show");
  signUpTab?.classList.remove("active");
  signUpPane?.classList.remove("active");
  signUpPane?.classList.remove("show");
};
const openSignInTab = () => {
  const signInTab = document.getElementById("signin-tab");
  const signInPane = document.getElementById("signin");
  const signUpTab = document.getElementById("signup-tab");
  const signUpPane = document.getElementById("signup");
  const authTabContent = document.getElementById("authTabContent");
  signInTab?.classList.add("active");
  signInPane?.classList.add("active");
  signInPane?.classList.add("show");
  signUpTab?.classList.remove("active");
  signUpPane?.classList.remove("active");
  signUpPane?.classList.remove("show");
  authTabContent?.classList.remove("fade");
};
const openSignUpTab = () => {
  const signInTab = document.getElementById("signin-tab");
  const signInPane = document.getElementById("signin");
  const signUpTab = document.getElementById("signup-tab");
  const signUpPane = document.getElementById("signup");
  const authTabContent = document.getElementById("authTabContent");
  signInTab?.classList.remove("active");
  signInPane?.classList.remove("active");
  signInPane?.classList.remove("show");
  signUpTab?.classList.add("active");
  signUpPane?.classList.add("active");
  signUpPane?.classList.add("show");
  authTabContent?.classList.remove("fade");
};
const openChatSection = () => {
  if (userProfile.value.token) {
  } else {
    openAuthModal();
  }
};

const doSignIn = () => {
  if (isSigningIn.value) {
    return;
  }
  isSigningIn.value = true;
  const progress = useProgress().start();
  //Do axios API call
  const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
  console.log(apiBaseUrl);
  axios
    .post(`${apiBaseUrl}/api/auth/sign-in`, {
      email: signInEmail.value,
      password: signInPassword.value,
    })
    .then(function (response: any) {
      isSigningIn.value = false;
      progress.finish();
      console.log(response);
      if (response.data.status == "success") {
        if (response.data.token) {
          signInEmail.value = "";
          signInPassword.value = "";
          userProfile.value.token = response.data.token;
          userProfile.value.name = response.data.name;
          userProfile.value.email = response.data.email;
          localStorage.setItem(
            "userProfile",
            JSON.stringify(userProfile.value)
          );
          closeAuthModal();
        }
      } else {
        swal.fire({ title: response.data.message });
      }
    })
    .catch(function (error: any) {
      isSigningIn.value = false;
      progress.finish();
      console.log(error);
    });
};
const doSignUp = () => {
  //Do axios API call
  const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
  console.log(apiBaseUrl);
  axios
    .post(`${apiBaseUrl}/api/auth/sign-up`, {
      name: signUpName.value,
      email: signUpEmail.value,
      password: signUpPassword.value,
    })
    .then(function (response: any) {
      console.log(response);
      if (response.data.status == "success") {
        if (response.data.token) {
          signUpName.value = "";
          signUpEmail.value = "";
          signUpPassword.value = "";
          userProfile.value.token = response.data.token;
          userProfile.value.name = response.data.name;
          userProfile.value.email = response.data.email;
          localStorage.setItem(
            "userProfile",
            JSON.stringify(userProfile.value)
          );
          closeAuthModal();
        }
      } else {
        swal.fire({ title: response.data.message });
      }
    })
    .catch(function (error: any) {
      console.log(error);
    });
};

const doLogOut = () => {
  localStorage.removeItem("userProfile");
  userProfile.value = {
    profileName: "My Profile",
    accounts: [],
    incomes: [],
    expenses: [],
  };
  accounts.value = [];
  incomes.value = [];
  expenses.value = [];
  saveUserProfile();
};
</script>

  <template>
  <vue3-progress-bar></vue3-progress-bar>
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
        <button @click="openChatSection" class="btn btn-success btn-lg">
          Ask Zazu
        </button>
        <button
          @click="doLogOut"
          v-if="userProfile.token"
          class="btn btn-warning btn-lg"
        >
          Log Out
        </button>
        <button
          @click="syncData"
          v-if="userProfile.token"
          class="btn icon-button btn-danger"
        >
          <v-icon name="fa-sync" />
        </button>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div
    class="modal fade"
    id="authModal"
    tabindex="-1"
    aria-labelledby="authModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="authModalLabel">Sign In/Sign Up</h5>
          <button
            type="button"
            class="btn-close"
            @click="closeAuthModal"
          ></button>
        </div>
        <div class="modal-body">
          <!-- Authentication tabs -->
          <ul class="nav nav-tabs" id="authTabs" role="tablist">
            <li class="nav-item" role="presentation">
              <a
                class="nav-link active"
                id="signin-tab"
                @click="openSignInTab"
                role="tab"
                aria-controls="signin"
                aria-selected="true"
                >Sign In</a
              >
            </li>
            <li class="nav-item" role="presentation">
              <a
                class="nav-link"
                id="signup-tab"
                @click="openSignUpTab"
                role="tab"
                aria-controls="signup"
                aria-selected="false"
                >Sign Up</a
              >
            </li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content" id="authTabContent">
            <!-- Sign In Tab -->
            <div
              class="tab-pane fade show active"
              id="signin"
              role="tabpanel"
              aria-labelledby="signin-tab"
            >
              <!-- Sign In Form -->
              <form @submit.prevent="doSignIn">
                <div class="mb-3">
                  <label for="signInEmail" class="form-label"
                    >Email address</label
                  >
                  <input
                    type="email"
                    class="form-control"
                    id="signInEmail"
                    v-model="signInEmail"
                    placeholder="Enter your email"
                  />
                </div>
                <div class="mb-3">
                  <label for="signInPassword" class="form-label"
                    >Password</label
                  >
                  <input
                    type="password"
                    class="form-control"
                    id="signInPassword"
                    v-model="signInPassword"
                    placeholder="Enter your password"
                  />
                </div>
                <button type="submit" class="btn btn-primary">Sign In</button>
              </form>
            </div>

            <!-- Sign Up Tab -->
            <div
              class="tab-pane fade"
              id="signup"
              role="tabpanel"
              aria-labelledby="signup-tab"
            >
              <!-- Sign Up Form -->
              <form @submit.prevent="doSignUp">
                <div class="mb-3">
                  <label for="signUpName" class="form-label">Name</label>
                  <input
                    type="text"
                    class="form-control"
                    id="signUpName"
                    v-model="signUpName"
                    placeholder="Enter your name"
                  />
                </div>
                <div class="mb-3">
                  <label for="signUpEmail" class="form-label"
                    >Email address</label
                  >
                  <input
                    type="email"
                    class="form-control"
                    id="signUpEmail"
                    v-model="signUpEmail"
                    placeholder="Enter your email"
                  />
                </div>
                <div class="mb-3">
                  <label for="signUpPassword" class="form-label"
                    >Password</label
                  >
                  <input
                    type="password"
                    class="form-control"
                    id="signUpPassword"
                    v-model="signUpPassword"
                    placeholder="Create a password"
                  />
                </div>
                <button type="submit" class="btn btn-primary">Sign Up</button>
              </form>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <p class="text-muted">
            Already have an account?
            <a
              class="link"
              @click="openSignInTab"
              role="tab"
              aria-controls="signin"
              aria-selected="true"
              >Sign In</a
            >
          </p>
          <p class="text-muted">
            Need an account?
            <a
              class="link"
              @click="openSignUpTab"
              role="tab"
              aria-controls="signup"
              aria-selected="false"
              >Sign Up</a
            >
          </p>
        </div>
      </div>
    </div>
  </div>
</template>