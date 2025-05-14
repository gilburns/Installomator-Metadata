#!/usr/bin/env zsh

PLIST_DIR="${1:-/path/to/your/plists}"
APP_DIRS=( "/Applications" "/Applications/Utilities" )

for plist in "$PLIST_DIR"/*.plist; do
  appName=$(defaults read "$plist" AppName 2>/dev/null)
  [[ -z "$appName" ]] && continue

  # find the .app
  foundApp=""
  for dir in "${APP_DIRS[@]}"; do
    [[ -d "$dir/$appName.app" ]] && { foundApp="$dir/$appName.app"; break }
  done
  if [[ -z "$foundApp" ]]; then
    echo "⚠️  $plist: couldn’t find $appName.app"; continue
  fi

  infoPlist="$foundApp/Contents/Info.plist"
  # get the icon file base name (might be “FooIcon” or “FooIcon.icns”)
  iconBase=$(/usr/libexec/PlistBuddy -c "Print CFBundleIconFile" "$infoPlist" 2>/dev/null)
  [[ -z "$iconBase" ]] && { echo "⚠️  $plist: no CFBundleIconFile in $infoPlist"; continue }

  # ensure it ends in .icns
  [[ "$iconBase" != *.icns ]] && iconBase="$iconBase.icns"

  iconPath="$foundApp/Contents/Resources/$iconBase"
  if [[ ! -f "$iconPath" ]]; then
    echo "⚠️  $plist: icon not found at $iconPath"; continue
  fi

  # build output PNG path
  plistName=$(basename "$plist" .plist)
  outPng="$PLIST_DIR/${plistName}.png"

  # convert+resize
  sips -s format png "$iconPath" --out "$outPng" \
       --resampleWidth 512 >/dev/null 2>&1 \
    && echo "✔️  wrote icon to $outPng" \
    || echo "❌  failed to convert $iconPath"
done