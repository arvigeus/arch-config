user_pref("browser.aboutConfig.showWarning", false);

// Enable restoring previous session
user_pref("browser.startup.page", 3);
user_pref("browser.sessionstore.enabled", true);
user_pref("browser.sessionstore.privacy_level", 0);

// Use native XDG file picker
user_pref("widget.use-xdg-desktop-portal.file-picker", 1);

user_pref("dom.webgpu.enabled", true);

// Security
user_pref("dom.security.https_only_mode", true);
user_pref("browser.contentblocking.category", "strict");

// Bloat
user_pref("extensions.pocket.enabled", false);
user_pref("identity.fxaccounts.enabled", false);
user_pref("browser.newtabpage.activity-stream.showWeather", false);
user_pref("signon.rememberSignons", false); // Already using BitWarden for that
