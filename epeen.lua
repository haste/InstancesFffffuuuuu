local db
local messages
local frame = CreateFrame"Frame"

-- Block the default messages:
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(self, event, msg)
	if(msg == TRANSFER_ABORT_TOO_MANY_REALM_INSTANCES) then
		return true
	end
end)

function frame:ADDON_LOADED(event, addon)
	if(addon == "InstancesFffffuuuuu") then
		db = InstancesFffffuuuuuDB or {}
		InstancesFffffuuuuuDB = db

		-- Suddenly Znat appears, with custom messages!
		messages = {
			[100] = "Grats on still trying, that's 100 instances aborted!",
			[200] = "Still going strong, eh?",
			[300] = "Ok, might be time to do something else.",
			[400] = "Dude, life. You has none!",
			[500] = "BOT?! WHAT ARE YOU!?",
			[600] = "You do realize its now 600 times you've tried?",
			[700] = "You still dont get it do you?",
			[800] = "Man, give up already.",
			[900] = "Something tells me you wont get into the instance",
			[1000] = "Really? 1000 times? Go try get " .. GetAchievementLink(2336) .. " instead!"
		}

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
			UIErrorsFrame:AddMessage(string.format("%d instance launches aborted!", c))
		end

		db[t] = c
	end
end

frame:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

frame:RegisterEvent"ADDON_LOADED"

SLASH_INSTANCE_FU1 = '/fu'
SLASH_INSTANCE_FU2 = '/ins'

SlashCmdList['INSTANCE_FU'] = function()
	local type = ChatFrameEditBox:GetAttribute"chatType"
	local count = db[date"%y%m%d"]
	if(count) then
		local text = string.format("I've tried to enter %d instances today, but the instance server was too busy >:'(", count)
		if(type == "WHISPER") then
			SendChatMessage(text, type, nil, ChatFrameEditBox:GetAttribute"tellTarget")
		elseif ( type == "CHANNEL") then
			SendChatMessage(text, type, nil, ChatFrameEditBox:GetAttribute"channelTarget")
		else
			SendChatMessage(text, type)
		end
	end
end

