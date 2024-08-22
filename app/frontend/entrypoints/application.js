import { createApp } from 'vue/dist/vue.esm-bundler';
import WeekSchedule from '../components/WeekSchedule.vue'
import WeekScheduleSummary from '../components/WeekScheduleSummary.vue'

const app = createApp({
    data() {
        return {
            message: 'Vite, Vue and Rails'
        }
    }
})

app.component('WeekSchedule', WeekSchedule)
app.component('WeekScheduleSummary', WeekScheduleSummary)

app.mount('#app');

console.log('Vite, Vue and Rails')
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')
