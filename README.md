[![Build Status](https://travis-ci.org/padjis/ghistory.svg?branch=master)](https://travis-ci.org/padjis/ghistory)

<p align="center">
    <img src="data/128/com.github.padjis.ghistory.svg" alt="Icon" />
</p>

<h1 align="center">ghistory</h1>
<p align="center">Graphic interface for your bash history</p>

<p align="center">
  <a href="https://appcenter.elementary.io/com.github.padjis.ghistory"><img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter" /></a>
</p>

<p align="center">
    <img src="data/window-screenshot.png" alt="Screenshot">
</p>


## How does it work

- ghistory reads your bash history at startup and initializes its content based on it
- The user can search for a command in the history

## Built for elementary OS

While ghistory will be compiling on any Linux distribution, it is primarily
built for [elementary OS].

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)][AppCenter]


## Developing and building

Development is targeted at [elementary OS] Juno. If you want to hack on and
build Badger yourself, you'll need the following dependencies:

* libgranite-dev
* libgtk-3-dev
* meson
* valac

You can install them on elementary OS Juno with:

```shell
sudo apt install elementary-sdk
```

Run `meson build` to configure the build environment and run `ninja install`
to install:

```shell
meson build --prefix=/usr
cd build
sudo ninja install
```

Then run it with:

```shell
com.github.padjis.ghistory
```

[elementary OS]: https://elementary.io
[AppCenter]: https://appcenter.elementary.io/com.github.padjis.ghistory