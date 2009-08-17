local db
local frame = CreateFrame"Frame"

-- Suddenly Znat appears, with custom messages!
local messages = {
	[100] = "Grats on still trying, that's 100 instances aborted!",
	[200] = "Still going strong, eh?",
	[300] = "Ok, might be time to do something else.",
	[400] = "Dude, life. You has none!",
	[500] = "BOT?! WHAT ARE YOU!?"
}

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
		local c = db[t] or 0
		c = c + 1

		if(messages[c]) then
			UIErrorsFrame:AddMessage(string.format(messages[c], c))
		else
			UIErrorsFrame:AddMessage(string.format("%d aborted instances!", c))
		end

		db[t] = c
	end
end

frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

frame:RegisterEvent"ADDON_LOADED"
