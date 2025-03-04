# Steam

## Launch options

Use this if you want Mangohud and Gamemode:

```sh
env MANGOHUD_CONFIG=”fsr,fps_value.gamemode” gamemoderun gamescope –mangoapp -w 640 -h 380 -W 1920 -H 1080 -F fsr -f – %command%
```

Enable FSR via desktop steam:

```sh
WINE_FULLSCREEN_FSR=1 WINE_FULLSCREEN_FSR_MODE=ultra %command%
```

## Related

- [github:ValveSoftware/steam-for-linux](https://github.com/ValveSoftware/steam-for-linux)
- [Steam command Line options](https://gist.github.com/davispuh/6600880)
