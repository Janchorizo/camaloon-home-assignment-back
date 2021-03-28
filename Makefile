#!make
-include envfile
export

DB_HOST="localhost"
DB_USER="local_user"
DB_PASSWORD="local_user"
DB_NAME="camaloon_local"
RAILS_ENV?=""
TEST_ENV?="test"

configure:
	bash ./config.sh $(RAILS_ENV)

env:
ifneq ($(RAILS_ENV),'')
	@echo "$(RAILS_ENV)\n"
else
	@echo "The environment is not set.\nCall make configure -e RAILS_ENV=<env>"
	@echo "\nThe database config file and enfile will be generated. The specified"
	@echo "environment will be used unless tests are run, in which case the test"
	@echo "rails environment will be used.\n"
endif

env_is_present:
ifeq ($(RAILS_ENV),'')
	@echo "The environment is not set.\nCall make configure -e RAILS_ENV=<env>"
	@echo "\nThe database config file and enfile will be generated. The specified"
	@echo "environment will be used unless tests are run, in which case the test"
	@echo "rails environment will be used.\n"
	exit 1
endif

test:
	#DB_URL="postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST)/$(DB_NAME)"
	RAILS_ENV=$(TEST_ENV) bundle exec rspec

serve: env_is_present
	RAILS_ENV=$(RAILS_ENV) rails server -e $(RAILS_ENV)

dbconsole: env_is_present
	RAILS_ENV=$(RAILS_ENV) rails dbconsole

db_drop: env_is_present
	RAILS_ENV=$(RAILS_ENV) rails db:drop

db_create: env_is_present
	RAILS_ENV=$(RAILS_ENV) rails db:create

db_migrate: env_is_present
	RAILS_ENV=$(RAILS_ENV) rails db:migrate

db_recreate: env_is_present db_drop db_create
	RAILS_ENV=$(RAILS_ENV) rails db:schema:load

db_seed: env_is_present
	RAILS_ENV=$(RAILS_ENV) rails db:seed

install:
	RAILS_ENV=$(RAILS_ENV) bundle install

$PHONY: configure env env_is_present test serve install dbconsole db_drop db_create db_migrate db_migrate db_recreate db_seed
