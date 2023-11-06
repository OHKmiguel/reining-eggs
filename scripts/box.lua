player = {}

function player:load()
    player.x = love.graphics.getWidth()/2
    player.y = 700
    player.speed = 250
    player.w = 60
    player.h = 60
    player.freemoving = false
    player.spritesheet = love.graphics.newImage("assets/boxSpritesheet.png")
    player.grid = anim8.newGrid(100,79,player.spritesheet:getWidth(),player.spritesheet:getHeight())
    player.scale = 1.1
    player.textscale = 1.2
    player.textcolorred = 0
    player.textcolorgreen = 1
    player.textcolorblue = 0
    player.animations = {}
    player.animations.default = anim8.newAnimation(player.grid('1-2',1), 0.2)
end

function player:draw()
    player.animations.default:draw(player.spritesheet,player.x,player.y,nil,player.scale)
    love.graphics.setColor(1,0,0,0)
    --player collision box
    love.graphics.rectangle("fill",player.x+24,player.y+14,player.w,player.h)
    love.graphics.setColor(1,0,0,1)
    love.graphics.setColor(player.textcolorred,player.textcolorgreen,player.textcolorblue,1)
    love.graphics.print(score,player.x,player.y,0,player.textscale,player.textscale)
    

end

function player:move(dt)
    local dx, dy = 0, 0
    
	if love.keyboard.isDown("d")  then 
        dx = 1
        
    end
	if love.keyboard.isDown("a") and player.x >= -10 then 
        dx = -1 
    end
    if freemoving == true then
        if love.keyboard.isDown("s") then 
            dy = 1 
        end
        if love.keyboard.isDown("w") then 
            dy = -1 
        end
    end
    local magnitude = math.sqrt(dx^2 + dy^2)
    if magnitude > 0 then
        -- Normalize the movement vector and apply the speed
        dx, dy = dx / magnitude, dy / magnitude
    
        player.x = player.x + dx * player.speed * dt
        player.y = player.y + dy * player.speed * dt

    end

    player.animations.default:update(dt)
end