function join(thePlayer)
    if isPedInVehicle(thePlayer) or getElementType(thePlayer) == "vehicle" then
        outputChatBox("[System]#ffffff Shoma Dakhel #ff0000Mashin#ffffff Nemitavanid Vared #ff0000RP Pause#ffffff Shavid.", thePlayer, 255, 0, 0, true)
        return false
    end
    outputChatBox("[System]#ffffff Shoma Vared #ffff00RP Pause#ffffff Shodid.", thePlayer, 255, 255, 0, true)
    setElementDimension(thePlayer, 1)
end


function leave(thePlayer)
    setElementDimension(thePlayer, 0)
    if isPedInVehicle(thePlayer) or getElementType(thePlayer) == "vehicle" then
        return false
    end
    outputChatBox("[System]#ffffff Shoma Az #00ff00RP Pause#ffffff Kharej Shodid.", thePlayer, 0, 255, 0, true)
end


function quit()
    setElementDimension(source, 0)
    removeEventHandler("onPlayerQuit", source, quit)
    local marker = getElementData(source, "rppause")
    local markerdim = getElementData(marker, "rppause")
    if markerdim then
        removeElementData(marker, "rppause")
        setElementPosition(markerdim, 0, 0, 0)
        destroyElement(markerdim)
    end
    removeEventHandler("onPlayerQuit", thePlayer, quit)
    destroyElement(marker)
end


function pause(thePlayer, commandName, size)
    -- if not exports.global:isStaffOnDuty(thePlayer) then
    --     return false
    -- end

    size = tonumber(size)
    if not (size) or size < 2 or size > 15 then
        outputChatBox("SYNTAX: /" .. commandName .. " [Size (2 ~ 15)]", thePlayer, 255, 194, 14)
    else
        if getElementData(thePlayer, "rppause") then
            outputChatBox("[System]#ffffff Shoma #ff0000RP Pause#ffffff Darid.", thePlayer, 255, 0, 0, true)
            return false
        end

        local r, g, b = getPlayerNametagColor(thePlayer)
        local x, y, z = getElementPosition(thePlayer)
        local marker = createMarker(x, y, z - 1, "cylinder", size, r, g, b, 50)
        local markerdim = createMarker(x, y, z - 1, "cylinder", size, 255, 255, 255, 50)
        local playerid = tostring(getElementData(thePlayer, "playerid")) or "Unknown"
        setElementData(thePlayer, "rppause", marker)
        setElementData(marker, "rppause", markerdim)
        setElementDimension(markerdim, 1)
        addEventHandler("onPlayerQuit", thePlayer, quit)
        addEventHandler("onMarkerHit", marker, join)
        addEventHandler("onMarkerLeave", markerdim, leave)
    end
end
addCommandHandler("rpp", pause, false, false)


function resume(thePlayer, commandName)
    -- if not exports.global:isStaffOnDuty(thePlayer) then
    --     return false
    -- end
    local marker = getElementData(thePlayer, "rppause")
    if not marker then
        outputChatBox("[System]#ffffff Shoma #ff0000RP Pause#ffffff Nadarid.", thePlayer, 255, 0, 0, true)
        return false
    end

    local markerdim = getElementData(marker, "rppause")
    local playerid = tostring(getElementData(thePlayer, "playerid")) or "Unknown"
    if markerdim then
        removeElementData(marker, "rppause")
        setElementPosition(markerdim, 0, 0, 0)
        destroyElement(markerdim)
    end
    removeElementData(thePlayer, "rppause")
    removeEventHandler("onPlayerQuit", thePlayer, quit)
    destroyElement(marker)
end
addCommandHandler("rpu", resume, false, false)