read -p "What do you want to name this Laravel Project?" project_name
cd C:/Users/crisc/Developer/Sites
laravel new ${project_name}
cd ${project_name}
composer install
yarn add -D tailwindcss postcss autoprefixer vue@next vue-loader@next
npx tailwindcss init -p
rm tailwind.config.js 
touch tailwind.config.js
chmod 755 tailwind.config.js
echo '/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./resources/**/*.blade.php",
    "./resources/**/*.js",
    "./resources/**/*.vue",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}' >> tailwind.config.js 
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" >> resources/css/app.css 
sed -i '12 i @vite(["resources/css/app.css", "resources/js/app.js"])' resources/views/welcome.blade.php
sed -i '20 i <div id="app">' resources/views/welcome.blade.php
sed -i '140 i </div>' resources/views/welcome.blade.php
sed -i '42 i <welcome-component></welcome-component>' resources/views/welcome.blade.php
yarn add @vitejs/plugin-vue
rm vite.config.js
touch vite.config.js
chmod 755 vite.config.js
echo 'import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";

import vue from "@vitejs/plugin-vue"

export default defineConfig({
    plugins: [
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
        laravel({
            input: ["resources/css/app.css", "resources/js/app.js"],
            refresh: true,
        }),
    ],
    resolve: {
        alias: {
            vue: "vue/dist/vue.esm-bundler.js",
        },
    },
});' >> vite.config.js
rm resources/js/app.js
touch resources/js/app.js
chmod 755 resources/js/app.js
echo 'import "./bootstrap";

import {createApp} from "vue"

import App from "./components/App.vue"

const app = createApp({});

app.component("welcome-component", App);

app.mount("#app");' >> resources/js/app.js
mkdir resources/js/components
touch resources/js/components/App.vue
echo '<template>
    <h1 class="text-center mb-8 font-bold">
        Vue 3 & Tailwind have been installed
    </h1>
</template>
<script>
</script>' >> resources/js/components/App.vue
yarn build
echo 'All good to go!'
code .