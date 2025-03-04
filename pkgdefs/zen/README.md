# Zen

## Tips and Tricks

### Enable Right click on sites that disabled it

Hold Shift while right-clicking

There's a `about:config` setting called `dom.event.contextmenu.enabled` defaulting to true, when you change to false you don't need to hold shift, it will always open the browser context menu (and in most cases still do the page behavior of showing the web app context menu or whatever, you can then press esc to close the browser's menu but it may also close the page menu depending on how they implemented it).

Then there's a second option called `dom.event.contextmenu.shift_suppresses_event` which defaults to true and does what you said: Simple right click opens the page menu and shift + right click don't send the page the event at all and instead opens the browser's menu.
