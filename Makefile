TEMP_DIR := $(shell mktemp -d)
build:
	xcodebuild  -configuration Release SYMROOT=$(TEMP_DIR) build
	cp -f $(TEMP_DIR)/Release/Tasks /usr/local/bin/tasks
	rm -r $(TEMP_DIR)