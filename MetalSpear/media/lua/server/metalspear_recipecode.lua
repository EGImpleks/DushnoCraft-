

-- get the spear, lower its condition according to MetalWelding perk level
function Recipe.OnCreate.CreateMetalSpear(items, result, player, selectedItem)
    local conditionMax = 2 + player:getPerkLevel(Perks.MetalWelding);--12 min at 10 metalwielding
    conditionMax = ZombRand(conditionMax, conditionMax + 4);--4 margin for condition up to level 6
    if conditionMax > result:getConditionMax() then
        conditionMax = result:getConditionMax();--saturate at max
    end
    local toRemove = -4;--allow some bad condition, matching approximately the lost weight ratio
    for i=0,items:size() - 1 do--remove condition if metal bars are in bad condition
        toRemove = toRemove + (items:get(i):getConditionMax() - items:get(i):getCondition())
    end
    if toRemove > 0 then
        conditionMax = conditionMax - toRemove;
    end
    if conditionMax < 2 then--min condition = 2
        conditionMax = 2;
    end
    result:setCondition(conditionMax);
end
