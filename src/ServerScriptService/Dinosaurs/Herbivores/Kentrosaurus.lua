local Kentrosaurus = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Kentrosaurus.MALE = 50 --percent chance of spawning
Kentrosaurus.FEMALE = 50 -- percent chance of spawning

--[[

sit down: 11969848437
rest: 11969852657
get up: 11969859418

]]

Kentrosaurus.Animations = {
	['Adult'] = {
		["Attack"] = "14066244776",
		["Crouch Idle"] = "11969844325",
		["Crouch Walk"] = "11969846217",
		["Dash"] = "11969854006",
		["Drink"] = "6328914709",
		["Eat"] = "6328942444",
		["Idle"] = "11969850854",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13320138257",
		["Rest"] = "11969852657",
		["Roar"] = "13320137566",
		["Run"] = "11969857938",
		["Swim"] = "13084754197",
		["Threat"] = "13320136557",
		["Walk"] = "11969855932",
		["SitDown"] = "11969848437",
		["GetUp"] = "11969859418",
		["Freefall"] = "13320139359"
	},
	['Baby'] = {
		["Attack"] = "14066244776",
		["Crouch Idle"] = "11969844325",
		["Crouch Walk"] = "11969846217",
		["Dash"] = "11969854006",
		["Drink"] = "6328914709",
		["Eat"] = "6328942444",
		["Idle"] = "11969850854",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "14066007829",
		["Rest"] = "11969852657",
		["Roar"] = "14066007829",
		["Run"] = "11969857938",
		["Swim"] = "13084754197",
		["Threat"] = "14066007829",
		["Walk"] = "11969855932",
		["SitDown"] = "11969848437",
		["GetUp"] = "11969859418",
		["Freefall"] = "13320139359"
	},
	['Juvenile'] = {
		["Attack"] = "14066244776",
		["Crouch Idle"] = "11969844325",
		["Crouch Walk"] = "11969846217",
		["Dash"] = "11969854006",
		["Drink"] = "6328914709",
		["Eat"] = "6328942444",
		["Idle"] = "11969850854",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13320138257",
		["Rest"] = "11969852657",
		["Roar"] = "13320137566",
		["Run"] = "11969857938",
		["Swim"] = "13084754197",
		["Threat"] = "13320136557",
		["Walk"] = "11969855932",
		["SitDown"] = "11969848437",
		["GetUp"] = "11969859418",
		["Freefall"] = "13320139359"
	}
}

Kentrosaurus.Stats = {
	['Points'] = 600,

	['Combat'] = {
		["PrimaryAttack"] = "Bite",
		["SecondaryAttack"] = "Pounce",
	},

	['Adult'] = {
		["Attack"] = 20,
		["AttackCD"] = 2,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 26.5,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 23,
		["Health"] = 860,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 22,
		["Speed"] = 5,
		["Stamina"] = 120,
		["SwimSpeed"] = 3.75,
		["Thirst"] = 100,
		["TurnTorque"] = 4000000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Medium",
		["FootstepVolume"] = 0.1
	},

	['Baby'] = {
		["Attack"] = 5,
		["AttackCD"] = 1,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 26.5,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 23,
		["Health"] = 130,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 22,
		["Speed"] = 5,
		["Stamina"] = 120,
		["SwimSpeed"] = 3.75,
		["Thirst"] = 100,
		["TurnTorque"] = 80000,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.05
	},

	['Juvenile'] = {
		["Attack"] = 17,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 26.5,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 23,
		["Health"] = 495,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 22,
		["Speed"] = 5,
		["Stamina"] = 120,
		["SwimSpeed"] = 3.75,
		["Thirst"] = 100,
		["TurnTorque"] = 500000,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.1
	}
}

return Kentrosaurus