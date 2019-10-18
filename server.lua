-- Warning labels
local firstWarning = "SERVER RESTART IN 15 MINUTES!"
local secondWarning = "SERVER RESTART IN 10 MINUTES!"
local thirdWarning = "SERVER RESTART IN 5 MINUTES!"
local finalWarning = "SERVER RESTARTING IN 30 SECONDS, RUN YOU FOOLS!"

RegisterServerEvent("autoRestart:checkTime")

AddEventHandler('autoRestart:checkTime', function()
	-- Get system time
	checkTime = os.date('%H:%M:%S', os.time())
	local serverTime = checkTime

	-- 6am warnings
	if serverTime == '05:45:00' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, firstWarning)
	elseif serverTime == '05:50:00' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, secondWarning)
	elseif serverTime == '05:55:00' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, thirdWarning)
	elseif serverTime == '05:59:30' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, finalWarning)
	
	-- 6pm warnings
	elseif serverTime == '17:45:00' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, firstWarning)
	elseif serverTime == '17:50:00' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, secondWarning)
	elseif serverTime == '17:55:00' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, thirdWarning)
	elseif serverTime == '17:59:30' then
		TriggerClientEvent('chatMessage', -1, "SYSTEM ", {255, 0, 0}, finalWarning)
	
	end
end)

-- Check the time every second
function restart_server()
	SetTimeout(1000, function()
		TriggerEvent('autoRestart:checkTime')
		restart_server()
	end)
end
restart_server()
