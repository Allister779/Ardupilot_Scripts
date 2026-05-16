-- Loiter Radius Control with Transmitter Knob
-- Map a knob (e.g., RC6) to adjust WP_LOITER_RAD
-- This scirpt could be used for any parameter that you would want to change in flight with a pot or slider.
-- Only the parameter name and the values would need changing.

local MAV_SEVERITY_EMERGENCY = 0
local MAV_SEVERITY_ALERT     = 1
local MAV_SEVERITY_CRITICAL	 = 2
local MAV_SEVERITY_ERROR     = 3
local MAV_SEVERITY_WARNING   = 4
local MAV_SEVERITY_NOTICE    = 5
local MAV_SEVERITY_INFO      = 6
local MAV_SEVERITY_DEBUG     = 7

local SCRIPT_NAME = 'Loiter Radius'


-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- create and initialise parameters
local PARAM_TABLE_KEY = 75          -- parameter table key must be used by only one script on a particular flight controller
assert(param:add_table(PARAM_TABLE_KEY, "WPLR_", 3), 'could not add param table')
assert(param:add_param(PARAM_TABLE_KEY, 1, 'MIN_RADIUS', 90), 'could not add WPLR_MIN_RADIUS param')     -- 
assert(param:add_param(PARAM_TABLE_KEY, 2, 'MAX_RADIUS', 300), 'could not add WPLR_MAX_RADIUS param')     --
assert(param:add_param(PARAM_TABLE_KEY, 3, 'RADIUS_DZ', 2), 'could not add WPLR_RADIUS_DZ param')      -- 


-- bind parameters to variables
local min_radius = Parameter("WPLR_MIN_RADIUS")
local max_radius = Parameter("WPLR_MAX_RADIUS")
local radius_dz  = Parameter("WPLR_RADIUS_DZ") -- Min change in M for the script to act on.

local RC_OPTION  = 300  -- RC channel for the knob (e.g., 6 for RC6)

-- setup/initialization logic
local rc_chan = rc:find_channel_for_option(RC_OPTION)
local last_radius = param:get('WP_LOITER_RAD')


function update()
    if rc_chan then
       knob_val = rc_chan:norm_input()

    else 
        gcs_msg(MAV_SEVERITY_ERROR, 'No RC input')
        return update, 1000
    end
    
    local min_r = min_radius:get()
    local max_r = max_radius:get()
    local rad_dz = radius_dz:get()

-- Map PWM (typically 1000-2000) to radius range
    local mid_radius = (min_r/2)+(max_r/2)
    local new_radius = mid_radius + ((max_r-min_r)/2)*knob_val

-- Only update parameter if changed to prevent unnecessary writes
    if math.abs(new_radius - last_radius) > rad_dz then
    param:set('WP_LOITER_RAD', new_radius)
    last_radius = new_radius
    gcs_msg(MAV_SEVERITY_INFO, string.format(' %s meters', new_radius))
    end

    return update, 1000 
end

gcs_msg(MAV_SEVERITY_INFO, ' Script Loaded')
return update()
