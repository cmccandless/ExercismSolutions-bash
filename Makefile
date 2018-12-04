.PHONY: lint test
all: lint test-all

lint:
	@echo "No linter configured"

test:
	@ $(foreach FILE,$(FILES), \
		$(call dotest,$(FILE)) \
	)

test-all:
	@ $(foreach FILE,$(shell ls -d */), \
		$(call dotest, $(FILE)) \
	)

define dotest
	cd $(1); \
	bats $(OPTS) *_test.sh || exit 1; \
	cd ..;
endef
