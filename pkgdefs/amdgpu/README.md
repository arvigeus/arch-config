# AMD GPU

## [Environment variables](https://docs.mesa3d.org/envvars.html)

### DRI_PRIME

Use a non-default GPU:

```sh
DRI_PRIME=N
DRI_PRIME=N! # Forced
```

## Tips and Tricks

List available cards:

```sh
MESA_VK_DEVICE_SELECT=list vulkaninfo
```

## Links

- [Issues](https://gitlab.freedesktop.org/drm/amd)
