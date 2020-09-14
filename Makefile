# Makefile for building and running the project.
# The purpose of this Makefile is to avoid developers having to remember
# project-specific commands for building, running, etc. Recipes longer
# than one or two lines should live in script files of their own in the
# bin/ directory.

PORT ?= 3001

all: check

setup:
	bin/setup

check: test

test:
	bundle exec rspec
	yarn test

run:
	foreman start -p $(PORT)

update:
	bundle update
	yarn upgrade

console:
	bin/rails c

.PHONY: setup all run test check
