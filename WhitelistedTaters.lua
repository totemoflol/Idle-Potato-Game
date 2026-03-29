local mode = "DiamondTaters" -- Owner, Devs, Premium

local DiamondRank = {
    [4874964037] = true, -- bjdhcmain
    [1242588417] = true  -- durianlover9
}

local EmeraldRank = {
    [3076753381] = true, -- aaaionj2
    [4993924900] = true  -- urmotherlah6
}

local GoldRank = {
}


local whitelist = {}
local function addRank(rankTable)
    for id, _ in pairs(rankTable) do
        whitelist[id] = true
    end
end

-- always include diamond
addRank(DiamondRank)

-- add based on mode
if mode == "Owner" then

elseif mode == "Devs" then
    addRank(EmeraldRank)

elseif mode == "Premium" then
    addRank(EmeraldRank)
    addRank(GoldRank)
end

-- set global
getgenv().whitelistedtaters = whitelist