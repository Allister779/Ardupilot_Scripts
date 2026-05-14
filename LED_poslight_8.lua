--[[
 Script to use LED strips as position lights.

--]]
local num_leds = 8
local timer = 0

-- Brightness for green or red light.
local br_color = 255

 -- Brightness for flash light when armed.
local br_flash = 255

-- brighthness for disarmed
local br_disarm = 128

--[[
 Use SERVOn_FUNCTION 94 for aft LED strip 

--]]
local chan_aft = assert(SRV_Channels:find_channel(94),"LEDs aft: channel not set")


-- find_channel returns 0 to 15, convert to 1 to 16
chan_aft = chan_aft + 1
--chan_right = chan_right + 1

gcs:send_text(6, "LEDs strip aft: chan=" .. tostring(chan_aft))
--gcs:send_text(6, "LEDs strip right: chan=" .. tostring(chan_right))

-- initialisation code
assert(serialLED:set_num_neopixel(chan_aft, num_leds),"Failed aft LED setup")


function update_LEDs()

  -- If the pre_arm_checks have failed then cycle a blue light 
  if not arming:pre_arm_checks() then
    if (timer ==0) then
      serialLED:set_RGB(chan_aft, 0, br_disarm,0, 0)
    elseif (timer ==1) then
      serialLED:set_RGB(chan_aft, 1, br_disarm,0, 0)
    elseif (timer ==2) then
      serialLED:set_RGB(chan_aft, 2, br_disarm,0, 0)
    elseif (timer ==3) then
      serialLED:set_RGB(chan_aft, 3, br_disarm,0, 0)
    elseif (timer ==4) then
      serialLED:set_RGB(chan_aft, 4, br_disarm,0, 0)
    elseif (timer ==5) then
      serialLED:set_RGB(chan_aft, 5, br_disarm,0, 0)
    elseif (timer ==6) then
      serialLED:set_RGB(chan_aft, 6, br_disarm,0, 0)
    elseif (timer ==7) then
      serialLED:set_RGB(chan_aft, 7, br_flash,0, 0)
    elseif (timer ==8) then
      serialLED:set_RGB(chan_aft, 6, br_disarm,0, 0)
    elseif (timer ==9) then
      serialLED:set_RGB(chan_aft, 5, br_disarm,0, 0)
    elseif (timer ==10) then
      serialLED:set_RGB(chan_aft, 4, br_disarm,0, 0)
    elseif (timer ==11) then
      serialLED:set_RGB(chan_aft, 3, br_disarm,0, 0)
    elseif (timer ==12) then
      serialLED:set_RGB(chan_aft, 2, br_disarm,0, 0)
    elseif (timer ==13) then
      serialLED:set_RGB(chan_aft, 1, br_disarm,0, 0)
    elseif (timer ==14) then
      serialLED:set_RGB(chan_aft, 0, br_disarm,0, 0)
    elseif (timer ==15) then
      serialLED:set_RGB(chan_aft, -1, 0, 0, 0)

    end
    timer = timer + 1
    if timer > 20 then
      timer = 0
    end
    serialLED:send(chan_aft)
    return update_LEDs, 100 -- run at 10Hz
  end

-- if the quad is armed set the red and green lights with a pulsed strobe accross all lights

  if arming:is_armed() then

  -- use the following if for testing only
    --if not arming:is_armed() then

    if (timer == 0) then
      serialLED:set_RGB(chan_aft, -1, br_flash, br_flash, br_flash)


    elseif (timer == 1) then
      serialLED:set_RGB(chan_aft, 4, br_color, 0, 0) 
      serialLED:set_RGB(chan_aft, 5, br_color, 0, 0)     
      serialLED:set_RGB(chan_aft, 6, br_color, 0, 0)
      serialLED:set_RGB(chan_aft, 7, br_color, 0, 0)
      serialLED:set_RGB(chan_aft, 0, 0, br_color, 0)
      serialLED:set_RGB(chan_aft, 1, 0, br_color, 0)
      serialLED:set_RGB(chan_aft, 2, 0, br_color, 0)
      serialLED:set_RGB(chan_aft, 3, 0, br_color, 0)

    elseif (timer == 2) then
      serialLED:set_RGB(chan_aft, -1, br_flash, br_flash, br_flash)

    elseif (timer == 3) then
      serialLED:set_RGB(chan_aft, -1, 0, 0, 0)

    elseif (timer == 4) then
      serialLED:set_RGB(chan_aft, -1, br_flash, br_flash, br_flash)

    elseif (timer == 5) then
      serialLED:set_RGB(chan_aft, 4, br_color, 0, 0) 
      serialLED:set_RGB(chan_aft, 5, br_color, 0, 0)     
      serialLED:set_RGB(chan_aft, 6, br_color, 0, 0)
      serialLED:set_RGB(chan_aft, 7, br_color, 0, 0)
      serialLED:set_RGB(chan_aft, 0, 0, br_color, 0)
      serialLED:set_RGB(chan_aft, 1, 0, br_color, 0)
      serialLED:set_RGB(chan_aft, 2, 0, br_color, 0)
      serialLED:set_RGB(chan_aft, 3, 0, br_color, 0)
    end
    timer = timer + 1
    if (timer > 10) then
      timer = 0
    end

  -- if the quad isn't armed set the red and green lights and only pulse the center two lights.
  else
    if (timer == 0) then
      serialLED:set_RGB(chan_aft, 4, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 5, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 6, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 7, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 0, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 1, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 2, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 3, br_flash, br_flash, br_flash)
    elseif (timer == 1) then
      serialLED:set_RGB(chan_aft, 4, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 5, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 6, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 7, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 0, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 1, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 2, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 3, 0, br_disarm, 0)
    elseif (timer == 2) then
      serialLED:set_RGB(chan_aft, 4, br_flash, br_flash, br_flash)
      serialLED:set_RGB(chan_aft, 5, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 6, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 7, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 0, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 1, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 2, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 3, 0, br_disarm, 0)
    elseif (timer == 3) then
      serialLED:set_RGB(chan_aft, 4, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 5, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 6, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 7, br_disarm, 0, 0)
      serialLED:set_RGB(chan_aft, 0, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 1, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 2, 0, br_disarm, 0)
      serialLED:set_RGB(chan_aft, 3, 0, br_disarm, 0)
    end

    timer = timer + 1
    if (timer > 10) then
      timer = 0
    end
  end
  serialLED:send(chan_aft)

  return update_LEDs, 100 -- run at 10Hz
end

return update_LEDs()
