import { createApp } from 'vue/dist/vue.esm-bundler';
import ButtonCounter from '../components/ButtonCounter.vue'

const app = createApp({
    data() {
        return {
            message: 'Vite, Vue and Rails'
        }
    }
})

app.component('ButtonCounter', ButtonCounter)

app.mount('#app');

console.log('Vite, Vue and Rails')
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')
