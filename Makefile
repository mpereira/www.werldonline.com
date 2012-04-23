GIT := git
CP := cp -afr

PROJECT_NAME := www.werldonline.com
PROJECT_GIT_REPOSITORY_URL := git@github.com:mpereira/www.werldonline.com.git

WERLD_CLIENT_BROWSER_PATH := vendor/werld-client-browser
WERLD_CLIENT_BROWSER_ASSETS_PATH := $(WERLD_CLIENT_BROWSER_PATH)/assets/
WERLD_CLIENT_BROWSER_BUILD_PATH := $(WERLD_CLIENT_BROWSER_PATH)/build/
WERLD_CLIENT_BROWSER_ASSETS_FILES_AND_DIRECTORIES := images \
                                                     sounds \
                                                     webfonts \
                                                     favicon.ico
WERLD_CLIENT_BROWSER_BUILD_FILES_AND_DIRECTORIES := index.html \
                                                    javascripts \
                                                    stylesheets
WERLD_CLIENT_BROWSER_ASSETS_FILES_AND_DIRECTORIES_PATHS := \
  $(addprefix $(WERLD_CLIENT_BROWSER_ASSETS_PATH), $(WERLD_CLIENT_BROWSER_ASSETS_FILES_AND_DIRECTORIES))
WERLD_CLIENT_BROWSER_BUILD_FILES_AND_DIRECTORIES_PATHS := \
  $(addprefix $(WERLD_CLIENT_BROWSER_BUILD_PATH), $(WERLD_CLIENT_BROWSER_BUILD_FILES_AND_DIRECTORIES))

pull_git_modules:
	$(GIT) submodule foreach $(GIT) pull origin master

build_werld_client_browser:
	@NODE_ENV=production make -C $(WERLD_CLIENT_BROWSER_PATH) build

build:
	$(CP) $(WERLD_CLIENT_BROWSER_ASSETS_FILES_AND_DIRECTORIES_PATHS) $(WERLD_CLIENT_BROWSER_BUILD_FILES_AND_DIRECTORIES_PATHS) .

deploy: pull_git_modules build_werld_client_browser build
	-@git add $(WERLD_CLIENT_BROWSER_ASSETS_FILES_AND_DIRECTORIES) $(WERLD_CLIENT_BROWSER_BUILD_FILES_AND_DIRECTORIES) && git commit -m "Update."
	@git push origin gh-pages
