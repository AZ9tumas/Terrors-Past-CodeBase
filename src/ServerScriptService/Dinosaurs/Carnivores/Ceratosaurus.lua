local Ceratosaurus = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Ceratosaurus.MALE = 100 --percent chance of spawning
Ceratosaurus.FEMALE = 0 -- percent chance of spawning

--[[

sit down: 11491832910
rest: 11491812482
get up: 11491823468

temp values:
velociraptor - 10
thecodontosaurus - 10
protoceratops - 10

herrerasaurus -17
dryosaurus - 17

kentrosaurus - 23
ceratosaurus - 23

]]


Ceratosaurus.Animations = {
	['Adult'] = {
		["Attack"] = "14066242704",
		["Crouch Idle"] = "10642081838",
		["Crouch Walk"] = "10642079986",
		["Dash"] = "10642075480",
		["Drink"] = "13329498128",
		["Eat"] = "13329505125",
		["Idle"] = "10760948011",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13133512166",
		["Rest"] = "11491812482",
		["Roar"] = "13133520435",
		["Run"] = "10642072553",
		["Swim"] = "13084453838",
		["Threat"] = "13133502099",
		["Walk"] = "10642070857",
		["SitDown"] = "11491832910",
		["GetUp"] = "11491823468",
		["Freefall"] = "13283507514"
	},
	['Baby'] = {
		["Attack"] = "14066242704",
		["Crouch Idle"] = "10642081838",
		["Crouch Walk"] = "10642079986",
		["Dash"] = "10642075480",
		["Drink"] = "13329498128",
		["Eat"] = "13329505125",
		["Idle"] = "10760948011",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "14066005880",
		["Rest"] = "11491812482",
		["Roar"] = "14066005880",
		["Run"] = "10642072553",
		["Swim"] = "13084453838",
		["Threat"] = "14066005880",
		["Walk"] = "10642070857",
		["SitDown"] = "11491832910",
		["GetUp"] = "11491823468",
		["Freefall"] = "13283507514"
	},
	['Juvenile'] = {
		["Attack"] = "14066242704",
		["Crouch Idle"] = "10642081838",
		["Crouch Walk"] = "10642079986",
		["Dash"] = "10642075480",
		["Drink"] = "13329498128",
		["Eat"] = "13329505125",
		["Idle"] = "10760948011",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13133512166",
		["Rest"] = "11491812482",
		["Roar"] = "13133520435",
		["Run"] = "10642072553",
		["Swim"] = "13084453838",
		["Threat"] = "13133502099",
		["Walk"] = "10642070857",
		["SitDown"] = "11491832910",
		["GetUp"] = "11491823468",
		["Freefall"] = "13283507514"
	}
}

Ceratosaurus.Stats = {
	['Points'] = 600,

	['Combat'] = {
		["PrimaryAttack"] = "Bite",
		["SecondaryAttack"] = "Thrasher",
	},

	['Adult'] = {
		["Attack"] = 75,
		["AttackCD"] = 2,
		["CanSwim"] = false,
		['CrouchSpeed'] = 6,
		['DashSpeed'] = 28,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 0.5,
		["Health"] = 720,
		["HungerDecrement"] = -0.05,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 9,
		["Stamina"] = 130,
		["SwimSpeed"] = 6.5,
		["Thirst"] = 100,
		["TurnTorque"] = 2000000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 2.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Medium",
		["FootstepVolume"] = 0.1
	},

	['Baby'] = {
		["Attack"] = 7,
		["AttackCD"] = 1,
		["CanSwim"] = false,
		['CrouchSpeed'] = 6,
		['DashSpeed'] = 28,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 0.5,
		["Health"] = 100,
		["HungerDecrement"] = -0.1,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 9,
		["Stamina"] = 130,
		["SwimSpeed"] = 6.5,
		["Thirst"] = 100,
		["TurnTorque"] = 5000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 2.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.15
	},

	['Juvenile'] = {
		["Attack"] = 30,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 6,
		['DashSpeed'] = 28,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 0.5,
		["Health"] = 410,
		["HungerDecrement"] = -0.05,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 9,
		["Stamina"] = 130,
		["SwimSpeed"] = 6.5,
		["Thirst"] = 100,
		["TurnTorque"] = 50000,
		["DashDecrement"] = -3, -- Decrement in Stamina when Dash-sprinting.
		["RunDecrement"] = -1.5, -- Decrememnt in Stamina when running.
		["WalkIncrement"] = 1.5, -- Increment in Stamina when Walking.
		["CrouchIncrement"] = 2.5, -- Increment in Stamina when crouching.
		["StandIncrement"] = 3, -- Incrememnt in Stamina when standing.
		["FootstepSize"] = "Small",
		["FootstepVolume"] = 0.22
	}
}

return Ceratosaurus