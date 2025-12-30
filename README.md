# Unofficial JetBrains PPA
[![Build](https://github.com/JonasGroeger/jetbrains-ppa/actions/workflows/build.yml/badge.svg)](https://github.com/JonasGroeger/jetbrains-ppa/actions/workflows/build.yml)

This is the unofficial JetBrains PPA which you can use to get the latest and greatest products from JetBrains.

Currently, the following packages are supported and automatically updated using [GitHub Actions](https://github.com/JonasGroeger/jetbrains-ppa/actions).

* CLion `clion`
* DataGrip `datagrip`
* DataSpell `dataspell`
* Fleet (Public Preview) `fleet-preview`
* GoLand `goland`
* IntelliJ IDEA (unified) `intellij-idea`
* JetBrains Gateway `jetbrains-gateway`
* PhpStorm `phpstorm`
* PyCharm (unified) `pycharm`
* Rider `rider`
* RubyMine `rubymine`
* RustRover `rustrover`
* WebStorm `webstorm`

## Installation

To use it, enter the commands below, one by one. They download the correct GPG Key and add this repositories sources to your system sources.

```shell
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt-get update
```

To install IntelliJ IDEA for example, you can now run

```
sudo apt-get install intellij-idea
```

## I still have the old Launchpad PPA sources
If you still have the sources from [my Launchpad PPA](https://launchpad.net/~jonas-groeger/+archive/ubuntu/jetbrains), please run:

```shell
sudo rm -f \
  /etc/apt/sources.list.d/jetbrains.list \
  /etc/apt/sources.list.d/jetbrains.list.distUpgrade \
  /etc/apt/sources.list.d/jetbrains.list.save
```

Then, follow the installation instructions under `Installation`.

If you have any issues, please [create a GitHub issue](https://github.com/JonasGroeger/jetbrains-ppa/issues/new).

## I'm not getting any updates

Check your apt policy. It should say `any/main` after the URL. If it does not (like below), please redo the installation instructions.

```shell-session
$ apt show pycharm | grep "APT-Sources"
APT-Sources: http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com bionic/main amd64 Packages
```

## I used the old instructions with `apt-key` to add this repository

Run the two commands below to remove the `jetbrains-ppa` repository.

```shell
sudo rm /etc/apt/sources.list.d/jetbrains-ppa.list
apt-key del "C647 DF71 1B0C CC6A 9F87  69D0 F3A7 67B5 A6E8 698A"
```

Then, follow the installation instructions under `Installation`.

## I want another package

If you want a package for another JetBrains product please [create a GitHub issue](https://github.com/JonasGroeger/jetbrains-ppa/issues/new). Ideally, also provide a Pull Request.

## Why not use the [official snap packages](https://snapcraft.io/search?q=jetbrains)?

Sure! If you like snap packages, go ahead. However, not all packages contained in this repository are already available as snap packages. And maybe you don't like snaps? :)

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

There are already [existing](https://launchpad.net/~mmk2410/+archive/ubuntu/intellij-idea)
 [PPAs](https://launchpad.net/~vantuz/+archive/ubuntu/jetbrains).
However, none have continuous delivery or provide a wide range of JetBrains products.

## Maintainers note

```shell
# Create the build container
docker build -f docker/Dockerfile -t jetbrains-ppa-builder:latest .

# Use the build container
docker run -it --env-file build.env -v "$(pwd):/app" jetbrains-ppa-builder:latest

# Test GH action
act --secret-file build.env schedule
```

---

Maintained by Jonas Gröger. Automatically updated by [GitHub Actions](https://github.com/JonasGroeger/jetbrains-ppa/actions).
