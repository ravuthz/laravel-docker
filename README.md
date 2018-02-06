docker build -t laravel-app .

docker run -p 80:80 laravel-app

docker run -p 80:80 -e DB_HOST=dbhost.com laravel-app