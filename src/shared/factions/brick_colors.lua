local usedColors = {[BrickColor.Gray().Number] = true}

function getColor(choice: string | nil): BrickColor
    local color = choice and tonumber(choice) and BrickColor.new(tonumber(choice)) or BrickColor.new(choice)
    if color and not usedColors[color.Number] then
        return color
    else
        for i = 1, 1032 do
            if not usedColors[i] then
                color = BrickColor.new(i)
                if not usedColors[color.Number] then
                    usedColors[color.Number] = true
                    return color
                end
            end
        end
        error("No available colors!")
    end
end

return { getColor = getColor }