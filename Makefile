EXTENSION :=sh
DEPS := shellcheck bats
LINT_OPTS += "--shell=bash"
LINT_OPTS += "--exclude=SC2207"

SOURCE_FILES := $(shell find */* -type f -name '*$(EXTENSION)')
EXERCISES := $(shell find */* -type f -name '*$(EXTENSION)' | cut -d/ -f1 | uniq)
LINT_TARGETS := $(addprefix lint-,$(EXERCISES))
OUT_DIR=.build
OBJECTS=$(addprefix $(OUT_DIR)/,$(EXERCISES))
LINT_OBJECTS=$(addprefix $(OUT_DIR)/,$(LINT_TARGETS))
MIGRATE_OBJECTS := $(addsuffix /.exercism/metadata.json, $(EXERCISES))

.PHONY: all init no-skip clean lint test check-migrate
all: lint test
pre-push pre-commit: no-skip check-migrate lint test

init:
	sudo apt-get install -y $(DEPS)

clean:
	rm -rf $(OUT_DIR)
no-skip:
	@ ! grep -rE '^\s+skip' .

lint: $(LINT_TARGETS)
test: $(EXERCISES)

check-migrate: $(MIGRATE_OBJECTS)

$(MIGRATE_OBJECTS):
	@ [ -f $@ ] || $(error "$(shell echo $@ | cut -d/ -f1) has not been migrated")

$(LINT_TARGETS) $(EXERCISES): %: $(OUT_DIR)/%

$(OUT_DIR):
	@ mkdir -p $@

.SECONDEXPANSION:

GET_DEP = $(filter $(patsubst $(OUT_DIR)/%,%,$@)%,$(SOURCE_FILES))
$(OBJECTS): $$(GET_DEP) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/%,%,$@))
	@ echo "Testing $(EXERCISE)..."
	@ cd $(EXERCISE) && bats $(OPTS) *_test.sh
	@ touch $@

GET_DEP_LINT = $(filter $(patsubst $(OUT_DIR)/lint-%,%,$@)%,$(SOURCE_FILES))
$(LINT_OBJECTS): $$(GET_DEP_LINT) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/lint-%,%,$@))
	@ echo "Linting $(EXERCISE)..."
	@ ls $(EXERCISE)/*.$(EXTENSION) | xargs -n1 | grep -v _test | xargs shellcheck $(LINT_OPTS)
	@ touch $@
