.PHONY: lint test
all: lint test-all

lint:
	@ls ./*/*.sh | xargs -n1 | grep -v _test | xargs shellcheck

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
