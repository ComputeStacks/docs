# Automating Image Deployment

**OVERVIEW**

This guide will walk you through different strategies for automating the deployment of your custom docker images to a ComputeStacks instance.

---

## Using a Makefile

This makefile uses an environmental variable to store your ComputeStacks API credentials. If you will be running this from your local computer, *I recommend using a tool such as [direnv](https://direnv.net) to manage your environmental variables.*

### ComputeStacks Authentication

Generate your API credentials from within the ComputeStacks interface and make them available to your local shell.

1. Using `direnv`

```bash
cd ~/my-project && echo 'export COMPUTESTACKS_AUTH_KEY="MY-CS-API-KEY:MY-CS-API-SEDCRET"' >> ~/.envrc
direnv allow .
```

1. Without any tool

```bash
export COMPUTESTACKS_AUTH_KEY="MY-CS-API-KEY:MY-CS-API-SEDCRET"
```

### Create your Makefile

Replace [`https://my.computestacks.com/api/container_services/100/power/rebuild`](https://my.computestacks.com/api/container_services/100/power/rebuild) with the URL of your ComputeStacks installation, and `100` with the ID of your container service. You can easily find this by navigating to the service overview page (Projects → My Project → My Service) and looking in the URL.

```makefile
.PHONY: build help run push

help: ## Help
  @awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build Image
  @docker build --progress plain -t my.registry.server/myimage:imagetag .

push: ## Deploy newly crated image
  @docker push my.registry.server/myimage:imagetag

deploy: ## Trigger rebuild of site
  @curl -X PUT -u "$(COMPUTESTACKS_AUTH_KEY)" -H "Content-Type: application/json" -H "Accept: application/json" https://my.computestacks.com/api/container_services/100/power/rebuild
```

Now, your process to build and deploy your image will be as simple as:

```bash
make build
make push
make deploy
```

---

## Using Gitlab Actions

In this example, we will use Gitlab CI to build an deploy our docker containers. 

!!! warning
    Before proceeding: If you’re using the self-hosted version of Gitlab, be sure you already have Gitlab CI runners installed and working before proceeding. [Learn More](https://docs.gitlab.com/runner/install/)

### Setup your Gitlab Project

If you have not done so already, create a new project in gitlab and clone the repo to your local computer. In that repo, setup your `Dockerfile`. Commit the file and push them to your project.

Navigate to ***Settings → CI/CD → Variables*** and create the following variables (enter the appropriate values based on your configuration):

| Variable | Description |
| --- | --- |
| `CS_AUTH_KEY` | This is your CS `API KEY` and `API SECRET` in the format: `KEY:SECRET` |
| `CS_CONTROLLER` | The hostname of your CS controller. Example: `controller.example.net` |
| `CS_SERVICE_ID` | The ID of your container service. |

### Create your Gitlab CI file

In your local repo, create a file named `.gitlab-ci.yml` — in that file, place the following contents:

```yaml
stages:
  - build
  - deploy

build-image:
  stage: build
  tags:
    - shell 
  variables:
    IMAGE_TAG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker build --progress plain -t $IMAGE_TAG .
    - docker push $IMAGE_TAG
    - docker logout $CI_REGISTRY
  only:
    - main

deploy-image:
  stage: deploy
  variables: {}
  tags:
    - shell
  script:
    - 'curl -X PUT -u "${CS_AUTH_KEY}" -H "Content-Type: application/json" -H "Accept: application/json" https://${CS_CONTROLLER}/api/container_services/${CS_SERVICE_ID}/power/rebuild'
  only:
    - main
```

Commit that file and push it to Gitlab.

### Running your Gitlab CI Pipeline

You can now manually trigger your pipeline to run by navigating to ***CI/CI → Pipelines***.

If you would like to automate when this ones, or build more advanced functionality, please see [Gitlab’s documentation for more info](https://docs.gitlab.com/ee/ci/).
