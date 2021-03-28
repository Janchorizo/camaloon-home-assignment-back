#!/bin/bash
# Run config.sh <environment> to create the database.yml configuration file
# for the RUBY_ENV that will be used when serving or running commands.
#
# Due to 'design decisions' rake will apply migrations and any other
# db operation toall environments defined in the database.yml.
# This makes it connect to test and production databases when performing
# migrations in development environments (set wit RAILS_ENV).
# To prevent side-effects and extra costs of performing these actions
# unintentionally, only the required environment configuration is made
# available.
#
# https://github.com/rails/rails/issues/40948
# https://github.com/rails/rails/pull/37351
# https://github.com/rails/rails/issues/32926
# https://github.com/rails/rails/issues/28827

RAILS_env=$1
echo "Using $1 environment"

case $env in
  "default")
    echo
    echo "⮩ Setting config/database.yml to use default settings . . ."
    echo '  echo "RAILS_ENV=default" > envfile'
    echo "RAILS_ENV=default" > envfile
    echo "  cp ./config/database_base.yml ./config/database.yml"
    cp ./config/database_base.yml ./config/database.yml
    echo "⮪ Finished"
    echo
    ;;
  "development")
    echo
    echo "⮩ Setting config/database.yml to use the merged development and default settings . . ."
    echo '  echo "RAILS_ENV=development" > envfile'
    echo "RAILS_ENV=development" > envfile
    echo "  cp ./config/database_dev.yml ./config/database.yml"
    cp ./config/database_base.yml ./config/database.yml
    echo "  cat ./config/database_dev.yml >> ./config/database.yml"
    cat ./config/database_dev.yml >> ./config/database.yml
    echo "⮪ Finished"
    echo
    ;;
  "test")
    echo
    echo "⮩ Setting config/database.yml to use the merged development and default settings . . ."
    echo '  echo "RAILS_ENV=test" > envfile'
    echo "RAILS_ENV=test" > envfile
    echo "  cp ./config/database_base.yml ./config/database.yml"
    cp ./config/database_base.yml ./config/database.yml
    echo "  cat ./config/database_test.yml >> ./config/database.yml"
    cat ./config/database_test.yml >> ./config/database.yml
    echo "⮪ Finished"
    echo
  ;;
  "production")
    echo
    echo "⮩ Setting config/database.yml to use the merged development and default settings . . ."
    echo '  echo "RAILS_ENV=production" > envfile'
    echo "RAILS_ENV=production" > envfile
    echo "  cp ./config/database_base.yml ./config/database.yml"
    cp ./config/database_base.yml ./config/database.yml
    echo "  cat ./config/database_prod.yml >> ./config/database.yml"
    cat ./config/database_prod.yml >> ./config/database.yml
    echo "⮪ Finished"
    echo
  ;;
  *)
    echo "RAILS_ENV must be one of [default,development,test,production].\n"
  ;;
esac
