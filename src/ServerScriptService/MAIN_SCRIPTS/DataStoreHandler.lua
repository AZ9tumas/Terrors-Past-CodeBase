local module = {}

module.Links = {}

local DataStore2 = require(script.Parent:WaitForChild("DataStore2"))

--[[
	* Combine all these keys (basically elements of the table) into a single key.
	* This is useful because if we want to access only one element, the others aren't loaded in.
]]

local keys = {"Points", "isBanned", "Selection", "Carnivores", "Herbivores", "Omnivores", "Pterosaurs", "Settings"}

-- Combine keys
for _, v in pairs(keys) do DataStore2.Combine("Total", v) end

function module:LinkPlayer(Player : Player)
	if module.Links[Player.UserId] then return end
	
	local linked = {}
	for _, v in pairs(keys) do linked[v] = module:MakeDatastoreObject(Player, v) end
	
	linked["Total"] = module:MakeDatastoreObject(Player, "Total")
	module.Links[Player.UserId] = linked
	
end

function module:GetDatastoreFromPlayer(Player : Player, key)
	if not module.Links[Player.UserId] then return warn("No datastore object found for player " .. Player.Name) end
	-- Return store with the specified key or "Total" which has all other keys under it
	return module.Links[Player.UserId][key or "Total"]
end

function module:RemoveLink(Player : Player)
	module.Links[Player.UserId] = nil
	
	--warn("Datastore for ["..Player.Name.."] has been removed.")
end

function module:MakeDatastoreObject(Player : Player, key, attempts)
	if not key then warn("Connection to datastores for Player "..Player.Name.." is disabled due to an invalid key.") end
	
	local store = DataStore2(key, Player) -- key = datastoresService:GetDatastore(key) when using standard.
	store:SetBackup(attempts or 5)
	
	return store
end

function module:GetData(Player : Player, key : string, defaultVal : any)
	local obj = module:GetDatastoreFromPlayer(Player, key)
	if obj then return obj:Get(defaultVal) end
end

function module:SetData(Player : Player, key : string, newValue : any, saveData : any)
	local obj = module:GetDatastoreFromPlayer(Player, key)
	
	obj:Set(newValue)
	
	if saveData then
		--error("Attempt to save data.", 3)
		obj:SaveAsync()
	end
end

function module:IncrementData(Player : Player, key : string, incr_amount : number)
	local obj = module:GetDatastoreFromPlayer(Player, key)
	if obj then
		obj:Increment(incr_amount)
	end
end

return module