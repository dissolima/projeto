-- *****************************************************************************************************************************
-- © Copyright All rights deserved - Scriptzone 2019, Brazil
-- Website: www.scriptzone.com.br
-- *****************************************************************************************************************************
-- Esta biblioteca é propriedade dos clientes da Scriptzone
-- É proibida a venda ou distribuição em qualquer situação
-- A violação e identificaçao do violador implica punição legal
-- Para bom funcionamento dos scripts relacionados a essa biblioteca de funções não devem existir funções repetidas no arquivo
-- Caso já possua outra biblioteca de funções da Scriptzone, una-as em um só arquivo
-- *****************************************************************************************************************************
-- This library is Scriptzone's clients property
-- It is prohibited sale or distribution in any situation
-- Violation and identification of the violator implies legal punishment
-- For proper scripts operation related to this library of functions shouldn't have repeated function in the file
-- In case of there is another Scriptzone library of functions, join them in a single file
-- *****************************************************************************************************************************

-- All functions by Scriptzone

function mathtime(table)
local unit = {"sec", "min", "hour", "day"}
for i, v in pairs(unit) do
if v == table[2] then
return table[1]*(60^(v == unit[4] and 2 or i-1))*(v == unit[4] and 24 or 1)
end
end
return error("Bad declaration in mathtime function.")
end

function getStrTime(table)
local unit = {["sec"] = "second",["min"] = "minute",["hour"] = "hour",["day"] = "day"}
return tostring(table[1].." "..unit[table[2]]..(table[1] > 1 and "s" or ""))
end


function getItemsFromTab(items)
    local str = ''
    if table.maxn(items) > 0 then
        for i = 1, table.maxn(items) do
            local count, itemName = items[i][2], getItemNameById(items[i][1]) 
            str = str .. count .. ' ' .. itemName ..  addPlural(count, "s", itemName)
            if i ~= table.maxn(items) then 
                str = str .. ', ' 
            end 
        end
    end
    return str
end

function addPlural(counter, windup, word)
    if counter <= 1 then return "" end
    return not word and windup or (word:sub(-1,-1) ~= windup and windup or "")
end

function doRemoveItemsFromTab(cid,items)
    local count = 0
    if table.maxn(items) > 0 then
        for i = 1, table.maxn(items) do
            if getPlayerItemCount(cid,items[i][1]) >= items[i][2] then
                count = count + 1 
            end 
        end 
    end
    if count == table.maxn(items) then
        for i = 1, table.maxn(items) do doPlayerRemoveItem(cid,items[i][1],items[i][2]) end
    else 
        return false 
    end
    return true 
end

function doPlayerAddRateTime(cid, type, added_value, time)
    local actual_rate = getPlayerExtraRate(cid, type)
    doPlayerSetRate(cid, type, (1 + (.01 * added_value)) + actual_rate)
    if time then
        addEvent(function()
            if isPlayer(cid) then
                doPlayerAddRateTime(cid, type, -added_value)
                print("acabou")
            end
        end, time * 1000)
    end
end

function getPlayerExtraRate(cid, type)
    return (getPlayerRates(cid)[type]-1)
end

function getPlayerLastLogout(cid, date_string)
    local query = db.getResult("SELECT `lastlogout` as `logout_time` FROM `players` WHERE `id` = " .. getPlayerGUID(cid) .. ";")
    if query:getID() == -1 then
        return false
    end
    local logoutTime = query:getDataInt("logout_time")
    return not date_string and logoutTime or os.date("%d %B %Y %X", logoutTime)
end

function getStringTime(time, low_precision)
    local checkTime = time
    local unit = {{86400,"day"},{3600,"hour"},{60,"min"},{1,"sec"}}
    local strs, str, n = {}, "", 1
    if time == 1 then
        return string.format("1 %s", unit[4][2])
    elseif time <= 0 then
        return 0 
    end
    while time > 1 do
        local k = unit[n]
        if time > k[1] then
            local t, s = math.floor(time/k[1]), k[2]
            table.insert(strs, t.." "..(t > 1 and s.."s" or s))
            time = time % k[1]
        end
        n = n + 1
    end
    if not low_precision then
        for i = 1, #strs do
            str = str..strs[i]..(i == #strs-1 and " and " or i == #strs and "" or ", ")
        end
    else
        if #strs > 1 then
            if checkTime > 60 then
                str = "about "..strs[1]
            end
        else
            str = strs[1]
        end
    end
    return str
end
