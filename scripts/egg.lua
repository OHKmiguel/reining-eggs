NORMALeggs = {}
GOLDENeggs = {}
THIEFeggs = {}

difficultyTimer = 0
NORMALegginterval =  0.6
NORMALeggtimer = 0
GOLDENegginterval = 70
GOLDENeggtimer = 0
THIEFegginterval = 0.5
THIEFeggtimer = 0
function NORMALeggspawn()
    NORMALegg = {
        x = math.random(0,550),
        y = 30,
        w = 45,
        h = 60,
        fall = math.random(120,200),
        eggImage = love.graphics.newImage("assets/egg.png"),
        value = 50,
        
    }
    table.insert(NORMALeggs,NORMALegg)
end
function GOLDENeggspawn()
    GOLDENegg = {
        x = math.random(0,550), 
        y = 30,
        w = 45,
        h = 60, 
        fall = 500,
        eggImage = love.graphics.newImage("assets/golden_egg.png"),
        value = 899,
    }

    table.insert(GOLDENeggs,GOLDENegg)
end
function THIEFeggspawn()
    THIEFegg = {
        x = math.random(0,550),
        y = 30, 
        w = 45,
        h = 60,
        fall = 200,
        eggImage = love.graphics.newImage("assets/thief_egg.png"),
        value = -35,
    }

    table.insert(THIEFeggs,THIEFegg)
end




function eggupdate(dt)
    
    
    NORMALeggtimer = NORMALeggtimer + dt
    GOLDENeggtimer = GOLDENeggtimer + dt
    THIEFeggtimer = THIEFeggtimer + dt

    difficultyTimer = difficultyTimer + dt
    
    

    if NORMALeggtimer >= NORMALegginterval then
        NORMALeggtimer = 0
        
        NORMALeggspawn()
    end
    if GOLDENeggtimer >= GOLDENegginterval then
        GOLDENeggtimer = 0
        GOLDENeggspawn()
    end

    if THIEFeggtimer >= THIEFegginterval then
        THIEFeggtimer = 0
        THIEFeggspawn()
    end


    if difficultyTimer >= 30 and THIEFegginterval >= 0.4 then
        THIEFegginterval = THIEFegginterval - 0.1
        difficultyTimer = 0
    end

    if difficultyTimer >= 30 and NORMALegginterval >= 0.5 then
        NORMALegginterval = NORMALegginterval - 0.1
        difficultyTimer = 0
    end
    print(THIEFegginterval)

    for i,GOLDENegg in ipairs(GOLDENeggs) do 
        GOLDENegg.y = GOLDENegg.y + GOLDENegg.fall * dt
        if GOLDENegg.y > love.graphics.getHeight() then
            table.remove(GOLDENeggs,i)
        end

      
        if CheckCollision(GOLDENegg.x,GOLDENegg.y,GOLDENegg.w,GOLDENegg.h, player.x,player.y,player.w,player.h) then
            table.remove(GOLDENeggs,i)
            score = score + GOLDENegg.value
            eggcollected = eggcollected + 1
            
            GoldeneggCollect:stop()
            GoldeneggCollect:play()

            player.textcolorred = 1
            player.textcolorgreen = 1
            
        end
    end

    for i,NORMALegg in ipairs(NORMALeggs) do 
        NORMALegg.y = NORMALegg.y + NORMALegg.fall * dt

        if NORMALegg.y > love.graphics.getHeight() then
            table.remove(NORMALeggs,i)
        end

         
        if CheckCollision(NORMALegg.x,NORMALegg.y,NORMALegg.w,NORMALegg.h, player.x,player.y,player.w,player.h) then
            table.remove(NORMALeggs,i)
            score = score + NORMALegg.value
            
            eggcollected = eggcollected + 1 
            
            player.textcolorred = 0
            player.textcolorgreen = 1
            collectSound:stop()
            collectSound:play()
        end

        
    end
    
    for i,THIEFegg in ipairs(THIEFeggs) do 
        THIEFegg.y = THIEFegg.y + THIEFegg.fall * dt

        if THIEFegg.y > love.graphics.getHeight() then
            table.remove(THIEFeggs,i)
        end

         
        if CheckCollision(THIEFegg.x,THIEFegg.y,THIEFegg.w,THIEFegg.h, player.x,player.y,player.w,player.h) then
            table.remove(THIEFeggs,i)
            score = score + THIEFegg.value
            
            player.textcolorred = 1
            player.textcolorgreen = 0
            ThiefeggCollect:stop()
            ThiefeggCollect:play()
            
            
        end
        
    end
    
    
    
end
function eggdraw()
    for i,NORMALegg in ipairs(NORMALeggs) do
        love.graphics.setColor(1,1,1,1)
       
        love.graphics.draw(NORMALegg.eggImage,NORMALegg.x,NORMALegg.y)
        love.graphics.print(NORMALegg.value,NORMALegg.x,NORMALegg.y,0,0.5,0.5)

        love.graphics.setColor(1,1,1,0)
        love.graphics.rectangle("fill",NORMALegg.x+13,NORMALegg.y+6,NORMALegg.w,NORMALegg.h) 
        
    
    end

    for i,GOLDENegg in ipairs(GOLDENeggs) do
        love.graphics.setColor(1,1,1,1)
       
        love.graphics.draw(GOLDENegg.eggImage,GOLDENegg.x,GOLDENegg.y)
        love.graphics.print(GOLDENegg.value,GOLDENegg.x,GOLDENegg.y,0,1.2,1.2)

        love.graphics.setColor(1,1,1,0)
        love.graphics.rectangle("fill",GOLDENegg.x+13,GOLDENegg.y+5,GOLDENegg.w,GOLDENegg.h) 
        
    
    end

    for i,THIEFegg in ipairs(THIEFeggs) do
        love.graphics.setColor(1,1,1,1)
        
        love.graphics.draw(THIEFegg.eggImage,THIEFegg.x,THIEFegg.y)
        love.graphics.print(THIEFegg.value,THIEFegg.x,THIEFegg.y,0,0.5,0.5)

        love.graphics.setColor(1,1,1,0)
        love.graphics.rectangle("fill",THIEFegg.x+13,THIEFegg.y+5,THIEFegg.w,THIEFegg.h) 
        
    
    end

end