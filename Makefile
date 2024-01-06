bundler-config:
	bundle config set deployment 'true'
	bundle config set without 'development test cli'

copy-source: bundler-config
	cp -r . $(ARTIFACTS_DIR)
	rm -rf $(ARTIFACTS_DIR)/.git
	rm -rf $(ARTIFACTS_DIR)/.github
	rm -rf $(ARTIFACTS_DIR)/.gitignore
	rm -rf $(ARTIFACTS_DIR)/.env*
	rm -rf $(ARTIFACTS_DIR)/spec
	rm -rf $(ARTIFACTS_DIR)/log/*
	cd $(ARTIFACTS_DIR) && bundle config set path /opt

build: bundler-config
	bundle config set path $(ARTIFACTS_DIR)
	bundle config set no-cache 'true'
	bundle install
	find $(ARTIFACTS_DIR) -type f -name '*.c' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.h' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.o' -delete
	find $(ARTIFACTS_DIR) -type f -name '*.gem' -delete

build-GemLayer: build
build-StellarApi: copy-source
build-StellarDailyJob: copy-source
