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
          <button class="btn btn-primary" @click="addAccount">Add Account</button>
        </div>
      </div>
    </div>
    <div class="listing-wrap">
      <h5>Saved plans</h5>
      <div class="data-card" v-for="account in accounts" v-bind:key="account.title">
          <h5>{{ account.title }}</h5>
          <div class="content">
            <p>Balance: <b>{{ account.accountBalance }}</b></p>
            <p>Minimum Balance: <b>{{ account.minimumBalance }}</b></p>
          </div>
      </div>
      <div class="empty-state" style="text-align: center;">
        <img src="../assets/no data.png" alt="">
      </div>
    </div>
  </div>
</template>

<style type="scss">
  .form-wrap{
    padding: 20px;
    border: 1px solid #cdcdcd;
    margin-bottom: 20px;
    border-radius:24px;
  }
  label{
    color: #9b9b9b;
  }
  .form-control{
    border-radius: 8px;
    padding: 10px 20px;
    box-shadow: none!important;
  }
  .btn{
    border-radius: 8px;
    padding: 10px 20px;
  }
  .v3dp__datepicker input{
    border-radius: 8px!important;
    box-shadow: none!important;
    padding: 10px 20px;
    border: 1px solid #cdcdcd;
  }
  .listing-wrap{
    padding: 20px;
    border: 1px solid #cdcdcd;
    margin-bottom: 20px;
    border-radius:24px;
  }
  .listing-wrap .data-card{
    padding-left: 24px;
    border-left: 1px solid #cdcdcd;
    position: relative;
    margin-left: 13px;
    margin-top: 15px;
  }
  .listing-wrap .data-card ::before{
    position: absolute;
    content: url(/src/assets/wallet.svg);
    left: -15px;
    top: 0;
    width: 30px;
    height: 30px;
    padding: 5px;
    border-radius: 40px;
    display: grid;
    place-items: center;
    background: #000;
  }
  .listing-wrap .data-card p{
    margin-bottom: 5px;
  }
  .listing-wrap .content{

  }
</style>