local Protoceratops = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Protoceratops.MALE = 50 --percent chance of spawning
Protoceratops.FEMALE = 50 -- percent chance of spawning

Protoceratops.Animations = {
	['Adult'] = {
		["Attack"] = "14066247159",
		["Crouch Idle"] = "12396566037",
		["Crouch Walk"] = "12396564734",
		["Dash"] = "12396563221",
		["Drink"] = "5898674097",
		["Eat"] = "5898674787",
		["Idle"] = "12396560361",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13309916344",
		["Rest"] = "12396556337",
		["Roar"] = "13309915611",
		["Run"] = "12396554271",
		["Swim"] = "13423496384",
		["Threat"] = "13309914584",
		["Walk"] = "12396551916",
		["SitDown"] = "12396553028",
		["GetUp"] = "12396561308",
		["Freefall"] = "13283516610"
	},
	['Baby'] = {
		["Attack"] = "14066247159",
		["Crouch Idle"] = "12396566037",
		["Crouch Walk"] = "12396564734",
		["Dash"] = "12396563221",
		["Drink"] = "5898674097",
		["Eat"] = "5898674787",
		["Idle"] = "12396560361",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "14066016065",
		["Rest"] = "12396556337",
		["Roar"] = "14066016065",
		["Run"] = "12396554271",
		["Swim"] = "13423496384",
		["Threat"] = "14066016065",
		["Walk"] = "12396551916",
		["SitDown"] = "12396553028",
		["GetUp"] = "12396561308",
		["Freefall"] = "13283516610"
	},
	['Juvenile'] = {
		["Attack"] = "14066247159",
		["Crouch Idle"] = "12396566037",
		["Crouch Walk"] = "12396564734",
		["Dash"] = "12396563221",
		["Drink"] = "5898674097",
		["Eat"] = "5898674787",
		["Idle"] = "12396560361",
		["Look Left"] = "6202256094",
		["Look Right"] = "6202253898",
		["Passive"] = "13309916344",
		["Rest"] = "12396556337",
		["Roar"] = "13309915611",
		["Run"] = "12396554271",
		["Swim"] = "13423496384",
		["Threat"] = "13309914584",
		["Walk"] = "12396551916",
		["SitDown"] = "12396553028",
		["GetUp"] = "12396561308",
		["Freefall"] = "13283516610"
	}
}

Protoceratops.Stats = {
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
		['DashSpeed'] = 29,
		["Defense"] = 1,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 10,
		["Health"] = 30,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 19,
		["Speed"] = 8,
		["Stamina"] = 155,
		["SwimSpeed"] = 6,
		["Thirst"] = 100,
		["TurnTorque"] = 80000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
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
		['DashSpeed'] = 29,
		["Defense"] = 1,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 10,
		["Health"] = 10,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 19,
		["Speed"] = 8,
		["Stamina"] = 155,
		["SwimSpeed"] = 6,
		["Thirst"] = 100,
		["TurnTorque"] = 5000,
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
		['DashSpeed'] = 29,
		["Defense"] = 1,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 10,
		["Health"] = 20,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 19,
		["Speed"] = 8,
		["Stamina"] = 155,
		["SwimSpeed"] = 6,
		["Thirst"] = 100,
		["TurnTorque"] = 25000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.1
	}
}

return Protoceratops