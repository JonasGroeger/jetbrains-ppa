# PPA for JetBrains products [![Build Status](https://travis-ci.org/JonasGroeger/jetbrains-ppa.svg?branch=master)](https://travis-ci.org/JonasGroeger/jetbrains-ppa)

This project builds Debian packages for various JetBrains products. Currently:

* CLion (`clion`)
* DataGrip (`datagrip`)
* GoLand (`goland`)
* IntelliJ IDEA Community (`intellij-idea-community`)
* IntelliJ IDEA Ultimate (`intellij-idea-ultimate`)
* PhpStorm (`phpstorm`)
* PyCharm Community (`pycharm-community`)
* PyCharm Education (`pycharm-education`)
* PyCharm Professional (`pycharm-professional`)
* Rider (`rider`)
* RubyMine (`rubymine`)
* WebStorm (`webstorm`)

Installing, for example `intellij-idea-ultimate` is easy:

    sudo add-apt-repository ppa:jonas-groeger/jetbrains
    sudo apt-get update
    sudo apt-get install intellij-idea-ultimate

# I want another package

If you want a package for another Jetbrains product please [create a GitHub issue](https://github.com/JonasGroeger/jetbrains-ppa/issues/new)

# Building the packages

To build a package, run the `build` script with a package folder:

    ./build-single-deb packages/<package>

To build intellij-idea-ultimate for example use:

    ./build-single-deb packages/intellij-idea-ultimate

# Why this was written

I hate manually downloading, extracting and moving the `*.tar.gz` from the
JetBrains website to get an IDE update. Unfortunately JetBrains does not have a
Debian repository.

There are already [existing](https://launchpad.net/~mmk2410/+archive/ubuntu/intellij-idea)
 [PPAs](https://launchpad.net/~vantuz/+archive/ubuntu/jetbrains).
However, none have continuous delivery or provide a wide range of JetBrains products.
