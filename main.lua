

function love.load()
    --lvl creator specific vars
    showData = false
    lvlName = "unsaved level"
    state = "lvl" --gamestates: lvl, inp
    inpStr = ""
    inpVar = ""

    --level display setup
    setTileset("tilesetBase.png")
    
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setFullscreen(1, "desktop")

    scrWid = love.window.getWidth()
    scrHei = love.window.getHeight()

    --amount of tiles shown in each dimension
    sqByWid = 32
    sqByHei = 18

    sbWid = sb_base:getWidth()
    sbHei = sb_base:getHeight()

    sqWid = scrWid / sqByWid
    sqHei = scrHei / sqByHei
end


function setTileset(fileName)
    tilesetName = fileName
    sb_base = love.graphics.newImage(tilesetName)
    sb = love.graphics.newSpriteBatch(sb_base, 256, 'static')
end


function love.keypressed(key)
    if state == "lvl" then
        if key == "1" then --toggle display
            showData = not showData
        elseif key == "n" then
            getInput("lvlName")
        end
    elseif state == "inp" then
        handleTextBoxInput(key)
    end
end


function love.update()

end


function handleTextBoxInput(key)
    if key == "escape" then --return failure
        state = "lvl"
    elseif key == "return" then --return success
        state = "lvl"
        _G[inpVar] = inpStr
    elseif key == "backspace" then
        inpStr = inpStr:sub(1, #inpStr-1)
    else
        inpStr = inpStr .. key
    end
end


function getInput(var)
    state = "inp"
    inpStr = ""
    inpVar = var
end


function max(a, b)
    if a > b then return a
    else return b end
end


function love.draw()
    love.graphics.push()
    love.graphics.scale(scrWid/128/sqByWid, scrHei/128/sqByHei)
    for x = 0, sqByWid do
        for y = 0, sqByHei do
            local q = love.graphics.newQuad(x*128 % 2048, y*128 % 2048, 128, 128, sbWid, sbHei)
            love.graphics.draw(sb_base, q, 128*x, 128*y)
        end
    end
    love.graphics.pop()

    if state == "lvl" then
        if showData then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", 25, 25, max(#lvlName+12, #tilesetName+9)*7, 40)
            love.graphics.setColor(255, 255, 255)
            
            love.graphics.print("Level name: " .. lvlName, 30, 30)
            love.graphics.print("Tileset: " .. tilesetName, 30, 45)
        end
    elseif state == "inp" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 25, 25, (#inpVar + #inpStr + 3)*6+10, 25)
        love.graphics.setColor(255, 255, 255)
        love.graphics.print(inpVar .. ": " .. inpStr .. "_", 30, 30)
    end
end
