## Installomator Metadata

For those that are familiar with the Installomator (https://github.com/Installomator/Installomator) project, this repo is a tangent from that.  

Installomator has "label" files that when added to the rest of the Installomator script, allow for download and installation of nearly a 1000 applications.  

These labels are now in use with various other projects to do things that the Installomator creators probably didn't even consider when they started the project.  

Many of these other projects can benefit from having additional metadata available for all the "label" files. This repo is meant for that. There are two folders, one with application icons and another with plist files containing this supplemental metadata.


### What is here?  
There will be a plist in the Metadata folder and a complimentary png file in the Icons directory. These files will be named to exactly match the Installomator label files contained in that project.

The plist file will contain multiple keys. Here's an example plist file for the 'microsoftexcel' label in the Insallomator project:

**microsoftexcel.plist:**
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>AppID</key>
	<string>com.microsoft.Excel</string>
	<key>AppName</key>
	<string>Microsoft Excel</string>
	<key>Description</key>
	<string>Microsoft Excel is a popular spreadsheet software for macOS.</string>
	<key>Documentation</key>
	<string>https://support.microsoft.com/en-us/excel</string>
	<key>Keywords</key>
	<string>Microsoft, Excel, macOS, spreadsheet</string>
	<key>PackageID</key>
	<string></string>
	<key>Privacy</key>
	<string>https://privacy.microsoft.com/en-us/privacystatement</string>
	<key>Publisher</key>
	<string>Microsoft Corporation</string>
</dict>
</plist>
```

The Icons folder will contain the '**microsoftexcel.png**' file.