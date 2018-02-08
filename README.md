# PPA for JetBrains products

This project builds Debian packages for various JetBrains products. Currently:

* IntelliJ IDEA Ultimate (`intellij-idea-ultimate`)
* IntelliJ IDEA Community (`intellij-idea-community`)
* PyCharm Professional (`pycharm-professional`)
* PyCharm Community (`pycharm-community`)
* PyCharm Education (`pycharm-education`)
* RubyMine (`rubymine`)
* WebStorm (`webstorm`)
* PhpStorm (`phpstorm`)
* DataGrip (`datagrip`)
* CLion (`clion`)
* Rider ( `rider` )
* GoLand ( `goland` )

Installing, for example `intellij-idea-ultimate` is easy:

    sudo apt-add-repository ppa:jonas-groeger/jetbrains
    sudo apt-get update
    sudo apt-get intellij-idea-ultimate

# I want another package

If you want a package for another Jetbrains product please [create a GitHub issue](https://github.com/JonasGroeger/jetbrains-ppa/issues/new)

# Building the packages

To build a package, run the `build` script with a package folder:

    ./build packages/intellij-idea-ultimate GPG_KEY_ID

To build intellij-idea-ultimate for example use:

    ./build packages/intellij-idea-ultimate CCA0C0C4EA16B4EEA2D5720ABECD4B5B330D89B5

Since Launchpad only accepts source packages, we are only creating source packages. These are
uploaded to the [`jetbrains` PPA on launchpad.net](https://launchpad.net/~jonas-groeger/+archive/ubuntu/jetbrains).

If you want to build binary packages (`.deb` files), look for `debuild` in `build` and remove
the `-S` flag.

# Why this was written

I hate manually downloading, extracting and moving the `*.tar.gz` from the
JetBrains website to get an IDE update. Unfortunately JetBrains does not have a
Debian repository so here is this PPA.

There are already [existing PPAs](https://launchpad.net/~mmk2410/+archive/ubuntu/intellij-idea).
However, none have continuous delivery or provide a wide range of JetBrains products.
