# jetbrians-ppa

This project builds Debian packages for various JetBrains products. Currently:

* IntelliJ IDEA Ultimate (`intellij-idea-ultimate`)
* IntelliJ IDEA Community (`intellij-idea-community`)
* PyCharm Professional (`pycharm-professional`)
* PyCharm Community (`pycharm-community`)
* PyCharm Education (`pycharm-education`)
* RubyMine (`rubymine`)
* WebStorm (`webstorm`)
* PhpStorm (`phpstorm`)

Installing, for example `intellij-idea-ultimate` is easy:

    sudo apt-add repository ppa:jonas-groeger/jetbrains-ppa
    sudo apt-get update
    sudo apt-get intellij-idea-ultimate

# I want another package

If you want a package for another Jetbrains product please [create a GitHub issue](https://github.com/JonasGroeger/jetbrains-ppa/issues/new)

# Building the packages

To build a package, run the `build` script with a package folder:

    ./build packages/intellij-idea-ultimate --signing_key GPG_KEY_ID --dist DISTRIBUTION_NAME

To build intellij-idea-ultimate for Ubuntu `artful` for example use:

    ./build packages/intellij-idea-ultimate --signing_key CCA0C0C4EA16B4EEA2D5720ABECD4B5B330D89B5 --dist artful

Since Launchpad only accepts source packages, we are only creating source packages. These are
uploaded to the [`jetbrains-ppa` on launchpad.net](https://launchpad.net/~jonas-groeger/+archive/ubuntu/jetbrains).

If you want to build binary packages (`.deb` files), look for `debuild` in `build` and remove
the `-S` flag.

# Continuous Delivery

Since outdated packages are a pain, [a TravisCI job with scheduled builds has been created](LINK). It:

1. Checks daily (TravisCI CronJob) for new package versions (Jetbrains API)
2. Checks if the version on Launchpad is older
3. If it is, the package is updated, build and pushed to Launchpad
4. The package is copied to all other distributions

Step 4 sucks a little bit: Launchpad is slow and sometimes we have to wait for a complete build there for 1-2 hours. Only then the binaries are ready to be copied. This is why when there is a new version of a package, it will not actually be copied in step 4 since the binaries are not built yet. We could stall the TravisCI build to wait but we'll face timeout problems. The result is that it might take one additional run (aka. one more day) to also copy the packages to other distributions.

# Why this was written

I hate manually downloading, extracting and moving the `*.tar.gz` from the
JetBrains website to get an IDE update. Unfortunately JetBrains does not have a
Debian repository so here is this PPA.

There are already [existing PPAs](https://launchpad.net/~mmk2410/+archive/ubuntu/intellij-idea).
However, none have continuous delivery or provides a wide range of JetBrains products.
