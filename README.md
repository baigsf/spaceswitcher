# SpaceSwitcher

Native instant workspace switching on macOS. No more waiting for animations.

> Fork of [jurplel/InstantSpaceSwitcher](https://github.com/jurplel/InstantSpaceSwitcher) with the macOS 27 (27.0) space-switching fix (upstream [PR #102](https://github.com/jurplel/InstantSpaceSwitcher/pull/102) by markokovac16, co-authored by maxvelkir).

## Features

- Does not require disabling SIP
- Uses native macOS spaces
- Free

A simple CLI is provided (`InstantSpaceSwitcher.app/Contents/MacOS/ISSCli --help`)


## Installation

### Homebrew

```sh
brew tap baigsf/tap
brew install --cask spaceswitcher
```

### Downloads

Pre-built binaries are available through Github Releases [here](https://github.com/baigsf/spaceswitcher/releases).

### Build from source

```sh
git clone https://github.com/baigsf/spaceswitcher
cd spaceswitcher
./dist/build.sh
open ./build/InstantSpaceSwitcher.app
```

### Troubleshooting
If you encounter issues opening the app, such as:
> "Apple could not verify InstantSpaceSwitcher.app is free of malware"

> "App is damaged and can’t be opened"

> "App can't be opened because the developer cannot be verified"

Please follow the instructions [here](https://wiki.hacks.guide/wiki/Open_unsigned_applications_on_macOS_Sequoia_and_newer) for instructions on how to allow the app to run[^1].

## Background
When I first bought a high refresh rate monitor, around ~2018, I could tell that the space switching animation was longer because it had scaled with the refresh rate. Because of this, I eventually stopped using spaces altogether, and have been looking for a solution ever since. 

The workaround in this project is to create a synthetic trackpad gesture with an artificially high velocity. This effectively skips the animation.

If you work at Apple, and your team owns the space switching animation, please fix this long-standing bug[^2] (and let us disable the animation natively, please).

[^1]: This happens because the app is not signed, which requires a costly Apple Developer account
[^2]: And I know for a fact there is a rdar for this

