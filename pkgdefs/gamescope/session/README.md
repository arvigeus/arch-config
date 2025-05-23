# Gamescope session

## Decky

- [Decky Framegen](https://github.com/xXJSONDeruloXx/Decky-Framegen)
  - game has to be set to DLSS
  - some games support nativly framegen, other don't
  - activate hidden overlay with Insert key (Steam btn + trackpad moves mouse)
  - switch to FSR3
  - there's some option to fix HUD in broken games

### Themes

[Decky Themes](https://deckthemes.com/) (requires CSS Loader)

## Mangohud

To enable mangohud with gamescope you need to install mangoapp. `gamescope --mangoapp %command%`

Using normal mangohud with gamescope is not supported.

## Controller support

Related: [Gamepad (Arch wiki)](https://wiki.archlinux.org/title/Gamepad)

### Shortcuts

- `Ctrl+1` / `Logo`: Left menu
- `Ctrl+2` / `Logo+A` : Right menu
- `Ctrl+8`: `(Y)` button

## Gaming distributions

- [Bazzite](https://bazzite.gg/)
- [Nobara](https://nobaraproject.org/)
- [ChimeraOS](https://chimeraos.org/)
- [winesapOS](https://github.com/LukeShortCloud/winesapOS)
- [SteamFork](https://github.com/steamfork)
- [Playtron GameOS](https://www.playtron.one/)
- [CachyOS for Handhelds](https://github.com/CachyOS/CachyOS-Handheld)

## Upscaling

The `-F fsr` and `-F nis` flags can be used to upscale games using AMD FidelityFX™ Super Resolution 1.0 (FSR) or NVIDIA Image Scaling v1.0.3 (NIS) respectively. You can also use `-S integer` for integer upscaling or `-S stretch` for stretch scaling.

To upscale a 720p game to 1440p using FSR:

```sh
gamescope -h 720 -H 1440 -F fsr -- supertuxkart
```

To run a game at 1080p internal resolution but display it at 4K using NIS:

```sh
gamescope -w 1920 -h 1080 -W 3840 -H 2160 -F nis -- supertuxkart
```

Games with low resolutions typically use linear filtering on fullscreen by default and sometimes get stretched. This is specially noticeable in classic JRPG. To have a pixelated look and keep aspect ratio:

```sh
gamescope -F nearest -S fit -- tecnoballz
```

Filters can be changed while the game is running:

- `Super+n` toggle nearest filtering.
- `Super+u` toggle FSR upscaling.
- `Super+y` toggle NIS upscaling.
- `Super+o` increase FSR sharpness by 1.
- `Super+i` decrease FSR sharpness by 1.

## Notes

- Trying to start gamescope with `gamescope --prefer-vk-device 1002:73ef` doesn't work. Use `switcherooctl launch gamescope` instead.
- If session fails to start, uncomment the `exec > /tmp/gamescope-session.log 2>&1` line.
- Starting steam with `steam -steamos -gamepadui`
- Run `/usr/bin/gamescope-session` from time to time to check for errors.

## Troubleshooting

### Setup stops at selecting network

1. Install `gamescope-session-steam-git` (`sudo pacman -S --needed --noconfirm gamescope-session-steam-git`)
2. Create `~/.config/environment.d/gamescope-session-plus.conf`:

   ```conf
   CLIENTCMD="steam-native -gamepadui -steamos3 -steampal -steamdeck -pipewire-dmabuf"
   GAMESCOPECMD="switcherooctl launch gamescope -e -f"
   ```

3. Logout and select `Steam Big Pictur (Wayland)` session
4. Finish setup
5. At this point gamescope session starts, but it hangs when trying to start any game
6. Uninstall `gamescope-session-steam-git`

### Games start on wrong resolution

Go to the game page, select settings, and set specific resolution

### Decky Loader is not enabled

`Settings -> System -> Enable Developer Mode`

## Apps

### Firefox

- [HOWTO: Use Firefox in game mode, with working menus](https://www.reddit.com/r/SteamDeck/comments/18sm4vf/howto_use_firefox_in_game_mode_with_working_menus/)

## References

- ChimeraOS:
  - [gamescope-session](https://github.com/ChimeraOS/gamescope-session)
  - [gamescope-session-steam](https://github.com/ChimeraOS/gamescope-session-steam)
- [CachyOS-Handheld](https://github.com/CachyOS/CachyOS-Handheld)
- [Bazzite](https://github.com/ublue-os/bazzite)
  - [jupiter-dock-updater-bin](https://gitlab.com/evlaV/jupiter-dock-updater-bin)
- [Nobara](https://github.com/Nobara-Project/steamdeck-edition-packages)
- [steam-using-gamescope-guide](https://github.com/shahnawazshahin/steam-using-gamescope-guide)
- [Installing Arch on my Legion Go - A High Level Guide and my learnings](https://gaming.lenovo.com/legion-go/post/installing-arch-on-my-legion-go---a-high-level-guide-and-my-learnings-tUz9yvPwS1spaZw)
- [Arch Wiki: Gamescope](https://wiki.archlinux.org/title/Gamescope)
