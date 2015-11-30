

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    sb_base = love.graphics.newImage('tilesetCheckerboard.png')

    love.window.setFullscreen(1, "desktop")
    sb = love.graphics.newSpriteBatch(sb_base, 256, 'static')

    scrWid = love.window.getWidth()
    scrHei = love.window.getHeight()

    sqByWid = 32
    sqByHei = 18

    sbWid = sb_base:getWidth()
    sbHei = sb_base:getHeight()

    sqWid = scrWid / sqByWid
    sqHei = scrHei / sqByHei
end



function love.update()

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
end
