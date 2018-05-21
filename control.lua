require 'config'
require 'utils.utils'
require 'utils.list_utils'
require 'user_groups'
require 'custom_commands'
require 'base_data'
require 'train_station_names'
require 'nuke_control'
require 'walk_distance'
require 'follow'
require 'autodeconstruct'
require 'corpse_util'
require 'fish_market'
require 'reactor_meltdown'
require 'map_layout'
require 'bot'

-- GUIs the order determines the order they appear at the top.
require 'info'
require 'player_list'
require 'poll'
require 'band'
require 'tasklist'
require 'blueprint_helper'
require 'score'

local Event = require 'utils.event'

local function player_joined(event)
    local player = game.players[event.player_index]
    player.insert {name = 'raw-fish', count = 4}
    player.insert {name = 'iron-gear-wheel', count = 8}
    player.insert {name = 'iron-plate', count = 16}
    player.print('Welcome to our Server. You can join our Discord at: redmew.com/discord')
    player.print('And remember.. Keep Calm And Spaghetti!')
end

function walkabout(player_name, distance)
    game.player.print('This command moved to /walkabout.')
end

local hodor_messages = {
    {'Hodor.', 16},
    {'Hodor?', 16},
    {'Hodor!', 16},
    {'Hodor! Hodor! Hodor! Hodor!', 4},
    {'Hodor :(', 4},
    {'Hodor :)', 4},
    {'HOOOODOOOR!', 4},
    {'( ͡° ͜ʖ ͡°)', 1},
    {'☉ ‿ ⚆', 1}
}
local message_weight_sum = 0
for _, w in pairs(hodor_messages) do
    message_weight_sum = message_weight_sum + w[2]
end

function hodor(event)
    local message = event.message:lower()
    if message:match('hodor') then
        local index = math.random(1, message_weight_sum)
        local message_weight_sum = 0
        for _, m in pairs(hodor_messages) do
            message_weight_sum = message_weight_sum + m[2]
            if message_weight_sum >= index then
                game.print('Hodor: ' .. m[1])
                return
            end
        end
    end
    if message:match('discord') then
        if game.player then
            game.player.print('Did you ask about our discord server?')
            game.player.print('You can find it here: redmew/discord')
        end
    end
end

Event.add(defines.events.on_player_created, player_joined)
Event.add(defines.events.on_console_chat, hodor)

Event.add(
    defines.events.on_player_joined_game,
    function(event)
        local gui = game.players[event.player_index].gui

        gui.top.style = 'slot_table_spacing_horizontal_flow'
        gui.left.style = 'slot_table_spacing_vertical_flow'
    end
)
