
local module = {}

local ServerScriptService = game:GetService("ServerScriptService")
local dinoScripts : Folder =  ServerScriptService:WaitForChild("Dinosaurs")

function rangeMid(x, y, z)
    return math.min(math.max(x, y), z)
end

function module:Increment(Player : Player)
        -- increment / decrement stamina
    if script:FindFirstChild(Player.Name) then return end
    if not Player.Character then return end

    local Humanoid : Humanoid = Player.Character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    local StaminaValue : NumberValue = Player:FindFirstChild("Stamina")
    if not StaminaValue then return end

    local HungerValue : NumberValue = Player:FindFirstChild("Hunger")
    if not HungerValue then return end

    local dinosaurName = Player:GetAttribute("Dinosaur")
    if not dinosaurName then return end

    local pos = Player:GetAttribute("p")
    if not pos then return end

    local dinosaurType = Player:GetAttribute("Type")
    local growthStatus = Player:GetAttribute("Growth")

    local statsScripts = dinoScripts:FindFirstChild(dinosaurType)
    if not statsScripts then return end

    local statsScript = statsScripts:FindFirstChild(dinosaurName)
    if not statsScript then return end
    statsScript = require(statsScript)

    local allstats = statsScript.Stats[growthStatus]

    local dinostats = {
        [0] = allstats["WalkIncrement"],
        allstats["CrouchIncrement"],
        allstats["RunDecrement"],
        allstats["DashDecrement"]
    }
    
    local maxStamina = allstats["Stamina"]
    local maxHunger = allstats["Hunger"]

    local Stamina : number = StaminaValue.Value * maxStamina
    local Hunger : number = HungerValue.Value * maxHunger
    local Increment = Humanoid.MoveDirection.Magnitude > 0 and dinostats[pos] or allstats["StandIncrement"]
    
    StaminaValue.Value = rangeMid(0, Stamina + Increment, maxStamina) / maxStamina
    
    local hungerDecrement = allstats["HungerDecrement"] or -0.2
    HungerValue.Value = rangeMid(0, Hunger + hungerDecrement, maxHunger) / maxHunger
end

return module