local Herrerasaurus = {}

-- NOTE: Make sure that MALE % + FEMALE % is always = 100, don't try to even think of
-- increasing the total value above 100.

Herrerasaurus.MALE = 50 --percent chance of spawning
Herrerasaurus.FEMALE = 50 -- percent chance of spawning

--[[


]]

Herrerasaurus.Animations = {
	['Adult'] = {
		["Attack"] = "14066151885",
		["Crouch Idle"] = "12773133240",
		["Crouch Walk"] = "12773086724",
		["Dash"] = "12773133793",
		["Drink"] = "13676902110",
		["Eat"] = "13676902684",
		["Idle"] = "12773135535",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13088011394",
		["Rest"] = "12773137461",
		["Roar"] = "13088012754",
		["Run"] = "12773138569",
		["Swim"] = "12773140077",
		["Threat"] = "13088010438",
		["Walk"] = "12773141071",
		["SitDown"] = "12773139352",
		["GetUp"] = "12773134461",
		["Freefall"] = "13320140418"
	},
	['Baby'] = {
		["Attack"] = "14066151885",
		["Crouch Idle"] = "12773133240",
		["Crouch Walk"] = "12773086724",
		["Dash"] = "12773133793",
		["Drink"] = "13676902110",
		["Eat"] = "13676902684",
		["Idle"] = "12773135535",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "14058384491",
		["Rest"] = "12773137461",
		["Roar"] = "14058384491",
		["Run"] = "12773138569",
		["Swim"] = "12773140077",
		["Threat"] = "14058384491",
		["Walk"] = "12773141071",
		["SitDown"] = "12773139352",
		["GetUp"] = "12773134461",
		["Freefall"] = "13320140418"
	},
	['Juvenile'] = {
		["Attack"] = "14066151885",
		["Crouch Idle"] = "12773133240",
		["Crouch Walk"] = "12773086724",
		["Dash"] = "12773133793",
		["Drink"] = "13676902110",
		["Eat"] = "13676902684",
		["Idle"] = "12773135535",
		["Look Left"] = "6328945056",
		["Look Right"] = "6328945785",
		["Passive"] = "13088011394",
		["Rest"] = "12773137461",
		["Roar"] = "13088012754",
		["Run"] = "12773138569",
		["Swim"] = "12773140077",
		["Threat"] = "13088010438",
		["Walk"] = "12773141071",
		["SitDown"] = "12773139352",
		["GetUp"] = "12773134461",
		["Freefall"] = "13320140418"
	}
}

Herrerasaurus.Stats = {
	['Points'] = 200,
	['Combat'] = {
		["PrimaryAttack"] = "Bite",
		["SecondaryAttack"] = "Pounce",
	},
	['Adult'] = {
		["Attack"] = 31,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 34,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 17,
		["Health"] = 340,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
		["Speed"] = 8,
		["Stamina"] = 155,
		["SwimSpeed"] = 6,
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
		["Attack"] = 7,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 34,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 17,
		["Health"] = 20,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
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
		["FootstepVolume"] = 0.1
	},

	['Juvenile'] = {
		["Attack"] = 19,
		["AttackCD"] = 1.5,
		["CanSwim"] = false,
		['CrouchSpeed'] = 3,
		['DashSpeed'] = 34,
		["Defense"] = 25,
		["Diet"] = "Carnivore",
		["Eat/Drink Range"] = 20,
		["GrowthRate"] = 17,
		["Health"] = 180,
		["Hunger"] = 100,
		["Oxygen"] = 10,
		["RunSpeed"] = 25,
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
		["FootstepVolume"] = 0.15
	}
}

return Herrerasaurus