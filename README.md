# jetbrians-ppa

This project builds Debian packages for various JetBrains products. Currently:

* IntelliJ IDEA Ultimate (`intellij-idea-ultimate`)
* IntelliJ IDEA Community (`intellij-idea-community`)
* PyCharm Professional (`pycharm-professional`)
* PyCharm Community (`pycharm-community`)
* PyCharm Education (`pycharm-education`)

Installing for example `intellij-idea-ultimate` is ezpz:

    sudo apt-add repository ppa:jonas-groeger/jetbrains-ppa
    sudo apt-get update
    sudo apt-get intellij-idea-ultimate

# I want another package

If you want another package (RubyMine anyone?), please create an issue. Doing
it yourself is also pretty easy:

    mkdir rubymine
    cd rubymine

    # Download the program icon from https://www.jetbrains.com/company/press/
    # See section "Product Logos"
    ls rubymine.png

    # Create project config
    cp ../pycharm-professional/project.json .
    vim project.json

To get the correct values for some things it is useful to install the program
manually and then look at the files (for example the `startup_wm_class`).

The next build will have rubymine in it then.

# Building the packages

To build the packages, run `./build-all`. Selective building is currently not
supported. Every package is contained in a folder with its respective name. On
completion, you can find all built packages in the `dist` directory:

    $ tree dist
    dist
    ├── intellij-idea-community
    │   ├── intellij-idea-community_2017.2.3.dsc
    │   ├── intellij-idea-community_2017.2.3_source.build
    │   ├── intellij-idea-community_2017.2.3_source.changes
    │   └── intellij-idea-community_2017.2.3.tar.xz
    ├── intellij-idea-ultimate
    │   ├── intellij-idea-ultimate_2017.2.3.dsc
    │   ├── intellij-idea-ultimate_2017.2.3_source.build
    │   ├── intellij-idea-ultimate_2017.2.3_source.changes
    │   └── intellij-idea-ultimate_2017.2.3.tar.xz
    ├── pycharm-community
    │   ├── pycharm-community_2017.2.3.dsc
    │   ├── pycharm-community_2017.2.3_source.build
    │   ├── pycharm-community_2017.2.3_source.changes
    │   └── pycharm-community_2017.2.3.tar.xz
    ├── pycharm-education
    │   ├── pycharm-education_4.0.dsc
    │   ├── pycharm-education_4.0_source.build
    │   ├── pycharm-education_4.0_source.changes
    │   └── pycharm-education_4.0.tar.xz
    └── pycharm-professional
        ├── pycharm-professional_2017.2.3.dsc
        ├── pycharm-professional_2017.2.3_source.build
        ├── pycharm-professional_2017.2.3_source.changes
        └── pycharm-professional_2017.2.3.tar.xz

Currently, only source packages are built since they are then uploaded to
[the Launchpad PPA repository](https://launchpad.net/~jonas-groeger/+archive/ubuntu/jetbrains).
If you want to build binary packages (`.deb` files), look for `debuild` in `build-all` and remove
the `-S` flag.

# Continuous Delivery

Since outdated packages are of no use, [a CircleCI job was created](TODO: Add)
to monitor the JetBrains API for new releases. Once a new release is available
it automatically uploaded to the PPA in no more than 5-10 minutes (depending on
how fast CirleCI is).

# Why this was written

I hate manually downloading, extracting and moving the `*.tar.gz` from the
JetBrains website to get an IDE update. Unfortunately JetBrains does not have a
Debian repository so here is this PPA.

There are already
[existing PPAs](https://launchpad.net/~mmk2410/+archive/ubuntu/intellij-idea).
However, nothing is built automatically and provides a wide range of JetBrains product. 
