
--[[
    Description on progressions ::

    once you select a branch, you continue along till you reach the end

    if you reach the end, you can go back to a different branch, but all your progress is lost on the dinosaurs on 
    the previous branch  (you still have them UNLOCKED, but you have to start over [ as a baby] again [essentially, 
    if you complete the game, it basically becomes a sandbox, you just have to regrow everything])

    you can switch off the branch anytime, but lets make it so if you dont reach the END of the branch, 
    your ENTIRE progress is lost. 
    ---------------------
    so if you complete a branch and switch = ALL progression progress is SAVED, you have the dinosaurs unlocked, 
    you just have to start as a baby and earn NO points from doing it

    if you dont complete a branch and switch = all progression progress is LOST and if you want to go back to it, 
    you have to start all the way over
    -----------------------

    each dinosaur requires the adult of the last, # of points, and a SPECIFIC task to unlock that creature
]]

-- Create the DinosaurPurchase module
local DinosaurPurchase = {}

-- Get the required services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local BuyFunction : RemoteFunction = Remotes:WaitForChild("Buy")
local RedoLocks : RemoteEvent = Remotes:WaitForChild("RedoLocks")

-- Bindables
local Bindables = ReplicatedStorage:WaitForChild("Bindable")
local Get : BindableFunction = Bindables:WaitForChild("Get")
local Set : BindableEvent = Bindables:WaitForChild("Set")

-- Import the DinosaurService module
local m_DinosaurService = require(script.Parent.Parent.Dinosaur)
local m_DinosaurUtilHandler = require(ReplicatedStorage.DinosaurStatsUtilityModule)
local m_DinosaurDivisions = require(ReplicatedStorage.DinosaurDivisions)

-- Function to check the validity of purchasing a dinosaur
function DinosaurPurchase.CheckValidity(Player : Player, DinosaurName : string)
    -- Check if the player is worthy of buying this dinosaur

    -- Get the cost of this dinosaur
    local points = m_DinosaurUtilHandler.getDinosaurCost(DinosaurName)

    -- Check if points exist for the dinosaur, otherwise kick the player
    if not points then
        return false, "Invalid Purchase ID."
    end

    if Player.leaderstats.Points.Value < points then return false, "Insufficient amount of progression points." end

    -- Check if the player has the adult form of the previous dinosaur
    local previousDinosaurName = m_DinosaurDivisions.GetBranchingDinosaur(DinosaurName)
    local GrowthStatus = m_DinosaurDivisions.GetGrowthStage(Player, previousDinosaurName)

    --print("Growth Status of previous dinosaur:", GrowthStatus, previousDinosaurName)

    if GrowthStatus ~= "Adult" then return false, previousDinosaurName .. " must be in it's adult form (fully grown)." end

    -- Return true if the player is allowed to buy the dinosaur
    return points, "Successfully purchased the dinosaur."
end

function DinosaurPurchase.CheckOwnershipStatus(Player : Player, DinosaurName : string)
    local dinosaurType = m_DinosaurUtilHandler.getDinosaurType(DinosaurName)
    local indexes = Player:GetAttribute(dinosaurType) -- Get:Invoke(Player, dinosaurType, "b1")
    local dinosaursOwned = m_DinosaurDivisions.GetDinosaursFromIndexes(dinosaurType, indexes)

    return table.find(dinosaursOwned, DinosaurName), indexes
end

-- Function to buy a dinosaur for a player
function DinosaurPurchase.BuyDinosaur(Player: Player, DinosaurName : string) : string
    -- Print the purchase status based on the validity check
    local PurchaseStatus, Message = DinosaurPurchase.CheckValidity(Player, DinosaurName)
    if not PurchaseStatus then return PurchaseStatus, Message end

    local DinosaurType = m_DinosaurUtilHandler.getDinosaurType(DinosaurName)
    local DinosaurId = m_DinosaurDivisions.GetIndex(DinosaurName)

    -- charge the player
    -- cost = purchaseStatus

    Player.leaderstats.Points.Value -= PurchaseStatus
    -- add the dinosaur

    local alreadyOwned, indexes = DinosaurPurchase.CheckOwnershipStatus(Player, DinosaurName)
    if alreadyOwned then return false, "You already own this dinosaur" end

    local newIndex = m_DinosaurDivisions.GetIndex(DinosaurName)
    -- add the new dinosaur
    indexes ..= '-b' .. newIndex
    Set:Fire(Player, DinosaurType, indexes, true)

    -- set the attribute
    Player:SetAttribute(DinosaurType, indexes)

    RedoLocks:FireClient(Player)
    
    return true, "Rich Kid eh??"
end

-- Return the DinosaurPurchase module
return DinosaurPurchase
