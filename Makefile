CONTENT_DIR	:= content
ORG_DIR		:= org
POST_DIR	:= post
OUTPUT_POST_DIR := $(CONTENT_DIR)/$(POST_DIR)
ORG_POST_DIR	:= $(ORG_DIR)/$(POST_DIR)


$(OUTPUT_POST_DIR)/%.md: $(ORG_POST_DIR)/%.org
	pandoc -f org -t markdown_github -o $@ $<


posts: $(shell find $(ORG_POST_DIR) -name '*.org' | sed s:org/:content/: | sed s/.org/.md/)
	hugo
