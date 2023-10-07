# Tailvel
## Making The Laravel Vue Stack easy

This script will download and setup a Laravel project with Tailwind and Vue 3 ready to go.  Once the project is loaded, you can jump straight into Dev work without the hassle of setting things up.

### Requirements
- PHP 8.1
- Node 19
- Yarn package installer
- (Optional) The 'code' snippet for VS Code

### Setup
- On line 2, of the script, define your desired project parent directory.
- A good step is to run place this script in your path or bin root with a symlink so it can be run from anywhere
- Run 'tailvel.sh' in any UNIX based terminal and you're good to go.

#### Changelog
##### Version 0.0.1
- Added the ability to automatically install Tailwind and Vue 3 to Laravel 10

##### Future Plans
- The ability to run the laravel create command with laravel packages such as '--breeze'
- A more userfriendly check that looks to see if you are running this for the first time and will do a configuration run for you. 
