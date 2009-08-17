local db
local frame = CreateFrame"Frame"

function frame:ADDON_LOADED(event, addon)
	if(addon == "InstancesFffffuuuuu") then
		db = InstancesFffffuuuuuDB or {}
		InstancesFffffuuuuuDB = db

		self:RegisterEvent"CHAT_MSG_SYSTEM"
		self:UnregisterEvent"ADDON_LOADED"
	end
end

function frame:CHAT_MSG_SYSTEM(event, msg)
	if(msg == TRANSFER_ABORT_TOO_MANY_REALM_INSTANCES) then
		local t = date"%y%m%d"
		if(not db[t]) then
			db[t] = 0
		end

		db[t] = db[t] + 1
		UIErrorsFrame:AddMessage(string.format("%d and counting!", db[t]))
	end
end

frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

frame:RegisterEvent"ADDON_LOADED"
