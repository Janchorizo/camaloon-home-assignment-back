DB_HOST="localhost"
DB_USER="local_user"
DB_PASSWORD="local_user"
DB_NAME="camaloon_local"

test:
	DB_URL="postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST)/$(DB_NAME)" \
		bundle exec rspec

serve:
	rails s

install:
	bundler install

$PHONY: test serve install
