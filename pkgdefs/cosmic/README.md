# COSMIC

- [Cosmic Themes](https://cosmic-themes.org)
- [Cosmic Apps](https://cosmic-utils.github.io/)
- [Cosmic Application Template](https://github.com/pop-os/cosmic-application-template/)
- [Cosmic Applet Template](https://github.com/cosmic-utils/cosmic-applet-template)
- [Cosmic Project Collection](https://github.com/cosmic-utils/cosmic-project-collection)
- [COSMIC Applet Tutorial](https://bhh32.com/posts/tutorials/cosmic_applet_tutorial)

## Other

### Keyboard layout

\`nano ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config\`

```ron
(
    rules: "",
    model: "pc105+inet",
    layout: "us,bg",
    variant: ",phonetic",
    options: Some("terminate:ctrl_alt_bksp,grp:lalt_lshift_toggle"),
)
```

### Auto login

Add the following section to `/etc/greetd/cosmic-greeter.toml`:

```toml
[initial_session]
command = "cosmic-session"
user = "arvigeus"
```
