local m_DinosaurDiv = require(script.Parent.Parent.DinosaurBranch)

local Protoceratops = m_DinosaurDiv.New("Protoceratops", m_DinosaurDiv.HEAD_DINOSAUR, 1)
local Dryosaurus = m_DinosaurDiv.New("Dryosaurus", m_DinosaurDiv.HEAD_DINOSAUR, 2)
m_DinosaurDiv.Add(Protoceratops, Dryosaurus)

local last = Dryosaurus

local Branches = {
	{ "Kentrosaurus", "Dacentrurus", "Stegosaurus", },
	
	{ "Pachycephalosaurus", "Pachyrhinosaurus", "Triceratops", },

	{ "Amargasaurus", "Camarasaurus", "Apatosaurus", },
	
	{ "Lurdusaurus", "Iguanodon", "Edmontosaurus", },

	{ "Nothronychus", "Therizinosaurus", }
}

local c = 3

for _, branch in pairs(Branches) do
	last = Dryosaurus
	for _, dino in ipairs(branch) do
		local dinoObj = m_DinosaurDiv.New(dino, m_DinosaurDiv.NORMAL_DINOSAUR, c)
		m_DinosaurDiv.Add(last, dinoObj); last = dinoObj; c += 1
	end
end

return Protoceratops