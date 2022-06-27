# 👻 boo [![Build Status](https://github.com/caiangums/boo/workflows/CI/badge.svg)](https://github.com/caiangums/boo/actions)

```
ヘ(◕。◕ヘ)
   \    \
    '~~~~'
```

`boo` is an environment diagnoser to easily check what's missing and what's not.

![Boo Dog](./boo-dog.jpg)

<p align="center" style="font-style: italic;">Photo by <a href="https://unsplash.com/@karsten116?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Karsten Winegeart</a> on <a href="https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></p>

## Summary

- [Motivation](#motivation)
- [Use Cases](#use-cases)
- [Install](#install)
- [Usage](#usage)
- [Config File](#config-file)
- [Inpiration](#inpsiration)
- [Contributing](#contributing)
- [FAQ](#FAQ)

## Motivation

Configuring new machines from scratch eventually leads to missing tools, libs or dependencies. `boo` helps on diagnose, list and could provide guidance on how to fix it.

Also, when on starting new projects on totally new codebases or even when something got updated and the logs are not helping(maybe everything is broken?), `boo` can give a direction if something is missing.

## Use Cases

Here are some use cases for `boo`:

- Diagnose your local environment on missing dependencies
- Diagnose created containers for missing dependencies without pain
- Diagnose new configured machines for eventually missing dependencies

## Install

Installation can be done [automated](#automated) or [manually](#manual).

#### Automated

```sh
curl -Ls https://raw.githubusercontent.com/caiangums/boo/latest-release/install.sh | sudo bash
```

#### Manual

Steps are:
- Download it and extract it somewhere (generally `/usr/local`)
- Create the `.boo_dir` at your `$HOME` directory with the path to `boo` installation
- Create the symlink to the `/usr/local/bin` or make it available at your `$PATH`

```sh
curl https://raw.githubusercontent.com/caiangums/boo/latest-release/boo > /usr/local/bin/boo
echo "/usr/local/boo" > $HOME/.boo_dir
ln -s /usr/local/boo/boo /usr/local/bin/boo
```

## Usage

Once installed, just run `boo` and check for available commands. But remember: `boo` doesn't work alone. It needs to know what to search and relies on a provided [config file](#config-file) written in `yaml`. Examples can be found inside the `config_examples/` directory.

`boo` commands are:

- [`d`|`diagnose`](#ddiagnose)
- [`l`|`list`](#llist)
- [`h`|`help`](#hhelp)
- [`v`|`version`](#vversion)

#### `d`|`diagnose`

```sh
boo (d|diagnose) <config-file>
```

Based on the provided config file, diagnose the environment for present (installed) and not present (missing) tools. More information could be provided if defined at the `<config-file>` such as install command or a message.

**Under development**: If the command for checking the tool version and the desired version also provide information about matching versions from installed libs.

Note: It also provides information about the config file malformed yaml tags or missing essential tags on each tool.

#### `l`|`list`

```sh
boo (l|list) <config-file>
```

Based on the provided config file, list the environment for not present (missing) tools.

Note: It also provides information about the config file malformed yaml tags or missing essential tags on each tool.

#### `h`|`help`

```sh
boo (h|help)
```

Present information about the usage of `boo`.

#### `v`|`version`

```sh
boo (v|version)
```

Present information about actual `boo` version.

## Config File

The Config File should be written in Yaml with some specific tags. Examples can be found at `config_examples/` directory. The file should respect this pattern and have those tags:

```yaml
tool:
  tag: "tool"
  name: "Tool Name"
  command:
    check: "tool"
  validate: true
  message:
    not_validating: "Message for not validating tool"
    not_present: "Message for missing tool"
```

- `tool`: **(required)** The tag for that tool. Should match the `tag` inner value
- `tag`: **(required)** Should match the `tool` and will be used to identify that tool
- `name`: **(required)** Any given name that will be shown related to that tool
- `command`: **(required)** All commands will be placed inside here
    - `check`: **(required)** Command to run a tool via terminal
- `validate`: Flag responsible for not checking that specific tool a `message` could be provided with more information. (default: `true`)
- `message`: All messages will be places inside here
    - `not_validating`: In case of the tool not being validated, this message is shown together with the respective tool
    - `not_present`: In case of missing tool, this message is shown together with the respective tool

Note: In case of `validate: false` the tags `name`, `command` and `check` will not be used and can be empty.

## Inspiration

`boo` was inspired by [`notes`](https://github.com/pimterry/notes). If you like `boo`, you probably will like `notes`. Give it a star!

## Contributing

1. Fork it
2. Develop your idea. If you need some help, ask for it! :)
3. Create some tests
4. Open a PR

And wait for a review.

## FAQ

### What about dotfiles or install scripts?

Those are solutions for when you know what you need to install. Eventually, things change and `boo` can help you on how to keep that in sync.

### Does `boo` replaces X/Y/Z?

Probably not. `boo` is just the diagnoser and not the solver. Once the issue is identified, it can be fix'd and that could be a whole different job.

### How can I help and improve `boo`?

PRs are welcomed. Issues tab are a good spot to start.
