echo ' Welcome to Tailvel 0.0.2'
echo ' '
echo '------------------------------------'
echo ' '
if [ -z "$PHP_VERSION" ]; then
    echo "The environment variable PHP_VERSION does not exist. Please set PHP_VERSION in your environment and restart the script"
    exit 1
elif [ "$PHP_VERSION" == "8.1" ]; then
    echo "PHP Version is set to 8.1"
else
    echo "PHP Version is set to $PHP_VERSION, but it needs to be 8.1 or higher"
    exit 1
fi

if [ -z "$TAILVEL_TARGET_DIRECTORY" ]; then
    echo "Please set TAILVEL_TARGET_DIRECTORY in your environment - this is where Tailvel will install your project to"
    exit 1
else
    echo "Target Directory: $TAILVEL_TARGET_DIRECTORY"
fi

if [ -z "$TAILVEL_ROOT_DIRECTORY" ]; then
    echo "Please set TAILVEL_ROOT_DIRECTORY in your environment - this is where Tailvel in installed and can draw from the configurations defined in the components folder"
    exit 1
else
    echo "Root Directory: $TAILVEL_ROOT_DIRECTORY"
fi

node --version &> /dev/null

# Check the exit status of the yarn command
if [ $? -ne 0 ]; then
    echo "Node is not installed. Please install it before proceeding."
    echo ' '
    echo '------------------------------------'
    exit 1
else
    echo "Node is installed"
    read -p "Will you be using 'yarn' on 'npm' in this project? " node_library
fi
echo ' '
echo '------------------------------------'
echo ' '

read -p "What do you want to name this Laravel Project? " project_name
echo ' '
echo '------------------------------------'
echo ' '
echo '------------------------------------'
echo ' '
echo 'Preparing Files...'
unzip $TAILVEL_ROOT_DIRECTORY/tailvel_resources.zip -d .
echo 'Ready!'
echo ' '
echo '------------------------------------'
echo ' '
echo ' '
echo '------------------------------------'
echo ' '
echo 'Starting with Laravel'
echo ' '
echo '------------------------------------'
echo ' '
cd $TAILVEL_TARGET_DIRECTORY

laravel -v &> /dev/null

# Check for laravel installer
if [ $? -ne 0 ]; then
    composer create-project laravel/laravel ${project_name}
else
    laravel new ${project_name}
fi


laravel new ${project_name}
cd ${project_name}
composer install
echo ' '
echo '------------------------------------'
echo ' '
echo 'Now installing Tailwind'
echo ' '
echo '------------------------------------'
echo ' '
if [ ${node_library} == "npm" ]; then
    npm install --save-dev tailwindcss postcss autoprefixer vue@next vue-loader@next
elif [ ${node_library} == "yarn" ]; then
    yarn add -D tailwindcss postcss autoprefixer vue@next vue-loader@next
fi

npx tailwindcss init -p
rm tailwind.config.js 
touch tailwind.config.js
chmod 755 tailwind.config.js
cat $TAILVEL_ROOT_DIRECTORY/components/tailwind.config.js >> tailwind.config.js
cat $TAILVEL_ROOT_DIRECTORY/components/app.css >> resources/css/app.css
sed -i '12 i @vite(["resources/css/app.css", "resources/js/app.js"])' resources/views/welcome.blade.php
sed -i '20 i <div id="app">' resources/views/welcome.blade.php
sed -i '140 i </div>' resources/views/welcome.blade.php
sed -i '42 i <welcome-component></welcome-component>' resources/views/welcome.blade.php
echo ' '
echo '------------------------------------'
echo ' '
echo 'Finishing off now with Vue JS'
echo ' '
echo '------------------------------------'
echo ' '
if [ ${node_library} == "npm" ]; then
    npm install @vitejs/plugin-vue
elif [ ${node_library} == "yarn" ]; then
    yarn add @vitejs/plugin-vue
fi
rm vite.config.js
touch vite.config.js
chmod 755 vite.config.js
cat $TAILVEL_ROOT_DIRECTORY/components/vite.config.js >> vite.config.js
rm resources/js/app.js
touch resources/js/app.js
chmod 755 resources/js/app.js
touch resources/js/vue.js
chmod 755 resources/js/vue.js
cat $TAILVEL_ROOT_DIRECTORY/components/app.js >> resources/js/app.js
cat $TAILVEL_ROOT_DIRECTORY/components/vue.js >> resources/js/vue.js
mkdir resources/js/components
touch resources/js/components/App.vue
cat $TAILVEL_ROOT_DIRECTORY/components/App.vue >> resources/js/components/App.vue
if [ ${node_library} == "npm" ]; then
    npm run build
elif [ ${node_library} == "yarn" ]; then
    yarn build
fi
echo '------------------------------------'
echo ' '
echo 'Cleaning up'
rm -rf $TAILVEL_ROOT_DIRECTORY/components
echo ' '
echo '------------------------------------'
echo ' '
echo '------------------------------------'
echo ' '
echo 'All good to go! Make something great'
echo ' '
echo '------------------------------------'
echo ' '
code .
