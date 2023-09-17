import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { OhVueIcon, addIcons } from "oh-vue-icons";
import * as FaIcons from "oh-vue-icons/icons/fa";
import {Vue3ProgressPlugin} from '@marcoschulte/vue3-progress';

const Fa = Object.values({ ...FaIcons });
addIcons(...Fa);
const app = createApp(App)
app.component("v-icon", OhVueIcon);
app.use(Vue3ProgressPlugin);
app.use(router)

app.mount('#app')
