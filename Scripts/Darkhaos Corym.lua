RequiredHealths = 80
RequiredManas = 200

SoftBoots = false

HealthsToLeave = 20
ManasToLeave = 30

LeaveNoSoftBoots = false

ManaID = 268
ManaPrice = 50
HealthID = 266
HealthPrice = 190


CapToLeave = 75

LeaveAtGold = 10000

LootBP = "backpack"
ProductBP = "camouflage backpack"

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
setTargetingEnabled(true)
setLooterEnabled(true)

print([[
Coryms Script by Darkhaos
Version 1.0.0
]])

function onWalkerSelectLabel(labelName)

	if labelName == "Start" then
		setWalkerEnabled(false)
		if Self.ItemCount(ManaID) < RequiredManas or Self.ItemCount(HealthID) < RequiredHealths then
			gotoLabel("GoToBank")
		end
		Self.CloseContainers()
		sleep(math.random(800, 1200))
		Self.OpenMainBackpack(true):OpenChildren({Item.GetID(LootBP),true}, {Item.GetID(ProductBP), true})
		wait(2000,4000)
		--setWalkerEnabled(true)
	elseif labelName == "TalkWithBank" then
		local requiredMoneyManas = (RequiredManas - Self.ItemCount(ManaID)) * ManaPrice
		local requiredMoneyHealths = (RequiredHealths - Self.ItemCount(HealthID)) * HealthPrice
		if requiredMoneyManas < 1 then requiredMoneyManas = 0 end
		if requiredMoneyHealths < 1 then requiredMoneyHealths = 0 end
		local total = requiredMoneyManas + requiredMoneyHealths
		if SoftBoots and Self.ItemCount(6530) > 0 then
			total = total + 10500
		end
		
		setWalkerEnabled(false)
		delayWalker(10000)
		Self.SayToNpc("hi")
		sleep(math.random(1000, 2117))
		if Self.Money() > 0 then
			Self.SayToNpc("deposit all")
			sleep(math.random(1000, 2117))
			Self.SayToNpc("yes")
			sleep(math.random(1000, 2117))
		end
		if total > 0 then
			Self.WithdrawMoney(total)
			sleep(math.random(1000, 2114))
		end
		Self.SayToNpc("balance")
		sleep(math.random(1000, 2115))
		setWalkerEnabled(true)
	elseif labelName == "CheckForPots" then
		local rManas = RequiredManas - Self.ItemCount(ManaID)
		local rHealths = RequiredHealths - Self.ItemCount(HealthID)
		if rManas < 1 then rManas = 0 end
		if rHealths < 1 then rHealths = 0 end
		
		setWalkerEnabled(false)
		if rManas > 0 or rHealths > 0 then
			gotoLabel("GoBuyPots")
		else
			gotoLabel("GoToCave")
		end
		setWalkerEnabled(true)
	elseif labelName == "BuyPots" then
		local requiredManas = RequiredManas - Self.ItemCount(ManaID)
		local requiredHealths = RequiredHealths - Self.ItemCount(HealthID)
		if requiredManas < 1 then requiredManas = 0 end
		if requiredHealths < 1 then requiredHealths = 0 end
		if requiredManas > 0 or requiredHealths > 0 then
			setWalkerEnabled(false)
			Self.SayToNpc("hi")
			sleep(math.random(1000, 1500))
			Self.SayToNpc("trade")
			sleep(math.random(500, 800))
			if requiredManas > 0 then
				Self.ShopBuyItem(ManaID, requiredManas)
			end
			if requiredHealths > 0 then
				Self.ShopBuyItem(HealthID, requiredHealths)
			end
			sleep(math.random(600, 1000))
		end
		setWalkerEnabled(true)
	elseif labelName == "CheckSoft" then
		setWalkerEnabled(false)
		if SoftBoots then
			if Self.ItemCount(6530) > 0 then
				gotoLabel("GoToVenore")
			else
				gotoLabel("GoToCave")
			end
		else
			gotoLabel("GoToCave")
		end
		setWalkerEnabled(true)
	elseif labelName == "Charles" then
		setWalkerEnabled(false)
		delayWalker(6000)
		Self.Say("hi")
		sleep(math.random(1000, 1900))
		Self.SayToNpc("venore")
		sleep(math.random(1000, 1850))
		Self.SayToNpc("yes")
		sleep(math.random(1000, 2000))
		setWalkerEnabled(true)
	elseif labelName == "Aldo" then
		setWalkerEnabled(false)
		delayWalker(6000)
		Self.Say("hi")
		sleep(math.random(1000, 1927))
		Self.SayToNpc("soft boots")
		sleep(math.random(850, 1500))
		Self.SayToNpc("yes")
		sleep(math.random(500, 1000))
		setWalkerEnabled(true)
	elseif labelName == "Fearless" then
		setWalkerEnabled(false)
		delayWalker(6000)
		Self.Say("hi")
		sleep(math.random(1000, 1900))
		Self.SayToNpc("port hope")
		sleep(math.random(1000, 1850))
		Self.SayToNpc("yes")
		sleep(math.random(1000, 2000))
		setWalkerEnabled(true)
	elseif labelName == "GoToCave" then
		if Self.Feet().id == 4033 then
			Self.Equip(6529, "feet")
		end
	elseif labelName == "Check" then
		setWalkerEnabled(false)
		if Self.Feet().id == 6530 then
			Self.Equip(4033, "feet")
		end
		if Self.ItemCount(ManaID) <= ManasToLeave or Self.ItemCount(HealthID) <= HealthsToLeave or Self.Cap() <= CapToLeave or Self.Money() >= LeaveAtGold or (Self.ItemCount(6530) > 0 and LeaveNoSoftBoots and SoftBoots) then
			gotoLabel("Leave")
		else
			gotoLabel("Hunt")
		end
		setWalkerEnabled(true)
	elseif labelName == "BankDeposit" then
		Walker.Stop()
		sleep(math.random(300, 1500))
		Self.Equip(4033, "feet")
		if Self.Money() > 0 then
			Self.Say("hi")
			sleep(math.random(300, 1500))
			Self.DepositMoney()
			sleep(math.random(250, 1800))
			Self.SayToNpc("balance")
			sleep(math.random(250, 1325))
		end
		Walker.Start()
		
	elseif labelName == "Depot" then
		
		setWalkerEnabled(false)
		Self.CloseContainers()
		sleep(math.random(800, 1200))
		Self.OpenMainBackpack(true):OpenChildren({Item.GetID(LootBP),true}, {Item.GetID(ProductBP), true})
		wait(2000,4000)
		Self.ReachDepot()
        Self.DepositItems({17812, 0}, {17813, 0}, {17810, 0}, {17859, 0}, {17825, 0}, {17846, 0})
		Self.DepositItems({17809, 1}, {17819, 1}, {17817, 1}, {17846, 1}, {17818, 1})
		sleep(3000)
		gotoLabel("Start")
		setWalkerEnabled(true)
	elseif labelName == "Finish" then
		setWalkerEnabled(false)
	end
end

Map.GetUseItems = function (id)
    if type(id) == "string" then
        id = Item.GetID(id)
    end
    local pos = Self.Position()
    local store = {}
    for x = -7, 7 do
        for y = -5, 5 do
            if Map.GetTopUseItem(pos.x + x, pos.y + y, pos.z).id == id then
                itemPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
                table.insert(store, itemPos)
            end
        end
    end
    return store
end

function closeBackpacks()
    local displayName = "CloseBackpacks"
    local tmpBP = Container.GetFirst() 
    local cascaded = {}
    while tmpBP:isOpen() do
        for spot = 0, tmpBP:ItemCount() do
            local item = tmpBP:GetItemData(spot)
            if item.id == tmpBP:ID() then
                table.insert(cascaded, tmpBP:ID())
                tmpBP = tmpBP:GetNext()
            end
        end
        tmpBP = Container.GetFirst()
        if not table.contains(cascaded, tmpBP:ID()) or tmpBP:ItemCount() == 0 then -- Backpack is main or last cascaded. Closing...
            Self.UseItem(tmpBP:ID())
            wait(500, 900)
        end
        if #cascaded > 0 then -- Any cascaded backpacks?
            for i = 1, #cascaded do
                if tmpBP:ID() == cascaded[i] then -- Found cascaded backpack.
                    if tmpBP:ItemCount() > 0 then -- Backpack contains atleast one item, check for another bp.
                        for spot = 0, tmpBP:ItemCount() do
                            local item = tmpBP:GetItemData(spot)
                            if item.id == tmpBP:ID() then -- Found anoter cascade bp, opening...
                                tmpBP:UseItem(spot, true)
                                break
                            end
                        end
                    end
                end
            end
        end
        wait(500, 900)
        tmpBP = Container.GetFirst() -- Get a new bp to check.
        if tmpBP:ID() == 0 then -- No more open backpacks.
            print("All backpacks were successfully closed.")
        end
    end
    return true
end

Self.ReachDepot = function (tries)
    local tries = tries or 3
    setWalkerEnabled(false)
    local DepotIDs = {3497, 3498, 3499, 3500}
    local DepotPos = {}
    for i = 1, #DepotIDs do
        local dps = Map.GetUseItems(DepotIDs[i])
        for j = 1, #dps do
            table.insert(DepotPos, dps[j])
        end
    end
    local function gotoDepot()
        local pos = Self.Position()
        print("Depots found: " .. tostring(#DepotPos))
        for i = 1, #DepotPos do
            location = DepotPos[i]
            Self.UseItemFromGround(location.x, location.y, location.z)
            wait(1000, 2000)
            if Self.DistanceFromPosition(pos.x, pos.y, pos.z) >= 1 then
                wait(5000, 6000)
                if Self.DistanceFromPosition(location.x, location.y, location.z) == 1 then
                    setWalkerEnabled(true)
                    return true
                end
            else
                print("Something is blocking the path. Trying next depot.")
            end
        end
        return false
    end
    
    repeat
        reachedDP = gotoDepot()
        if reachedDP then
            return true
        end
        tries = tries - 1
        sleep(100)
        print("Attempt to reach depot was unsuccessfull. " .. tries .. " tries left.")
    until tries <= 0


    return false
end

function openBackpacks(...)
    local displayName = "OpenBackpacks"
    local backpacks = {...}
    Self.UseItem(Self.Backpack().id) -- Open main backpack.
    print("Opening main backpack.")
    wait(500, 900)
    main = Container.GetFirst()
    if #backpacks > 0 then
        for i = 1, #backpacks do
            if type(backpacks[i]) == 'table' then -- Is parent container specified?
                tmpBP = Container.GetByName(backpacks[i][1])
                for spot = 0, tmpBP:ItemCount() do
                    item = tmpBP:GetItemData(spot)
                    if item.id == backpacks[i][2] then
                        tmpBP:UseItem(spot)
                        print("Opening backpack from list. " .. backpacks[i][1] .. ", " .. backpacks[i][2])
                        wait(500, 800)
                    end
                end
            else -- If there is no parent specified we will use the main bp.
                for spot = 0, main:ItemCount() do
                    item = main:GetItemData(spot)
                    if item.id == backpacks[i] then
                        main:UseItem(spot)
                        print("Opening backpack from list, " .. backpacks[i])
                        wait(500, 800)
                    end
                end
            end
        end
        local indexes = Container.GetIndexes()
        for i = 1, #indexes do
            if type(backpacks[i]) == "table" then
                if Container.GetFromIndex(indexes[i]):ID() ~= backpacks[i][1] then
                    return false
                end
            else
                if Container.GetFromIndex(indexes[i]):ID() ~= backpacks[i] then
                    return false
                end
            end
        end
        return true
    end
end

function getOpenBackpacks()
    local indexes = Container.GetIndexes() -- Find index for all open backpacks
    local open = {} -- Create a place to store our open backpacks
    for i = 1, #indexes do -- Search all open backpacks
        tmpBP = Container.GetFromIndex(indexes[i])
        table.insert(open, tmpBP:ID()) -- Store this backpack
    end
    return open -- Return found backpacks
end

function resetBackpacks(tries)
    setWalkerEnabled(false)
    local open = getOpenBackpacks() -- Save a list of open backpacks
    local tries = 3 -- Give the script 3 tries to achieve a successful reset.
    repeat
        closeBackpacks() -- Close all backpacks
        wait(600, 800) -- wait a little bit
        local reopen = openBackpacks(unpack(open)) -- I store the return from openBackpacks, true if successfull, false otherwise
        if tries == 0 then -- Check how many tries function has left
            print("BackpackReset failed!") -- Tell the user reset has failed
            return false
        end
        tries = tries - 1 -- One try has been spent
    until reopen -- If reopen is true it means all backpacks were opened successfully and function is done
    print("BackpackReset was successfull!") -- Tell user reset was successful
    setWalkerEnabled(true)
    return true
end




