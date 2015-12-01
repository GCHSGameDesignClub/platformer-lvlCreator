

function love.load()
    --lvl creator specific vars
    showData = false
    lvlName = "unsaved level"
    state = "lvl" --gamestates: lvl, inp
    
    --used in text boxes
    inpStr = "" --buffer string
    inpVar = "" --variable to update

    --level display setup
    setTileset("tilesetBase.png")
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setFullscreen(1, "desktop")

    scrWid = love.window.getWidth()
    scrHei = love.window.getHeight()

    --amount of tiles shown in each dimension
    sqByWid = 32
    sqByHei = 18

    --number of tiles by width and height in the level
    lvlWid = sqByWid
    lvlHei = sqByHei
    updateTileIndexes()

    --x and y offset used for scrolling through the level
    xoffset = 0
    yoffset = 0
    offsetIncr = 5

    sqWid = scrWid / sqByWid
    sqHei = scrHei / sqByHei
end

function updateTileIndexes()
    --table containing the spritesheet index for each tile
    tiles = {}
    for i = 1, lvlWid+1 do
        tiles[i] = {}
        for j = 1, lvlHei+1 do
            tiles[i][j] = 0
        end
    end
end

function setTileset(fileName)
    tilesetName = fileName
    sb_base = love.graphics.newImage(tilesetName)
    sb = love.graphics.newSpriteBatch(sb_base, 256, 'static')
    sbWid = sb_base:getWidth()
    sbHei = sb_base:getHeight()
end


function love.keypressed(key)
    if state == "lvl" then
        if key == "1" then --toggle display
            showData = not showData
        elseif key == "n" then
            setState("inp", "lvlName")
        elseif key == "x" then
            setState("inp", "lvlWid")
        elseif key == "y" then
            setState("inp", "lvlHei")
        end
    elseif state == "inp" then
        handleTextBoxInput(key)
    end
end


function love.update()
    if love.keyboard.isDown("a") then
        xoffset = xoffset - offsetIncr
    end
    if love.keyboard.isDown("d") then
        xoffset = xoffset + offsetIncr
    end
    if love.keyboard.isDown("w") then
        yoffset = yoffset - offsetIncr
    end
    if love.keyboard.isDown("s") then
        yoffset = yoffset + offsetIncr
    end
end


function handleTextBoxInput(key)
    if key == "escape" then --return failure
        setState("lvl")
    elseif key == "return" then --return success
        setState("lvl")
        _G[inpVar] = inpStr
        if inpVar == "lvlWid" or inpVar == "lvlHei" then
            updateTileIndexes()
        end
    elseif key == "backspace" then --remove last character
        inpStr = inpStr:sub(1, #inpStr-1)
    else
        inpStr = inpStr .. key
    end
end


function setState(newState, metadata)
    if newState == "inp" then
        inpStr = ""
        inpVar = metadata
    end

    state = newState
end


function max(a, b)
    if a > b then return a
    else return b end
end


function love.draw()
    love.graphics.translate(xoffset, yoffset)
    
    
    --draw every tile
    love.graphics.push()
    love.graphics.scale(scrWid/128/sqByWid, scrHei/128/sqByHei)
    for x = 0, lvlWid do
        for y = 0, lvlHei do
            local tile = tiles[x+1][y+1]
            local q = love.graphics.newQuad(128*(tile%16), 128*(tile/16), 128, 128, sbWid, sbHei)
            love.graphics.draw(sb_base, q, 128*x, 128*y)
        end
    end

    love.graphics.pop()

    --reset the translation above to always draw the
    --data box at the same place
    love.graphics.origin()

    if state == "lvl" then
        if showData then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", 25, 25, max(#lvlName+12, #tilesetName+9)*7, 75)
            love.graphics.setColor(255, 255, 255)
            
            love.graphics.print("Level name: " .. lvlName, 30, 30)
            love.graphics.print("Level width: " .. lvlWid, 30, 45)
            love.graphics.print("Level height: " .. lvlHei, 30, 60)
            love.graphics.print("Tileset: " .. tilesetName, 30, 75)
        end
    elseif state == "inp" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 25, 25, (#inpVar + #inpStr + 3)*6+10, 25)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print(inpVar .. ": " .. inpStr .. "_", 30, 30)
    end
end
