-- Create the animationRemote module
local animationRemote = {}

-- Import the DinosaurService module
local DinosaurService = require(script.Parent.Parent.Dinosaur)

-- Function to load animations for a player
function animationRemote.Load(Player : Player)
    -- Retrieve the animations for the player's dinosaur
    local animations = DinosaurService.GetAnimationsFromPlayer(Player)

    -- Find or create the AnimationsFolder in the player's character
    local animFolder : Folder = Player.Character:FindFirstChild("AnimationsFolder") or Instance.new("Folder", Player.Character)
    animFolder.Name = "AnimationsFolder"
    animFolder:ClearAllChildren()

    -- Iterate over the animations and create Animation instances
    for animName : string, animId : string in pairs(animations) do
        local new = Instance.new("Animation", animFolder)
        new.Name = animName
        new.AnimationId = "rbxassetid://" .. animId
    end

    -- Return true to indicate successful loading of animations
    return animFolder
end

-- Return the animationRemote module
return animationRemote
