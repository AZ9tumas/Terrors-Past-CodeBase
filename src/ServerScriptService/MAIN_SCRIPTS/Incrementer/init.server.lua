
local Players = game:GetService("Players")

-- Other Modules
local m_Incrementer = require(script:WaitForChild("IncrementHandler"))
local m_Growth = require(script:WaitForChild("GrowthIncrementer"))

while wait(1) do
    for _, Player : Player in pairs(Players:GetPlayers()) do
        if not Player:GetAttribute("Loaded") then continue end
        m_Incrementer:Increment(Player)
        m_Growth.HandleGrowth(Player)
    end
end