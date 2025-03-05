#!/bin/bash

install_browser_extensions() {
  local browserType=$1
  local browserName=${2:-$browserType}

  local extensions=(
    # Bitwarden
    "https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/"
    "https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb"

    # uBlock Origin
    "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/"
    "https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh"

    # Multi-Account Containers (Firefox only)
    "https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/"

    # Picture-in-Picture
    "https://chromewebstore.google.com/detail/picture-in-picture-extens/hkgfoiooedgoejojocmhlaklaeopbecg"

    # Plasma Integration
    "https://addons.mozilla.org/en-US/firefox/addon/plasma-integration/"
    "https://chromewebstore.google.com/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai"

    # React Dev Tools
    "https://addons.mozilla.org/en-US/firefox/addon/react-devtools/"
    "https://chromewebstore.google.com/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi"
    
    # Wappalyzer
    "https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/"
    "https://chromewebstore.google.com/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg"

    # Web Developer
    "https://addons.mozilla.org/en-US/firefox/addon/web-developer/"
    "https://chromewebstore.google.com/detail/web-developer-tool-for-ch/ghenifimhcdihapkceohjpgiabidpgji"

    # WebHint
    "https://addons.mozilla.org/en-US/firefox/addon/webhint/"
    "https://chromewebstore.google.com/detail/webhint/gccemnpihkbgkdmoogenkbkckppadcag"

    # Enhancer for Youtube
    "https://addons.mozilla.org/en-US/firefox/addon/enhancer-for-youtube/"
    "https://chromewebstore.google.com/detail/enhancer-for-youtube/ponfpcnoihfmfllpaingbgckeeldkhle"

    # Search by image (Firefox only)
    "https://addons.mozilla.org/en-US/firefox/addon/search_by_image/"

    # Language Tool
    "https://addons.mozilla.org/en-US/firefox/addon/languagetool/"
    "https://chromewebstore.google.com/detail/ai-grammar-checker-paraph/oldceeleldhonbafppcapldpdifcinji"

    # The Camelizer
    "https://addons.mozilla.org/en-US/firefox/addon/the-camelizer-price-history-ch/"
    "https://chromewebstore.google.com/detail/the-camelizer/ghnomdcacenbmilgjigehppbamfndblo"

    # Cultivate
    # "https://addons.mozilla.org/firefox/downloads/latest/cultivate/"
    # "https://chromewebstore.google.com/detail/empty-title/pfldomphmndnmmhhlbekfbafifkkpnbc"
  )

  for url in "${extensions[@]}"; do
    case "$browserType" in
      "firefox")  [[ "$url" == https://addons.mozilla.org* ]] && $browserName --new-tab "$url" >/dev/null 2>&1 & disown ;;
      "chromium") [[ "$url" == https://chromewebstore.google.com* ]] && $browserName --new-tab "$url" >/dev/null 2>&1 & disown ;;
    esac
  done
}
