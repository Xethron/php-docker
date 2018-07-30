# Simple PHP web server setup

This assumes all your websites are in ~/Projects/sites and will store your DB in ~/Docker/mariadb

Place a `*.nginx.conf` in the root directory of each of your projects with a unique name.
This will automatically include it in the enabled sites before nginx starts up.
