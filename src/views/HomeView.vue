<script setup lang="ts">
import { ref } from "vue";
import Datepicker from "vue3-datepicker";

interface Account {
  title: string;
  accountBalance: number;
  minimumBalance?: number;
}

const accounts = ref<Account[]>([]);
const accountTitle = ref<string>("");
const accountBalance = ref<number>(0);
const minimumBalance = ref<number>(0);

const addAccount = () => {
  accounts.value.push({
    title: accountTitle.value,
    accountBalance: accountBalance.value,
    minimumBalance: minimumBalance.value,
  });
  accountTitle.value = "";
  accountBalance.value = 0;
  minimumBalance.value = 0;
};
</script>

  <template>
  <div class="container">
    <div class="row">
      <div class="col-12 text-center">
        <h1>ZAZU</h1>
      </div>
    </div>
    <div class="row">
      <!-- Accounts section starts -->
      <div class="col-6">
        <div class="form-wrap">
          <h5 class="mb-3">Accounts</h5>
          <div class="row g-3 mb-3">
            <div class="col-6">
              <input
                type="text"
                class="form-control"
                placeholder="Account Title"
                v-model="accountTitle"
              />
            </div>
          </div>
          <div class="row g-3">
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
            <div class="col-auto">
              <label>Select date</label>
              <datepicker />
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
                Balance: <b>{{ account.accountBalance }}</b>
              </p>
              <p>
                Minimum Balance: <b>{{ account.minimumBalance }}</b>
              </p>
            </div>
          </div>
          <div class="empty-state" style="text-align: center">
            <img src="../assets/no-data.png" alt="" />
          </div>
        </div>
      </div>
      <!-- Accounts section ends -->
      <!-- Incomes section starts -->
      <div class="col-6">
        <div class="form-wrap">
          <h5 class="mb-3">Incomes</h5>
          <div class="row g-3 mb-3">
            <div class="col-6">
              <input
                type="text"
                class="form-control"
                placeholder="Income Title"
                v-model="accountTitle"
              />
            </div>
          </div>
          <div class="row g-3">
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
            <div class="col-auto">
              <label>Select date</label>
              <datepicker />
            </div>
            <div class="col-12">
              <button class="btn btn-primary" @click="addAccount">
                Add Income
              </button>
            </div>
          </div>
        </div>
        <div class="listing-wrap">
          <h5>Your Incomes</h5>
          <div
            class="data-card"
            v-for="account in accounts"
            v-bind:key="account.title"
          >
            <h5>{{ account.title }}</h5>
            <div class="content">
              <p>
                Balance: <b>{{ account.accountBalance }}</b>
              </p>
              <p>
                Minimum Balance: <b>{{ account.minimumBalance }}</b>
              </p>
            </div>
          </div>
          <div class="empty-state" style="text-align: center">
            <img src="../assets/no-data.png" alt="" />
          </div>
        </div>
      </div>
      <!-- Incomes section ends -->
    </div>
  </div>
</template>