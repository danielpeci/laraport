container=laraport

download:
	docker cp $(container):/var/www/html/composer.json .
	docker cp $(container):/var/www/html/composer.lock .
	docker cp $(container):/var/www/html/vendor .
	docker cp $(container):/var/www/html/.env .

upload:
	docker cp .env.example $(container):/var/www/html/.env

composer:
	docker exec -it $(container) sh -c 'composer install'

laravel-setup:
	docker exec -it $(container) sh -c 'php artisan migrate'
	docker exec -it $(container) sh -c 'php artisan key:generate'

laraport:
	docker-compose up -d
	make composer
	make upload
	make download
	make laravel-setup
	@echo 'Setup Finished'
