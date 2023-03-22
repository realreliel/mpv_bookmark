# mpv_bookmark

mpv_bookmark is a Lua script for the MPV media player that allows you to easily add, remove, and navigate between bookmarks during video playback.

## Features

- Add a bookmark 7 seconds before the current playback position
- Navigate between bookmarks using keyboard shortcuts
- Remove a bookmark within 20 seconds of the current playback position

## Installation

1. Save the Lua script as `mpv_bookmarks.lua`.
2. Place the `mpv_bookmarks.lua` file in your MPV scripts directory.
   - For Linux: `~/.config/mpv/scripts/`
   - For Windows: `%APPDATA%\mpv\scripts\`

## Usage

The script provides the following keyboard shortcuts:

- **b**: Add a bookmark 7 seconds before the current playback position. If the resulting time is negative, the bookmark will be set to the beginning of the video (0 seconds).
- **Shift+Left**: Navigate to the previous bookmark.
- **Shift+Right**: Navigate to the next bookmark.
- **Shift+B**: Remove the closest bookmark within 20 seconds of the current playback position. If there's no bookmark within that range, an OSD message will be displayed stating that no bookmarks were found within 20 seconds.
