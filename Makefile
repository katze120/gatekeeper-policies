# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make will use bash instead of sh
SHELL := /usr/bin/env bash

# The .PHONY directive tells make that this isn't a real target and so
# the presence of a file with that name won't cause this target to stop
.PHONY: test
test: ## Test constraint templates via OPA
	@echo "Running OPA tests..."
	@opa test -v library/* --explain=notes

.PHONY: build_templates
build_templates: ## Inline Rego rules into constraint templates
	@python3 scripts/inline_rego.py

.PHONY: format
format: ## Format Rego rules
	@opa fmt -w library

.PHONY: build
build: format build_templates ## Format and build

.PHONY: check_format
check_format: ## Check that files have been formatted using opa fmt
	@test $$(opa fmt -l library/ | wc -l) -eq '0'

help: ## Prints help for targets with comments
	@grep -E '^[a-zA-Z._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "make \033[36m%- 30s\033[0m %s\n", $$1, $$2}'