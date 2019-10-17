# yabai (a tiling window manager for macOS)

I am giving this a try. Using it along with skhd (same dev), so both configs are found in
this directory. Make sure you have a config file created for both tools before
running them.

### Installation instructions:

Install both programs:

```
$ brew tap koekeishiya/formulae && brew install yabai && brew services start yabai
$ brew install koekeishiya/formulae/skhd && brew services start skhd
```

You can stop both services by running the following:

`brew services stop [yabai || skhd]`

More info here:

- yabai: [yabai](https://github.com/koekeishiya/yabai)
- yabai: [skhd](https://github.com/koekeishiya/skhd)

#### skhd keybindings

```
# focus window
alt - h : yabai -m window --focus west
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east

# swap window
shift + alt - h : yabai -m window --swap west
shift + alt - j : yabai -m window --swap south
shift + alt - k : yabai -m window --swap north
shift + alt - l : yabai -m window --swap east

# move window
shift + cmd - h : yabai -m window --warp west
shift + cmd - j : yabai -m window --warp south
shift + cmd - k : yabai -m window --warp north
shift + cmd - l : yabai -m window --warp east

# balance size of windows
shift + alt - 0 : yabai -m space --balance

# make floating window fill screen
shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

# make floating window fill left-half of screen
shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1

# make floating window fill right-half of screen
shift + alt - right  : yabai -m window --grid 1:2:1:0:1:1

# create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
shift + cmd - n : yabai -m space --create && \
                  index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')" && \
                  yabai -m window --space "${index}" && \
                  yabai -m space --focus "${index}"

# create desktop and follow focus - uses jq for parsing json (brew install jq)
cmd + alt - n : yabai -m space --create && \
                index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')" && \
                yabai -m space --focus "${index}"

# destroy desktop
cmd + alt - w : yabai -m space --destroy

# fast focus desktop
cmd + alt - x : yabai -m space --focus recent
cmd + alt - z : yabai -m space --focus prev
cmd + alt - c : yabai -m space --focus next
cmd + alt - 1 : yabai -m space --focus 1
cmd + alt - 2 : yabai -m space --focus 2
cmd + alt - 3 : yabai -m space --focus 3
cmd + alt - 4 : yabai -m space --focus 4
cmd + alt - 5 : yabai -m space --focus 5
cmd + alt - 6 : yabai -m space --focus 6
cmd + alt - 7 : yabai -m space --focus 7
cmd + alt - 8 : yabai -m space --focus 8
cmd + alt - 9 : yabai -m space --focus 9
cmd + alt - 0 : yabai -m space --focus 10

# send window to desktop and follow focus
shift + cmd - x : yabai -m window --space recent; yabai -m space --focus recent
shift + cmd - z : yabai -m window --space prev; yabai -m space --focus prev
shift + cmd - c : yabai -m window --space next; yabai -m space --focus next
shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5
shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6
shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7
shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8
shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9
shift + cmd - 0 : yabai -m window --space 10; yabai -m space --focus 10

# focus monitor
ctrl + alt - x  : yabai -m display --focus recent
ctrl + alt - z  : yabai -m display --focus prev
ctrl + alt - c  : yabai -m display --focus next
ctrl + alt - 1  : yabai -m display --focus 1
ctrl + alt - 2  : yabai -m display --focus 2
ctrl + alt - 3  : yabai -m display --focus 3

# send window to monitor and follow focus
ctrl + cmd - x  : yabai -m window --display recent; yabai -m display --focus recent
ctrl + cmd - z  : yabai -m window --display prev; yabai -m display --focus prev
ctrl + cmd - c  : yabai -m window --display next; yabai -m display --focus next
ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1
ctrl + cmd - 2  : yabai -m window --display 2; yabai -m display --focus 2
ctrl + cmd - 3  : yabai -m window --display 3; yabai -m display --focus 3

# move window
shift + ctrl - a : yabai -m window --move rel:-20:0
shift + ctrl - s : yabai -m window --move rel:0:20
shift + ctrl - w : yabai -m window --move rel:0:-20
shift + ctrl - d : yabai -m window --move rel:20:0

# increase window size
shift + alt - a : yabai -m window --resize left:-20:0
shift + alt - s : yabai -m window --resize bottom:0:20
shift + alt - w : yabai -m window --resize top:0:-20
shift + alt - d : yabai -m window --resize right:20:0

# decrease window size
shift + cmd - a : yabai -m window --resize left:20:0
shift + cmd - s : yabai -m window --resize bottom:0:-20
shift + cmd - w : yabai -m window --resize top:0:20
shift + cmd - d : yabai -m window --resize right:-20:0

# set insertion point in focused container
ctrl + alt - h : yabai -m window --insert west
ctrl + alt - j : yabai -m window --insert south
ctrl + alt - k : yabai -m window --insert north
ctrl + alt - l : yabai -m window --insert east

# rotate tree
alt - r : yabai -m space --rotate 90

# mirror tree y-axis
alt - y : yabai -m space --mirror y-axis

# mirror tree x-axis
alt - x : yabai -m space --mirror x-axis

# toggle desktop offset
alt - a : yabai -m space --toggle padding; yabai -m space --toggle gap

# toggle window parent zoom
alt - d : yabai -m window --toggle zoom-parent

# toggle window fullscreen zoom
alt - f : yabai -m window --toggle zoom-fullscreen

# toggle window native fullscreen
shift + alt - f : yabai -m window --toggle native-fullscreen

# toggle window border
shift + alt - b : yabai -m window --toggle border

# toggle window split type
alt - e : yabai -m window --toggle split

# float / unfloat window and center on screen
alt - t : yabai -m window --toggle float;\
          yabai -m window --grid 4:4:1:1:2:2

# toggle sticky (show on all spaces)
alt - s : yabai -m window --toggle sticky

# toggle topmost (keep above other windows)
alt - o : yabai -m window --toggle topmost

# toggle sticky, topmost and resize to picture-in-picture size
alt - p : yabai -m window --toggle sticky;\
          yabai -m window --toggle topmost;\
          yabai -m window --grid 5:5:4:0:1:1

# change layout of desktop
ctrl + alt - a : yabai -m space --layout bsp
ctrl + alt - d : yabai -m space --layout float
```

#### yabai config

```
#!/usr/bin/env sh

# bar settings
yabai -m config status_bar                   off
yabai -m config status_bar_text_font         "Helvetica Neue:Bold:12.0"
yabai -m config status_bar_icon_font         "FontAwesome:Regular:12.0"
yabai -m config status_bar_background_color  0xff202020
yabai -m config status_bar_foreground_color  0xffa8a8a8
yabai -m config status_bar_space_icon_strip  I II III IV V VI VII VIII IX X
yabai -m config status_bar_power_icon_strip   
yabai -m config status_bar_space_icon        
yabai -m config status_bar_clock_icon        

# global settings
yabai -m config mouse_follows_focus          off
yabai -m config focus_follows_mouse          off
yabai -m config window_placement             second_child
yabai -m config window_topmost               off
yabai -m config window_opacity               off
yabai -m config window_opacity_duration      0.0
yabai -m config window_shadow                on
yabai -m config window_border                off
yabai -m config window_border_placement      inset
yabai -m config window_border_width          4
yabai -m config window_border_radius         -1.0
yabai -m config active_window_border_topmost off
yabai -m config active_window_border_color   0xff775759
yabai -m config normal_window_border_color   0xff505050
yabai -m config insert_window_border_color   0xffd75f5f
yabai -m config active_window_opacity        1.0
yabai -m config normal_window_opacity        0.90
yabai -m config split_ratio                  0.50
yabai -m config auto_balance                 off
yabai -m config mouse_modifier               fn
yabai -m config mouse_action1                move
yabai -m config mouse_action2                resize

# general space settings
yabai -m config layout                       bsp
yabai -m config top_padding                  20
yabai -m config bottom_padding               20
yabai -m config left_padding                 20
yabai -m config right_padding                20
yabai -m config window_gap                   10

echo "yabai configuration loaded.."
```
