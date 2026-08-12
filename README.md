# Unofficial JetBrains PPA
[![Build](https://github.com/JonasGroeger/jetbrains-ppa/actions/workflows/build.yml/badge.svg)](https://github.com/JonasGroeger/jetbrains-ppa/actions/workflows/build.yml)

This is the unofficial JetBrains PPA which you can use to get the latest and greatest products from JetBrains.

If you don't care about having a single place to update all your packages (via `apt`), you can also
use the [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/).
Its maintained by JetBrains, covers all JetBrains products, and offers some nice functionality on top.

This PPA contains the following packages:

* CLion `clion`
* DataGrip `datagrip`
* DataSpell `dataspell`
* dotCover Command Line Tools `dotcover-clt`
* GoLand `goland`
* IntelliJ IDEA (unified) `intellij-idea`
* JetBrains Gateway `jetbrains-gateway`
* PhpStorm `phpstorm`
* PyCharm (unified) `pycharm`
* Rider `rider`
* RubyMine `rubymine`
* RustRover `rustrover`
* WebStorm `webstorm`

All packages are automatically updated using [GitHub Actions](https://github.com/JonasGroeger/jetbrains-ppa/actions).

## Installation

To use it, enter the commands below, one by one. They download the correct GPG Key and add this repositories sources to your system sources.

```shell
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list >/dev/null

sudo apt-get update
```

Alternatively, if you want to use the new [Deb822](https://repolib.readthedocs.io/en/latest/deb822-format.html) format, use the following.
Note that you cannot have both active (old debian + Deb822 style).

```shell
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null

cat <<EOF | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.sources >/dev/null
Types: deb
URIs: http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com
Suites: any
Components: main
Signed-By: /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg
EOF

sudo apt-get update
```

Then, to install IntelliJ IDEA for example, you can now run

```shell
sudo apt-get install intellij-idea
```

## I'm not getting any updates

Check your apt policy. It should say `any/main` after the URL. If it does not (like below), please redo the installation instructions.

```shell-session
$ apt show pycharm | grep "APT-Sources"
APT-Sources: http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com bionic/main amd64 Packages
```

## I want another package

If you want a package for another JetBrains product please [create a GitHub issue](https://github.com/JonasGroeger/jetbrains-ppa/issues/new).
Ideally, also provide a Pull Request.

## Why not use the [official snap packages](https://snapcraft.io/search?q=jetbrains)?

Sure! If you like snap packages, go ahead.
However, not all packages contained in this repository are already available as snap packages.
And maybe you don't like snaps? :)

## Building the packages

You will need `fpm` (based on ruby) and `jq` installed:

    sudo apt install jq ruby ruby-dev rubygems build-essential
    sudo gem install fpm

To build a package, run the `build` script with a package folder:

    ./build-single-deb packages/<package>

To build the `intellij-idea` package for example use:

    ./build-single-deb packages/intellij-idea

## Why this was written

I hate manually downloading, extracting and moving the `*.tar.gz` from the
JetBrains website to get an IDE update. Unfortunately JetBrains does not have a
Debian repository.

## Maintainers note

```shell
# Create the build container
docker buildx build -f docker/Dockerfile -t jetbrains-ppa-builder:latest .

# Use the build container
docker run -it --env-file .env -v "$(pwd):/app" jetbrains-ppa-builder:latest

# Test GH action
act --secret-file .env schedule
```

---

Maintained by Jonas Gröger. Automatically updated by [GitHub Actions](https://github.com/JonasGroeger/jetbrains-ppa/actions).
