local mp = require 'mp'
local mpopt = require('mp.options')
local utils = require 'mp.utils'

local bookmarks = {}
local bookmark_id = 1

-- Override values here at path-to-mpv/script-opts/mpv_bookmark.conf or ~/.config/mpv/script-opts/mpv_bookmark.conf
local config = {
    leadin_threshold = 7, -- how far back to create the bookmark at in seconds
    cleanup_threshold = 20, -- how far to search when deleting a bookmark in seconds
    pause_after_jump = false -- whether or not to pause the video after jumping to the bookmark
}

-- Add a bookmark at the current playback position minus config.leadin_threshold seconds
local function add_bookmark()
    local current_time = mp.get_property_number("time-pos") - config.leadin_threshold
    if current_time < 0 then
        current_time = 0
    end
    table.insert(bookmarks, {id = bookmark_id, time = current_time})
    bookmark_id = bookmark_id + 1
    mp.osd_message("Bookmark added at: " .. current_time .. "s")
end

-- Remove a bookmark if within config.cleanup_threshold seconds of the current playback position
local function remove_bookmark()
    local current_time = mp.get_property_number("time-pos")
    for index, bookmark in ipairs(bookmarks) do
        if math.abs(bookmark.time - current_time) <= config.cleanup_threshold then
            table.remove(bookmarks, index)
            mp.osd_message("Bookmark " .. bookmark.id .. " removed")
            return
        end
    end
    mp.osd_message("No bookmarks found within " .. config.cleanup_threshold .. " seconds")
end

-- Navigate between bookmarks
local function navigate_bookmarks(direction)
    local current_time = mp.get_property_number("time-pos")
    local nearest_bookmark
    local min_difference = math.huge
    local time_threshold = 0.5 -- Add a time threshold for comparing the current time with bookmark time

    if #bookmarks == 0 then
        mp.osd_message("No bookmarks found")
        return
    end

    for _, bookmark in ipairs(bookmarks) do
        local time_difference = bookmark.time - current_time
        if direction == "forward" and time_difference > time_threshold and time_difference < min_difference then
            nearest_bookmark = bookmark
            min_difference = time_difference
        elseif direction == "backward" and time_difference < -time_threshold and math.abs(time_difference) < min_difference then
            nearest_bookmark = bookmark
            min_difference = math.abs(time_difference)
        end
    end

    if nearest_bookmark then
        mp.set_property_number("time-pos", nearest_bookmark.time)
        mp.osd_message("Jumped to bookmark: " .. nearest_bookmark.id)
        if config.pause_after_jump then
            mp.set_property("pause", "yes")
        end
    else
        mp.osd_message("No bookmarks found in the desired direction")
    end
end


mpopt.read_options(config, 'mpv_bookmark')
mp.add_key_binding("b", "add_bookmark", add_bookmark)
mp.add_key_binding("Shift+b", "remove_bookmark", remove_bookmark)
mp.add_key_binding("Shift+LEFT", "navigate_backward", function() navigate_bookmarks("backward") end)
mp.add_key_binding("Shift+RIGHT", "navigate_forward", function() navigate_bookmarks("forward") end)
