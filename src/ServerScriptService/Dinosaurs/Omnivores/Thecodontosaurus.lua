local Thecodontosaurus = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Thecodontosaurus.MALE = 50 --percent chance of spawning
Thecodontosaurus.FEMALE = 50 -- percent chance of spawning

Thecodontosaurus.Animations = {
	['Adult'] = {
		["Attack"] = "14066247915",
		["Crouch Idle"] = "12457942296",
		["Crouch Walk"] = "12457943517",
		["Dash"] = "12457944670",
		["Drink"] = "5898674097",
		["Eat"] = "5898674787",
		["Idle"] = "12457948314",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13345484269",
		["Rest"] = "12457961883",
		["Roar"] = "13345477487",
		["Run"] = "12457964492",
		["Swim"] = "12457967157",
		["Threat"] = "13345480612",
		["Walk"] = "12457968478",
		["SitDown"] = "12457959793",
		["GetUp"] = "12457963508",
		["Freefall"] = "13283507514"
	},
	['Baby'] = {
		["Attack"] = "14066247915",
		["Crouch Idle"] = "12457942296",
		["Crouch Walk"] = "12457943517",
		["Dash"] = "12457944670",
		["Drink"] = "5898674097",
		["Eat"] = "5898674787",
		["Idle"] = "12457948314",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "14066014632",
		["Rest"] = "12457961883",
		["Roar"] = "14066014632",
		["Run"] = "12457964492",
		["Swim"] = "12457967157",
		["Threat"] = "14066014632",
		["Walk"] = "12457968478",
		["SitDown"] = "12457959793",
		["GetUp"] = "12457963508",
		["Freefall"] = "13283507514"
	},
	['Juvenile'] = {
		["Attack"] = "14066247915",
		["Crouch Idle"] = "12457942296",
		["Crouch Walk"] = "12457943517",
		["Dash"] = "12457944670",
		["Drink"] = "5898674097",
		["Eat"] = "5898674787",
		["Idle"] = "12457948314",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13345484269",
		["Rest"] = "12457961883",
		["Roar"] = "13345477487",
		["Run"] = "12457964492",
		["Swim"] = "12457967157",
		["Threat"] = "13345480612",
		["Walk"] = "12457968478",
		["SitDown"] = "12457959793",
		["GetUp"] = "12457963508",
		["Freefall"] = "13283507514"
	}
}

Thecodontosaurus.Stats = {
	['Points'] = 0,
	['Adult'] = {
		["Attack"] = 9,
		["AttackCD"] = 1,		
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 33.5,
		["Defense"] = 1,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 10,
		["Health"] = 30,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 5,
		["Stamina"] = 185,
		["SwimSpeed"] = 3.75,
		["Thirst"] = 100,
		["TurnTorque"] = 5000,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.15
	},

	['Baby'] = {
		["Attack"] = 3,
		["AttackCD"] = 1,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 33.5,
		["Defense"] = 1,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 10,
		["Health"] = 10,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 5,
		["Stamina"] = 185,
		["SwimSpeed"] = 3.75,
		["Thirst"] = 100,
		["TurnTorque"] = 2000,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.05
	},

	['Juvenile'] = {
		["Attack"] = 6,
		["AttackCD"] = 1,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 33.5,
		["Defense"] = 1,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 10,
		["Health"] = 20,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 5,
		["Stamina"] = 185,
		["SwimSpeed"] = 3.75,
		["Thirst"] = 100,
		["TurnTorque"] = 3750,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.1
	}
}

return Thecodontosaurus