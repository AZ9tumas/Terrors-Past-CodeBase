local m_DinosaurDiv = require(script.Parent.Parent.DinosaurBranch)

local Thecodontosaurus = m_DinosaurDiv.New("Thecodontosaurus", m_DinosaurDiv.HEAD_DINOSAUR, 1)

local last = Thecodontosaurus

local Branches = {
	{ "Ornithomimus", "Paraxenisaurus", "Deinocherius", },
	
	{ "Avimimus", "Anzu", "Gigantoraptor", },
	
	{ "Fukuivenator", "Stenonychosaurus", "Zanabazar",}
}

local c = 2

for _, branch in pairs(Branches) do
	last = Thecodontosaurus
	for _, dino in ipairs(branch) do
		local dinoObj = m_DinosaurDiv.New(dino, m_DinosaurDiv.NORMAL_DINOSAUR, c)
		m_DinosaurDiv.Add(last, dinoObj); last = dinoObj; c += 1
	end
end

return Thecodontosaurus