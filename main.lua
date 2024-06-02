local logging = require("logging")
local logger = logging.getLogger("deselect-all")
local console = require("console")

local deselect_all_timer = 0;
local original_create_UIBox_buttons = nil;

local function on_enable()
	original_create_UIBox_buttons = create_UIBox_buttons
	
	function create_UIBox_buttons()
		local text_scale = 0.45
		local button_height = 1.3
	
		local deselect_button_text = {
			n=G.UIT.T, 
			config={
				text = "Deselect", 
				scale = text_scale, 
				colour = G.C.UI.TEXT_LIGHT,
				func = 'set_button_pip'
			}
		}
	
		local deselect_button = {
			n=G.UIT.C, 
			config={
				id = 'deselect_button', 
				align = "tm", 
				minw = 2.5,
				padding = 0.3, 
				r = 0.1, 
				hover = true, 
				colour = G.C.ORANGE, 
				button = "deselect_all_highlighted", 
				shadow = true,
				func = "deselect_all_some_highlighted",
				deselect_button_text = deselect_button_text
			}, 
			nodes={
				  {
					n=G.UIT.R, 
					config={
						align = "bcm", 
						padding = 0
					}, 
					nodes={
						deselect_button_text
					  }
				},
			}
		}
	
		local t = original_create_UIBox_buttons()
	
		table.insert(t.nodes, deselect_button)
	
		return t
	end

	original_create_UIBox_arcana_pack = create_UIBox_arcana_pack

	function create_UIBox_arcana_pack()
		local deselect_button_text = {
			n=G.UIT.T, 
			config={
				text = "Deselect", 
				scale = 0.5, 
				colour = G.C.WHITE, 
				shadow = true, 
				func = 'set_button_pip'
			}
		}

		local deselect_button = {
			n=G.UIT.C,
			config={
				align = "tm", 
				padding = 0.05, 
				minw = 2.4
			}, 
			nodes={
				{
					n=G.UIT.R,
					config={minh=0.2}, 
					nodes={}
				},
				{
					n=G.UIT.R,
					config={
						align = "tr",
						padding = 0.2, 
						minh = 1.2, 
						minw = 1.8, 
						r=0.15,
						colour = G.C.ORANGE, 
						button = 'deselect_all_highlighted', 
						hover = true,
						shadow = true, 
						func = 'deselect_all_some_highlighted',
						deselect_button_text = deselect_button_text
					}, 
					nodes = {
						deselect_button_text
					}
				}
			}
		}

		local t = original_create_UIBox_arcana_pack()

		t.nodes[1].nodes[3].nodes[1] = deselect_button

		return t
	end

	original_create_UIBox_spectral_pack = create_UIBox_spectral_pack

	function create_UIBox_spectral_pack()
		local deselect_button_text = {
			n=G.UIT.T, 
			config={
				text = "Deselect", 
				scale = 0.5, 
				colour = G.C.WHITE, 
				shadow = true, 
				func = 'set_button_pip'
			}
		}

		local deselect_button = {
			n=G.UIT.C,
			config={
				align = "tm", 
				padding = 0.05, 
				minw = 2.4
			}, 
			nodes={
				{
					n=G.UIT.R,
					config={minh=0.2}, 
					nodes={}
				},
				{
					n=G.UIT.R,
					config={
						align = "tr",
						padding = 0.2, 
						minh = 1.2, 
						minw = 1.8, 
						r=0.15,
						colour = G.C.ORANGE, 
						button = 'deselect_all_highlighted', 
						hover = true,
						shadow = true, 
						func = 'deselect_all_some_highlighted',
						deselect_button_text = deselect_button_text
					}, 
					nodes = {
						deselect_button_text
					}
				}
			}
		}

		local t = original_create_UIBox_spectral_pack()

		t.nodes[1].nodes[3].nodes[1] = deselect_button

		return t
	end

	G.FUNCS.deselect_all_some_highlighted = function(e)
		if #G.hand.highlighted > 0 then
			e.config.colour = G.C.ORANGE
			e.config.button = 'deselect_all_highlighted'
			e.config.deselect_button_text.config.colour = G.C.UI.TEXT_LIGHT
		elseif deselect_all_timer > 0 then
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = '' -- Needs to be done to get button back into normal state
			deselect_all_timer = deselect_all_timer - 1
		else
			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			e.config.button = nil
		end
	end
	
	G.FUNCS.deselect_all_highlighted = function(e)
		deselect_all_timer = 7
		G.hand:unhighlight_all()
		e.config.deselect_button_text.config.colour = G.C.UI.TEXT_DARK
	end

	console:registerCommand(
		'deselect', 
		function(args)
			G.hand:unhighlight_all()
		end,
		"Deselect all highlighted playing cards.",
		function(current_arg, previous_arg)
			return nil
		end,
		"Usage: deselect"
	)
end

local function on_disable()
	G.FUNCS.deselect_all_highlighted = nil
	G.FUNCS.deselect_all_some_highlighted = nil
	create_UIBox_buttons = original_create_UIBox_buttons
	create_UIBox_arcana_pack = original_create_UIBox_arcana_pack
	create_UIBox_spectral_pack = original_create_UIBox_spectral_pack

	console.removeCommand('booster')
end

local function menu()
end

local function on_game_load(args)
end

local function on_game_quit()
end

local function on_key_pressed(key)
end

local function on_key_released(key)
end

local function on_mouse_pressed(button, x, y, touch)
end

local function on_mouse_released(button, x, y)
end

local function on_mousewheel(x, y)
end

local function on_pre_render()
end

local function on_post_render()
end

local function on_error(message)
end

local function on_pre_update(dt)
end

local function on_post_update(dt)
end

return {
    on_enable = on_enable,
    on_disable = on_disable,
    menu = menu,
    on_game_load = on_game_load,
    on_game_quit = on_game_quit,
    on_key_pressed = on_key_pressed,
    on_key_released = on_key_released,
    on_mouse_pressed = on_mouse_pressed,
    on_mouse_released = on_mouse_released,
    on_mousewheel = on_mousewheel,
    on_pre_render = on_pre_render,
    on_post_render = on_post_render,
    on_error = on_error,
    on_pre_update = on_pre_update,
    on_post_update = on_post_update,
}