
--[[/***************************************************************************************
 *                                                                                     
 *                               [Sound Handler]                                      
 *                                                                                     
 *  [Author(s)]: @AZ9tumas (Senior Programmer)                                                      
 *  [Version]: v1.0                                                         
 *  [Date]: June 29th, 2023                                                              
 *                                                                                     
 *  IMPORTANT: This software is proprietary and is available only through               
 *  purchase from the owner of the software.                                            
 *                                                                                     
 *  License Agreement:                                                                  
 *                                                                                     
 *  1. Usage Restrictions:                                                              
 *     This software is licensed for use by Fossil Studioz exclusively. It may not be    
 *     distributed, sublicensed, or used by any other organization or individual.        
 *                                                                                     
 *  2. Permitted Usage:                                                                 
 *     Fossil Studioz is granted a non-exclusive, non-transferable license to use       
 *     this software within their organization for internal purposes only.              
 *                                                                                     
 *  3. No Modification or Reverse Engineering:                                          
 *     Fossil Studioz may not modify, decompile, reverse engineer, or disassemble       
 *     this software in any way.                                                        
 *                                                                                     
 *  4. Support and Upgrades:                                                            
 *     The owner of the software may provide technical support and upgrades              
 *     for the software within the terms agreed upon between the parties.               
 *                                                                                     
 *  5. Ownership:                                                                       
 *     Fossil Studioz acknowledges that the ownership of this software remains          
 *     with the author(s) or the owner of the software.                                  
 *                                                                                     
 *  6. Warranty Disclaimer:                                                             
 *     This software is provided "as is" without any warranty, express or implied.      
 *     The author(s) or the owner of the software shall not be liable for any damages,  
 *     including but not limited to, direct, indirect, incidental, or consequential    
 *     damages arising out of the use or inability to use this software.                
 *                                                                                     
 *  By using this software, Fossil Studioz agrees to be bound by the terms and          
 *  conditions of this license agreement.                                               
 *                                                                                     
 *  For inquiries or further information regarding this software, please contact us at:       
 *  Website: https://www.roblox.com/groups/5296318/Fossil-Studioz#!/about                                                               
 *                                                                                     
 ***************************************************************************************/

    [MODULE STRUCTURE]

    Description:
    This module provides functions for loading sounds and playing specific sounds in a game. It utilizes the SoundService to handle sound playback.

    Functions:
    - LoadSounds(): Loads all the sounds under the script and prepares the functions for sound playback.

    Sound Playback Functions:
    - PlayUnlocking(value: boolean): Plays or stops the unlocking sound based on the provided value.
    - PlayHover(value: boolean): Plays or stops the hover sound based on the provided value.
    - PlayClick(value: boolean): Plays or stops the click sound based on the provided value.
    - PlaySwitchTrees(value: boolean): Plays or stops the switch trees sound based on the provided value.
    - PlayFail(value: boolean): Plays or stops the fail sound based on the provided value.
    - PlayAreYouSure(value: boolean): Plays or stops the "are you sure" sound based on the provided value.
    - PlayCompleteTask(value: boolean): Plays or stops the complete task sound based on the provided value.
    - PlaySelectSkills(value: boolean): Plays or stops the select skills sound based on the provided value.
    - PlayMenuSong(value: boolean): Plays or stops the menu song based on the provided value.

    -- ...
]]

export type SoundHandler = {
    LoadSounds : nil,
    Unlocking : nil,
    Hover : nil,
    Click : nil,
    SwithTrees : nil,
    Fail : nil,
    AreYouSure : nil,
    CompleteTast : nil,
    SelectSkills : nil,
    MenuSong : nil
}

local module : SoundHandler = {}

-- all the sound ids
local sounds : { [ string ] : string } = {
    Unlocking = "rbxassetid://13084907148",
    Hover = "rbxassetid://13084906797",
    Click = "rbxassetid://13084906145",
    SwitchTrees = "rbxassetid://13084906579",
    Fail = "rbxassetid://13084906247",
    AreYouSure = "rbxassetid://13084906396",
    CompleteTask = "rbxassetid://13084906928",
    SelectSkills = "rbxassetid://13084906710",
    MenuSong = "rbxassetid://13898250148"
}

-- Load functions and sounds
function module:LoadSounds()
    for SoundName : string, soundId : string in pairs(sounds) do
        local sound : Sound = script:FindFirstChild(SoundName) or Instance.new("Sound", script)
        sound.Name = SoundName
        sound.SoundId = soundId
    end
    -- Some exceptional cases
    script.MenuSong.Looped = true
end

function module:Play(SoundName)
    script:FindFirstChild(SoundName):Play()
end

function module:Stop(SoundName)
    script:FindFirstChild(SoundName):Stop()
end

function module:Pause(SoundName)
    script:FindFirstChild(SoundName):Pause()
end

return module
