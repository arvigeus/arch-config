#!/bin/bash

install_browser_extensions() {
  local browserType=$1
  local browserName=${2:-$browserType}

  if [[ "$browserType" == "firefox" ]]; then
    if [[ "$browserName" == "zen" ]]; then
      browserName="/opt/zen-browser-bin/"
    else
      browserName=${2:-/usr/lib/firefox/browser/extensions}
    fi
    sudo mkdir -p "$browserName"
  fi
  
  local extensions=(
    # Bitwarden
    "https://addons.mozilla.org/firefox/downloads/file/4410896/bitwarden_password_manager-latest.xpi"
    "https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb"

    # uBlock Origin
    "https://addons.mozilla.org/firefox/downloads/file/4492375/ublock_origin-latest.xpi"
    "https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh"

    # Multi-Account Containers (Firefox only)
    "https://addons.mozilla.org/firefox/downloads/file/4494279/multi_account_containers-latest.xpi"

    # Export Cookies
    "https://addons.mozilla.org/firefox/downloads/file/3403419/export_cookies_txt-latest.xpi"
    "https://chromewebstore.google.com/detail/get-cookiestxt-locally/cclelndahbckbenkjhflpdbgdldlbecc"

    # Picture-in-Picture
    "https://chromewebstore.google.com/detail/picture-in-picture-extens/hkgfoiooedgoejojocmhlaklaeopbecg"

    # Plasma Integration
    "https://addons.mozilla.org/firefox/downloads/file/4298512/plasma_integration-latest.xpi"
    "https://chromewebstore.google.com/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai"

    # React Dev Tools
    "https://addons.mozilla.org/firefox/downloads/file/4360002/react_devtools-latest.xpi"
    "https://chromewebstore.google.com/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi"
    
    # Wappalyzer
    "https://addons.mozilla.org/firefox/downloads/file/4482384/wappalyzer-latest.xpi"
    "https://chromewebstore.google.com/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg"

    # Web Developer
    "https://addons.mozilla.org/firefox/downloads/file/4306323/web_developer-latest.xpi"
    "https://chromewebstore.google.com/detail/web-developer-tool-for-ch/ghenifimhcdihapkceohjpgiabidpgji"

    # WebHint
    "https://addons.mozilla.org/firefox/downloads/file/4344764/webhint-latest.xpi"
    "https://chromewebstore.google.com/detail/webhint/gccemnpihkbgkdmoogenkbkckppadcag"

    # Enhancer for Youtube
    "https://addons.mozilla.org/firefox/downloads/file/4393561/enhancer_for_youtube-latest.xpi"
    "https://chromewebstore.google.com/detail/enhancer-for-youtube/ponfpcnoihfmfllpaingbgckeeldkhle"

    # SponsorBlock
    "https://addons.mozilla.org/firefox/downloads/file/4480833/sponsorblock-latest.xpi"
    "https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone"

    # Search by image (Firefox only)
    "https://addons.mozilla.org/firefox/downloads/file/4492596/search_by_image-latest.xpi"

    # Language Tool
    "https://addons.mozilla.org/firefox/downloads/file/4470413/languagetool-latest.xpi"
    "https://chromewebstore.google.com/detail/ai-grammar-checker-paraph/oldceeleldhonbafppcapldpdifcinji"

    # The Camelizer
    "https://addons.mozilla.org/firefox/downloads/file/4075638/the_camelizer_price_history_ch-latest.xpi"
    "https://chromewebstore.google.com/detail/the-camelizer/ghnomdcacenbmilgjigehppbamfndblo"

    # Cultivate
    # "https://addons.mozilla.org/firefox/downloads/latest/cultivate/"
    # "https://chromewebstore.google.com/detail/empty-title/pfldomphmndnmmhhlbekfbafifkkpnbc"
  )

  for url in "${extensions[@]}"; do
    case "$browserType" in
      "firefox")  [[ "$url" == https://addons.mozilla.org* ]] && install_mozilla_extension "$url" "$browserName" ;;
      "chromium") [[ "$url" == https://chromewebstore.google.com* ]] && install_chromium_extension "$url" "$browserName" ;;
    esac
  done
}

install_mozilla_extension() {
  local url=$1
  local extensions_dir=$2

  # Hardcoded fallback mapping for extensions with missing manifest IDs
  declare -A FIREFOX_EXTENSION_IDS=(
    ["export_cookies_txt-latest.xpi"]="{36bdf805-c6f2-4f41-94d2-9b646342c1dc}"
  )

  local filename
  filename=$(basename "$url")
  local tmpdir
  tmpdir=$(mktemp -d)

  echo "Downloading $filename..."
  wget -q -O "$tmpdir/$filename" "$url" || {
    echo "❌ Failed to download $url"
    return
  }

  unzip -q "$tmpdir/$filename" -d "$tmpdir/unpacked" || {
    echo "❌ Failed to unzip $filename"
    return
  }

  local manifest="$tmpdir/unpacked/manifest.json"
  local extension_id

  if [[ -f "$manifest" ]]; then
  extension_id=$(jq -r '
      .browser_specific_settings.gecko.id // 
      .applications.gecko.id // 
      empty
    ' "$manifest")
  fi

  if [[ -z "$extension_id" ]]; then
    extension_id="${FIREFOX_EXTENSION_IDS[$filename]}"
    if [[ -z "$extension_id" ]]; then
      echo "⚠️ No extension ID for $filename and no fallback defined. Skipping."
      return
    fi
  fi

  sudo cp "$tmpdir/$filename" "$extensions_dir/$extension_id.xpi" || {
    echo "❌ Failed to copy $filename"
    return
  }

  rm -rf "$tmpdir"
}

# https://developer.chrome.com/docs/extensions/how-to/distribute/install-extensions
install_chromium_extension() {
  local url="$1"
  local browser="${2:-chromium}"
  
  # Extract extension ID from URL
  local extension_id
  if [[ "$url" =~ /detail/[^/]+/([a-zA-Z]+)/?$ ]]; then
    extension_id="${BASH_REMATCH[1]}"
  else
    echo "❌ Failed to extract extension ID from $url"
    return 1
  fi
  
  # Determine config directory
  local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/$browser"
  local ext_dir="$config_dir/External Extensions"
  
  mkdir -p "$ext_dir"
  
  # Create extension JSON file
  cat > "$ext_dir/$extension_id.json" << EOF
{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}
EOF
  
  echo "✅ Installed extension $extension_id for $browser"
}