.PHONY: all
all: help

# ------------------------------------------------------------------------------------------------------------------------------------------------
# for test
# ------------------------------------------------------------------------------------------------------------------------------------------------
# ===================================================================================================
# db
.PHONY: resetup_testdb
resetup_testdb: ## drop and setup test db
	@cd biz && docker-compose run --rm biz bash -c 'rails db:environment:set RAILS_ENV=test && RAILS_ENV=test rake db:drop && RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:migrate' && cd -

.PHONY: setup_testdb
setup_testdb: ## setup test db
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test rake db:create && RAILS_ENV=test rake db:migrate' && cd -

# ===================================================================================================
# schoo
.PHONY: test_biz_api_curriculum_category_list
test_biz_api_curriculum_category_list: ## test api 'biz_api/curriculum/category_list'
	@curl --location --header 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' --request GET 'http://localhost:8080/biz_api/curriculum/category_list?format=json' | jq .

# rspec
.PHONY: test_all
test_all: ## run all test
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/' && cd -

.PHONY: test_features
test_features: ## run features test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/features/corporation_staffs_new_spec.rb' && cd -

.PHONY: test_services
test_services: ## run services test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/services/schoo/premium_service_spec.rb' && cd -

.PHONY: test_templates
test_templates: ## run templates test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/templates/' && cd -

.PHONY: test_models
test_models: ## run models test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/models/' && cd -

.PHONY: test_lib
test_lib: ## run lib test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/lib/' && cd -

.PHONY: test_tests
test_tests: ## run tests test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/tests/' && cd -

.PHONY: test_requests
test_requests: ## run requests test on rails
	@cd biz && docker-compose run --rm biz bash -c 'bundle && RAILS_ENV=test bundle exec rake db:fixtures:load FIXTURES_PATH=spec/fixtures && RAILS_ENV=test bundle exec rspec ./spec/requests/' && cd -

# ------------------------------------------------------------------------------------------------------------------------------------------------
# build container
# ------------------------------------------------------------------------------------------------------------------------------------------------
.PHONY: ps
ps: ## display all container
	@docker ps -a

.PHONY: build
build: ## build all container
	@cd db && docker-compose build && cd -
	@cd cache && docker-compose build && cd -
	@cd schoo && docker-compose build && cd -
	@cd biz && docker-compose build && cd -
	@docker images

.PHONY: stop
stop: ## stop all container
	@cd db && docker-compose down && cd -
	@cd cache && docker-compose down && cd -
	@cd schoo && docker-compose down && cd -
	@cd biz && docker-compose down && cd -
	@docker ps -a

.PHONY: start
start: ## start all container
	@cd db && docker-compose up -d && cd -
	@cd cache && docker-compose up -d && cd -
	@cd schoo && docker-compose up -d && cd -
	@cd biz && docker-compose up -d && cd -
	@docker ps -a

.PHONY: restart
restart: ## restart all container
	@cd db && docker-compose down && docker-compose up -d && cd -
	@cd cache && docker-compose down && docker-compose up -d && cd -
	@cd schoo && docker-compose down && docker-compose up -d && cd -
	@cd biz && docker-compose down && docker-compose up -d && cd -
	@docker ps -a

.PHONY: create_docker_network
create_docker_network: ## create docker network for schoo
	@docker network create --driver bridge schoo_link

# ------------------------------------------------------------------------------------------------------------------------------------------------
# for container
# ------------------------------------------------------------------------------------------------------------------------------------------------
# ===================================================================================================
# db
.PHONY: db_and_cache_start
db_and_cache_start: ## start db and cache
	@cd cache && docker-compose build && docker-compose down && docker-compose up -d && cd -
	@cd db && docker-compose build && docker-compose down && docker-compose up -d && cd -
	@docker ps -a

.PHONY: connect_dev_db
connect_dev_db: ## connect schooo_campus db for develop
	@cd db && docker-compose run --rm db sh -c 'mysql -u root -h 127.0.0.1 -P 3306 schoo_campus' && cd -

# ===================================================================================================
# biz
.PHONY: rubocop
rubocop: ## exec rubocop
	@cd biz && docker-compose run --rm biz bash -c 'bundle && bundle exec rubocop' && cd -

.PHONY: bundle
bundle: ## bundle
	@cd biz && docker-compose run --rm biz bash -c 'bundle' && cd -

.PHONY: routes
routes: ## get routes
	@cd biz && docker-compose run --rm biz bash -c 'bundle && rails routes' && cd -


# ===================================================================================================
# biz
.PHONY: biz_build
biz_build: ## build biz container
	@cd biz && docker-compose build && cd -

.PHONY: biz_start
biz_start: ## start biz container
	@cd biz && docker-compose up -d && cd -

.PHONY: biz_stop
biz_stop: ## stop biz container
	@cd biz && docker-compose down && cd -

.PHONY: biz_restart
biz_restart: biz_stop biz_start ## restart biz container

.PHONY: biz_dev_logs
biz_dev_logs: ## display biz logs for dev
	@docker logs -f biz

.PHONY: biz_test_logs
biz_test_logs: ## display biz logs for test
	@tail -f -n 2000 ./biz/src/log/test.log

# ===================================================================================================
# schoo
.PHONY: schoo_build
schoo_build: ## build schoo container
	@cd schoo && docker-compose build && cd -

.PHONY: schoo_start
schoo_start: ## start schoo container
	@cd schoo && docker-compose up -d && cd -

.PHONY: schoo_stop
schoo_stop: ## stop schoo container
	@cd schoo && docker-compose down && cd -

.PHONY: schoo_restart ## restart schoo container
schoo_restart: schoo_stop schoo_start ## schoo_restart

# ------------------------------------------------------------------------------------------------------------------------------------------------
# aws
# ------------------------------------------------------------------------------------------------------------------------------------------------
.PHONY: awslogin
awslogin: ## login to aws
	@aws ecr get-login-password | docker login --username AWS --password-stdin https://504200935189.dkr.ecr.ap-northeast-1.amazonaws.com

# ===================================================================================================
# schoo
.PHONY: aws_relation_tag_and_schoo_local_image
aws_relation_tag_and_schoo_local_image: ## docker tag local-schoo_schoo_web:latest 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-schoo:for-local-dev
	@docker tag local-development-container_schoo:latest 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-schoo:for-local-dev

.PHONY: aws_rmi_tag_for_schoo_local_image
aws_rmi_tag_for_schoo_local_image: ## docker rmi "504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-schoo:for-local-dev"
	@docker rmi "504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-schoo:for-local-dev"

.PHONY: aws_push_schoo_image_to_ecr
aws_push_schoo_image_to_ecr: ## docker push 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-schoo:for-local-dev
	@docker push 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-schoo:for-local-dev

# ===================================================================================================
# biz
.PHONY: aws_relation_tag_and_biz_local_image
aws_relation_tag_and_biz_local_image: ## docker tag local-development-container_biz:latest 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-biz:for-local-dev
	@docker tag local-development-container_biz:latest 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-biz:for-local-dev

.PHONY: aws_push_biz_image_to_ecr
aws_push_biz_image_to_ecr: ## docker push 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-biz:for-local-dev
	@docker push 504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-biz:for-local-dev

.PHONY: aws_rmi_tag_for_biz_local_image
aws_rmi_tag_for_biz_local_image: ## docker rmi "504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-biz:for-local-dev"
	@docker rmi "504200935189.dkr.ecr.ap-northeast-1.amazonaws.com/schoo-dev-biz:for-local-dev"

# ------------------------------------------------------------------------------------------------------------------------------------------------
# other
# ------------------------------------------------------------------------------------------------------------------------------------------------
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

