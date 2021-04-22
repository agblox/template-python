# replace-me
## Table of contents
* [About](#about)
* [Prerequisites](#prerequisites)
* [Install](#install)
* [Usage](#usage)
* [Build](#build)
* [Deploy](#deploy)
* [Test](#test)
* [Contribute](#contribute)
### About
Base Python repo template.
### Prerequisites
Tools to install: [git][g], [pre-commit][pk], [poetry][p]

You can use [this][a] playbook for automated tools installation(Ubuntu only).
### Install
![create](docs/template_btn.png)

[Create][1] a new repo from this template.

### Usage
1. Clone your repo.
1. Find all `replace-me` or `replace_me` strings in repo files or files/dirs names and replace it with actual data.
1. Add your repo to tara.ai workspace. Instruction [here][2].
1. Initialize environment: `make repo-init bootstrap`.
1. Clean `About`, `Install` and `Usage` sections of this file :) and follow our [requirements][3] to complete setup. If you are not familiar with `poerty` - read this [manual][7]. If you have a questions about secrets check hook - read [this][8] section from our `Secrets` Wiki document.
### Build
### Deploy
### Test
- Test suit: `make tests`
- Type hints: `make test-mypy`
### Contribute

[g]: https://www.atlassian.com/git/tutorials/install-git
[pk]: https://pre-commit.com/#install
[p]: https://python-poetry.org/docs/#installation
[a]: https://github.com/IaroslavR/ansible-role-server-bootstrap

[1]: https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template
[2]: https://docs.google.com/document/d/128c8Up40PFeZg2LaUkChC3hNv1139-VruFm_SC-ZJiU/edit#heading=h.jutu1mazqqgt
[3]: https://github.com/agblox/DiviAI-Information/wiki/Repos
[7]: https://python-poetry.org/docs/basic-usage
[8]: https://github.com/agblox/DiviAI-Information/wiki/Secrets#pre-commit-hook
