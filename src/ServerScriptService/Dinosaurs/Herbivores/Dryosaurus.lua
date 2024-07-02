local Dryosaurus = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Dryosaurus.MALE = 50 --percent chance of spawning
Dryosaurus.FEMALE = 50 -- percent chance of spawning

Dryosaurus.Animations = {
	['Adult'] = {
		["Attack"] = "14066243831",
		["Crouch Idle"] = "13049689921",
		["Crouch Walk"] = "13049690891",
		["Dash"] = "13049691704",
		["Drink"] = "6328914709",
		["Eat"] = "6328942444",
		["Idle"] = "13049696688",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13309771573",
		["Rest"] = "13049700801",
		["Roar"] = "13309767566",
		["Run"] = "13049701884",
		["Swim"] = "13049704807",
		["Threat"] = "13309759857",
		["Walk"] = "13049706074",
		["SitDown"] = "13049703572",
		["GetUp"] = "13049693900",
		["Freefall"] = "13283511051"
	},
	['Baby'] = {
		["Attack"] = "14066243831",
		["Crouch Idle"] = "13049689921",
		["Crouch Walk"] = "13049690891",
		["Dash"] = "13049691704",
		["Drink"] = "6328914709",
		["Eat"] = "6328942444",
		["Idle"] = "13049696688",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13309771573",
		["Rest"] = "13049700801",
		["Roar"] = "13309767566",
		["Run"] = "13049701884",
		["Swim"] = "13049704807",
		["Threat"] = "13309759857",
		["Walk"] = "13049706074",
		["SitDown"] = "13049703572",
		["GetUp"] = "13049693900",
		["Freefall"] = "13283511051"
	},
	['Juvenile'] = {
		["Attack"] = "14066243831",
		["Crouch Idle"] = "13049689921",
		["Crouch Walk"] = "13049690891",
		["Dash"] = "13049691704",
		["Drink"] = "6328914709",
		["Eat"] = "6328942444",
		["Idle"] = "13049696688",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13309771573",
		["Rest"] = "13049700801",
		["Roar"] = "13309767566",
		["Run"] = "13049701884",
		["Swim"] = "13049704807",
		["Threat"] = "13309759857",
		["Walk"] = "13049706074",
		["SitDown"] = "13049703572",
		["GetUp"] = "13049693900",
		["Freefall"] = "13283511051"
	}
}

Dryosaurus.Stats = {
	['Points'] = 200,

	['Combat'] = {
		["PrimaryAttack"] = "Bite",
		["SecondaryAttack"] = "Pounce",
	},

	['Adult'] = {
		["Attack"] = 25,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 34,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 17,
		["Health"] = 720,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 7,
		["Stamina"] = 155,
		["SwimSpeed"] = 5.25,
		["Thirst"] = 100,
		["TurnTorque"] = 50000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.2
	},

	['Baby'] = {
		["Attack"] = 5,
		["AttackCD"] = 1,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 34,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 17,
		["Health"] = 720,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 7,
		["Stamina"] = 155,
		["SwimSpeed"] = 5.25,
		["Thirst"] = 100,
		["TurnTorque"] = 5000,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.125
	},

	['Juvenile'] = {
		["Attack"] = 15,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 34,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 17,
		["Health"] = 720,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 7,
		["Stamina"] = 155,
		["SwimSpeed"] = 5.25,
		["Thirst"] = 100,
		["TurnTorque"] = 25000,
		["DashDecrement"] = 3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = 1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 1.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.75
	}
}

return Dryosaurus