utf8 = require("utf8")
flux = require("scripts/flux")
Topcloud = require("scripts/topcloud")
Box = require("scripts/box")
Player = require("scripts/box")
Egg = require("scripts/egg")
Timer = require("scripts/timer")
collision = require("scripts/collision")
gamestate = {
    start = true,
    game = false,
    gameEnd = false
}

function love.load()
    math.randomseed(os.time()) 
    fps = love.timer.getFPS( )
    
    font = love.graphics.newFont("font/monofonto.otf",30)
    love.graphics.setFont(font)
    
    anim8 = require("scripts/anim8")
    
    backgroundImage = love.graphics.newImage("assets/background.png")
    backgroundMusic = love.audio.newSource("sounds/reining;;eggs.wav","stream")
    backgroundMusic:setLooping(true)
    
    backgroundMusic:setVolume(0.6)
    
    typingSound = love.audio.newSource("sounds/blipSelect.ogg","static")
    typingSound:setVolume(0.3)
    backspaceSound = love.audio.newSource("sounds/blipSelect.ogg","static")
    backspaceSound:setVolume(0.3)
    collectSound = love.audio.newSource("sounds/pickupCoin.ogg","static")
    collectSound:setVolume(0.5) 
    collectSound:setPitch(0.5)
    GoldeneggCollect = love.audio.newSource("sounds/GoldenCollect.ogg","static")
    ThiefeggCollect = love.audio.newSource("sounds/hitHurt.ogg","static")
    alert = love.audio.newSource("sounds/alert.ogg","stream")
    alert:setPitch(0.5)
    topcloud:tween()
    topcloud:load()
    player:load()
    
    
end

function love.update(dt)
    flux.update(dt)
    Timer.update(dt)
    
    if gamestate.start then
        player.health = 4
        for i in pairs(NORMALeggs) do 
            NORMALeggs[i] = nil
        end
        for i in pairs(THIEFeggs) do 
            THIEFeggs[i] = nil
        end
        for i in pairs(GOLDENeggs) do 
            GOLDENeggs[i] = nil
        end
        score = 0
        eggcollected = 0

        eggcollected = eggcollected * 0 + 0 

        
        gamestate.gameEnd = false
        gamestate.game = false
        gamestate.start = true
        difficultyTimer = 0
        NORMALegginterval = 0.5
        NORMALeggtimer = 0
        GOLDENegginterval = 70
        GOLDENeggtimer = 0
        THIEFegginterval = 0.6
        THIEFeggtimer = 0
        countdowntimer = 121
        countdowntimertxtcolor = {0,0,0}
        alertplay = false
        alertCooldown = 0
        backgroundMusic:stop()
    end
    if gamestate.game then
        player:move(dt)
        eggupdate(dt)
        backgroundMusic:play()
        countdowntimerposition = love.graphics.getWidth()/2-5
        
        countdowntimer = countdowntimer - dt
        alertCooldown = alertCooldown - dt
        if alertCooldown < 0 then
            alertCooldown = 0
        end

        if alertCooldown <= 0 and countdowntimer <= 11 then
            alert:play()
            alertCooldown = 1  
        end

        if countdowntimer <= 0 then
            gamestate.start = false
            gamestate.gameEnd= true
            gamestate.game = false
        end
    end

        
    if gamestate.gameEnd then
        backgroundMusic:stop()
        
    end
end

function love.draw()
    love.graphics.draw(backgroundImage,0,0,0)
    
    if gamestate.start then
        for i = 1, 5 do
            love.graphics.print("reining;;\neggs",10,10,0,2,2)
            
        end
        
        
        love.graphics.setColor(0,1,0)
        love.graphics.setColor(1,1,1)
        love.graphics.print("enter to play",300,750,0,1.5,1.5)
    end
    if gamestate.game == true then
        eggdraw()
        love.graphics.setColor(1,1,1,1)
        topcloud:draw()
        player:draw()
        
        love.graphics.setColor(0,0,0,1)
        love.graphics.print("FPS " .. (love.timer.getFPS( )), 0.1, 0.1)
        
        if countdowntimer <= 11 then
            countdowntimertxtcolor = {255,0,0}
        end

        
        love.graphics.setColor(countdowntimertxtcolor)
        love.graphics.print(math.floor(countdowntimer),love.graphics.getWidth()/2-50,0,0,2,2)
        love.graphics.setColor(1,1,1,1)
    end 
    
    if gamestate.gameEnd then
        for i = 1,5 do 
            love.graphics.print("score: " .. score,10,10,0,1.5,1.5)
            love.graphics.print("eggs collected: " .. eggcollected,10,100,0,1.5,1.5)
        end
        love.graphics.print("press space\nfor start menu",10,600,0,1.5,1.5)
        
    end
end






function love.keypressed(key)
    if key == "return" then
        if gamestate.start then
            print("game")
            gamestate.gameEnd = false
            gamestate.start = false
            gamestate.game = true
        end

    end
    if key == "space" then
        if gamestate.gameEnd then
            gamestate.gameEnd = false
            gamestate.start = true
            gamestate.game = false
        end
    end

    
end