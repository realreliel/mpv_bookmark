# mpv_bookmark

mpv_bookmark is a Lua script for the MPV media player that allows you to easily add, remove, and navigate between bookmarks during video playback.

## Configuration

You can configure the variables mentioned in this document by adding overrides  to the following file in your MPV scripts directory:
  - On Linux, `~/.config/mpv/script-opts/mpv_bookmark.conf`
  - On Windows, `%APPDATA%\mpv\script-opts\mpv_bookmark.conf`

Create the file if it doesn't exist. You can also create it at `{path-to-mpv}/script-opts/mpv_bookmark.conf` if you want it to affect only a specific instance of MPV.

Supply an override for any of the variables with the desired values. For example, the following configuration is equivalent to the defaults supplied with the script:
```
leadin_threshold=7 # how far back to create the bookmark at in seconds
cleanup_threshold=20 # how far to search when deleting a bookmark in seconds
pause_after_jump=no #  whether or not to pause the video after jumping to a bookmark
```

## Features

- Add a bookmark `leadin_threshold` seconds before the current playback position
- Navigate between bookmarks using keyboard shortcuts
- Remove a bookmark within `cleanup_threshold` seconds of the current playback position
- Optionally pause the video after jumping to a bookmark

## Installation

1. Download `mpv_bookmark.zip` from the Releases tab on the right
2. Extract the file containing the .lua script to a folder
3. Place the `mpv_bookmark.lua` file in your MPV scripts directory
   - For Linux: `~/.config/mpv/scripts/`
   - For Windows: `%APPDATA%\mpv\scripts\`

## Usage

The script provides the following keyboard shortcuts:

- **b**: Add a bookmark `leadin_threshold` seconds before the current playback position. If the resulting time is negative, the bookmark will be set to the beginning of the video (0 seconds).
- **Shift+Left**: Navigate to the previous bookmark.
- **Shift+Right**: Navigate to the next bookmark.
- **Shift+B**: Remove the closest bookmark within `cleanup_threshold` seconds of the current playback position. If there's no bookmark within that range, an OSD message will be displayed stating that no bookmarks were found within the threshold.

## License

This project is released under the [MIT License](LICENSE.md)
