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
        <h1>Zazu</h1>
      </div>
    </div>
    <div class="row">
      <div class="col-6">
        <h5>Accounts</h5>
        <input
          type="text"
          class="form-control"
          placeholder="Account Title"
          v-model="accountTitle"
        />
        <input
          type="number"
          class="form-control"
          placeholder="Account Balance"
          v-model="accountBalance"
        />
        <input
          type="number"
          class="form-control"
          placeholder="Minimum Balance"
          v-model="minimumBalance"
        />
        <datepicker />
        <button class="btn btn-primary" @click="addAccount">Add Account</button>
        <div v-for="account in accounts" v-bind:key="account.title">
          <h6>{{ account.title }}</h6>
          <p>Balance: {{ account.accountBalance }}</p>
          <p>Minimum Balance: {{ account.minimumBalance }}</p>
        </div>
      </div>
    </div>
  </div>
</template>
