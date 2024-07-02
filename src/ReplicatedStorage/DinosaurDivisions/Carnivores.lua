local m_DinosaurDiv = require(script.Parent.Parent.DinosaurBranch)

local Velociraptor = m_DinosaurDiv.New("Velociraptor", m_DinosaurDiv.HEAD_DINOSAUR, 1)
local Herrerasaurus = m_DinosaurDiv.New("Herrerasaurus", m_DinosaurDiv.HEAD_DINOSAUR, 2)
m_DinosaurDiv.Add(Velociraptor, Herrerasaurus)

local last = Herrerasaurus

local Branches = {
	{ "Austroraptor", "Baryonyx", "Suchomimus", "Spinosaurus", },
	{ "Ceratosaurus", "Carnotaurus", "Albertosaurus", "Tyrannosaurus", },
	{ "Concavenator", "Allosaurus", "Asfaltovenator", "Acrocanthosaurus", },
	{ "Australovenator", "Megaraptor", }
}

local c = 3

for _, branch in pairs(Branches) do
	last = Herrerasaurus
	for _, dino in ipairs(branch) do
		local dinoObj = m_DinosaurDiv.New(dino, m_DinosaurDiv.NORMAL_DINOSAUR, c)
		m_DinosaurDiv.Add(last, dinoObj); last = dinoObj; c += 1
	end
end

return Velociraptor