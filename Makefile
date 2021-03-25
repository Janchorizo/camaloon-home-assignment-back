DB_HOST="localhost"
DB_USER="local_user"
DB_PASSWORD="local_user"
DB_NAME="camaloon_local"
RAILS_ENV="default"

configure:
	bash ./config.sh $(RAILS_ENV)

test:
	DB_URL="postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST)/$(DB_NAME)" \
		RAILS_ENV=$(RAILS_ENV) bundle exec rspec

serve:
	RAILS_ENV=$(RAILS_ENV) rails s

install:
	RAILS_ENV=$(RAILS_ENV) bundle install

$PHONY: test serve install configure
