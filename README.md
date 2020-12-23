# dotfiles

> 🏠 dotfiles for my macOS environment

# ![dotfiles][logo]
# ![dotfiles][logo2]

## Usage

* [Introduction](#introduction)
* [Installation](#installation)
* [Todo](#todo)
* [Management Tools](#mangement-tools)
  * dotfiles
  * macOS
  * zsh
  * node
  * vim
* [The Terminal](#the-terminal)
  * dev fonts
  * alacritty + zsh
* [Resources](#resources)

## Introduction

This is my development environment that I use everyday on my MacBook Pro.

If you have any improvements or suggestions, please feel free to submit it [here](https://github.com/jonleopard/dotfiles/issues) or [contact me](https://twitter.com/jonlprd)

Lastly, I have created a minimal dotfile repo for to help new users get started on their own dotfile journey. You can check out the project here: https://github.com/jonleopard/dotfile-starter.



#### Todo

[View the todo board here](https://github.com/jonleopard/dotfiles/projects/1)


## Installation
**Disclaimer:** If you decide to use these dotfiles, proceed at your own risk!

At the moment, this will only work in macOS.


1.  Download repo

* via git
* via curl

2.  Run scripts <--Currently working on these!

* Automatic: ./install.sh
* Manually: stow [folder]

3.  Done!

## Download and Stage Files

If you are on a new machine, then you might need to install git. You can also use `curl`. Whatever method you chose, make sure the files get put in your `$HOME` directory. If you aren't sure where that is, run `echo $HOME`.

**git**

```bash
cd && git clone https://github.com/jonleopard/dotfiles.git && cd dotfiles && chmod +x install.sh
```

**cURL**

```bash
cd && curl -#L https://github.com/jonleopard/dotfiles/tarball/master | tar -xzv
```

If you prefer, you can skip the install.sh script and run `stow` manually. Just tell `stow` which dotfiles you want to symlink:

```
stow [example]
```



## Mangement Tools


**dotfiles - gnu stow**

There are [so many flavors](https://www.reddit.com/r/fossworldproblems/comments/2jk4gi/there_are_too_many_solutions_for_managing_dotfiles/) when it comes to dotfile management. I wanted something lightweight and that could run in any \*nix environment with little to no dependencies.

All my dotfiles are managed with the extremely light weight [GNU Stow](https://www.gnu.org/software/stow/). Basically, stow creates & manages symlinks to files that are located in the home directory. This allows me to keep everything in an organized folder called 'dotfiles'. If you are interested in learning more about stow, I wrote a brief post about it [here](https://jonleopard.com/blog/dotfile-management-with-gnu-stow/)

**macOS - Homebrew**

Homebrew and Macports are pretty much the only mainstream options here. I went with [Homebrew](http://brew.sh/). I'm using [Homebrew-Cask](https://github.com/Homebrew/homebrew-bundle) which will go out and install all of the applications that I tell it to. [mas](https://github.com/mas-cli/mas) will install all of your Mac App Store apps. All of this is bundled in a list called a Brewfile.

**node - n**

[n](https://github.com/tj/n) allows me to switch between different node versions on the fly. I've installed `n` via [n-install](https://github.com/mklement0/n-install).

**zsh - antibody**

[antibody](http://getantibody.github.io/) has been my favorite zsh plugin mananger for a couple years now. The author has a great post on shell performance which I highly recommend if you are interested in speeding up your shell spawn times. It's written in go, so make sure you have go installed on your system.

**tmux - tpm**

[tpm](https://github.com/tmux-plugins/tpm) (which stands for tmux plugin manager) is a great little that has zero dependencies. Be sure to check out the [plugin](https://github.com/tmux-plugins) directory. 

**neovim - vim plug**

[vim-plug](https://github.com/junegunn/vim-plug) manages all of my vim plugins. It pairs nicely with [Neovim](https://github.com/junegunn/vim-plug#neovim).

## The Terminal


**alacritty + zsh**

As you could have guessed by now, I am using [zsh](http://www.zsh.org/) instead of bash as my unix shell. [Alacritty](https://github.com/jwilm/alacritty) is my terminal emulator and [Pure Prompt](https://github.com/sindresorhus/pure) is the shell prompt.


**Dev Fonts**

Below is a list of some of my favourite dev fonts that go great in your terminal, IDE, Text Editor, etc...
* [Hack Font](https://sourcefoundry.org/hack/)
* [mononoki](https://madmalik.github.io/mononoki/)
* [Tamsyn Font](http://www.fial.com/~scott/tamsyn-font/)
* [Consolas](https://www.typewolf.com/site-of-the-day/fonts/consolas)
* [Adobe Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
* [Pragmata Pro](http://www.fsd.it/shop/fonts/pragmatapro/)

If you need a [Powerline](https://github.com/powerline/powerline) font, a list of those can be found here: [Powerline Fonts](https://github.com/powerline/fonts). You could also check out the [Nerd Fonts](https://nerdfonts.com/) repo for a list of patched fonts and install them via homebrew.


## Wallpapers
I've been working a collection of my favorite wallpapers over the years. If you are interested, you can grab the bundle [here](https://www.dropbox.com/sh/phhmo009i52wp0r/AAAOhBkQrMM3a3Iy9e3n_aKAa?dl=0).

## Resources

* GNU Stow
  * [Manage Your Dotfile with GNU Stow](https://jonleopard.com/blog/dotfile-management-with-gnu-stow/)
  * [Getting started with dotfiles](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.6u2xwvbpv)
  * [Using gnu stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
  * [Managing dotfiles with gnu snow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
* Dotfile Repos
  * [mathiasbynens](https://github.com/mathiasbynens/dotfiles/)
  * [xero](https://github.com/xero/dotfiles)
  * [paulirish](https://github.com/paulirish/dotfiles)
  * [thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles)
  * [thoughtbot laptop](https://github.com/thoughtbot/laptop)
* Fonts
  * [Font rasterization](https://en.wikipedia.org/wiki/Font_rasterization)
  * [Top 10 Programming Fonts](http://hivelogic.com/articles/top-10-programming-fonts/)
  * [What are the best programming fonts?](https://www.slant.co/topics/67/~programming-fonts)
  * [Programming Fonts](http://programmingfonts.org/)
  * [Font Compare](http://s9w.io/font_compare/)

 

[logo]: .github/screenshot.png
[logo2]: .github/screenshot-2.png
