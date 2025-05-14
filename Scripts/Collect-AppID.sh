#!/usr/bin/env zsh

# folder containing your Installomator metadata label.plist files (pass as first arg, or edit here)
PLIST_DIR="${1:-/path/to/your/plists}"

# where to look for apps
APP_DIRS=( "/Applications" "/Applications/Utilities" )

for plist in "$PLIST_DIR"/*.plist; do
  # grab the AppName value
  appName=$(defaults read "$plist" AppName 2>/dev/null)
  [[ -z "$appName" ]] && continue

  # find the .app bundle
  foundApp=""
  for dir in "${APP_DIRS[@]}"; do
    if [[ -d "$dir/$appName.app" ]]; then
      foundApp="$dir/$appName.app"
      break
    fi
  done

  if [[ -n "$foundApp" ]]; then
    infoPlist="$foundApp/Contents/Info.plist"
    # read CFBundleIdentifier
    bundleID=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "$infoPlist" 2>/dev/null)
    if [[ -n "$bundleID" ]]; then
      # try to set AppID; if it doesn't exist, add it
      /usr/libexec/PlistBuddy -c "Set :AppID $bundleID" "$plist" 2>/dev/null \
        || /usr/libexec/PlistBuddy -c "Add :AppID string $bundleID" "$plist"
      echo "✔️  $plist → AppID set to $bundleID"
    else
      echo "⚠️  CFBundleIdentifier not found in $infoPlist"
    fi
  else
    echo "⚠️  App bundle for '$appName' not found in Applications/Utilities"
  fi
done