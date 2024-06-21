TEMP_DIR := $(shell mktemp -d)
build:
	xcodebuild  -configuration Release SYMROOT=$(TEMP_DIR) build
	cp -f $(TEMP_DIR)/Release/AnsiTerminalTest /usr/local/bin/att
	rm -r $(TEMP_DIR)