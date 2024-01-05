
build:
	cp -r . $(ARTIFACTS_DIR)
	rm -rf $(ARTIFACTS_DIR)/.git
	rm -rf $(ARTIFACTS_DIR)/.github
	rm -rf $(ARTIFACTS_DIR)/.gitignore
	cd $(ARTIFACTS_DIR) && bundle install --deployment --without 'development test cli'

build-StellarApi: build
build-StellarDailyJob: build
