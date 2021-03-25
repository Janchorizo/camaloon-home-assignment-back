DB_HOST="localhost"
DB_USER="local_user"
DB_PASSWORD="local_user"
DB_NAME="camaloon_local"
RAILS_ENV="default"

configure:
	echo $(RAILS_ENV)
	bash ./config.sh $(RAILS_ENV)

test:
	DB_URL="postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST)/$(DB_NAME)" \
		bundle exec rspec

serve:
	rails s

install:
	bundler install

$PHONY: test serve install configure
