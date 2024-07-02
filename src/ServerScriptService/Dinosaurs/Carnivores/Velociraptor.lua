local Velociraptor = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Velociraptor.MALE = 50 --percent chance of spawning
Velociraptor.FEMALE = 50 -- percent chance of spawning

Velociraptor.Animations = {
	['Adult'] = {
		["Attack"] = "14066249202",
		["Crouch Idle"] = "11680810121",
		["Crouch Walk"] = "12284267089",
		["Dash"] = "11680580574",
		["Drink"] = "13676900623",
		["Eat"] = "13676900063",
		["Idle"] = "11680545611",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13310026331",
		["Rest"] = "11680576181",
		["Roar"] = "13310053837",
		["Run"] = "11680620877",
		["Swim"] = "12406442916",
		["Threat"] = "13310018552",
		["Walk"] = "11680541497",
		["SitDown"] = "11680573653",
		["GetUp"] = "11680628463",
		["Freefall"] = "13319196559"
	},
	['Baby'] = {
		["Attack"] = "14066249202",
		["Crouch Idle"] = "11680810121",
		["Crouch Walk"] = "12284267089",
		["Dash"] = "11680580574",
		["Drink"] = "13676900623",
		["Eat"] = "13676900063",
		["Idle"] = "11680545611",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13310026331",
		["Rest"] = "11680576181",
		["Roar"] = "13310053837",
		["Run"] = "11680620877",
		["Swim"] = "12406442916",
		["Threat"] = "13310018552",
		["Walk"] = "11680541497",
		["SitDown"] = "11680573653",
		["GetUp"] = "11680628463",
		["Freefall"] = "13319196559"
	},
	['Juvenile'] = {
		["Attack"] = "14066249202",
		["Crouch Idle"] = "11680810121",
		["Crouch Walk"] = "12284267089",
		["Dash"] = "11680580574",
		["Drink"] = "13676900623",
		["Eat"] = "13676900063",
		["Idle"] = "11680545611",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13310026331",
		["Rest"] = "11680576181",
		["Roar"] = "13310053837",
		["Run"] = "11680620877",
		["Swim"] = "12406442916",
		["Threat"] = "13310018552",
		["Walk"] = "11680541497",
		["SitDown"] = "11680573653",
		["GetUp"] = "11680628463",
		["Freefall"] = "13319196559"
	}
}

Velociraptor.Stats = {
	['Points'] = 0,

	['Combat'] = {
		["PrimaryAttack"] = "Bite",
		["SecondaryAttack"] = "Pounce",
	},

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
		["HungerDecrement"] = -0.3,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 6,
		["Stamina"] = 170,
		["SwimSpeed"] = 4.5,
		["Thirst"] = 100,
		["TurnTorque"] = 5000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 2.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.15,
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
		["Speed"] = 6,
		["Stamina"] = 170,
		["SwimSpeed"] = 4.5,
		["Thirst"] = 100,
		["TurnTorque"] = 2000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
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
		["Speed"] = 6,
		["Stamina"] = 170,
		["SwimSpeed"] = 4.5,
		["Thirst"] = 100,
		["TurnTorque"] = 3750,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.1
	}
}

return Velociraptor