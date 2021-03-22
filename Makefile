DB_HOST="localhost"
DB_USER="local_user"
DB_PASSWORD="local_user"
DB_NAME="camaloon_local"

test:
	DB_HOST=$(DB_HOST) \
	DB_USER=$(DB_USER) \
	DB_PASSWORD=$(DB_PASSWORD) \
	DB_NAME=$(DB_NAME) \
		bundle exec rspec

serve:
	rails s

$PHONY: test serve
