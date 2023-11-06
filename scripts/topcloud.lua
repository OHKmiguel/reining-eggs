topcloud = {}


function topcloud:load()
    topcloud.x = 0
    topcloud.y = 0
    topcloudImage = love.graphics.newImage("assets/cloud.png")

    
end

function topcloud:tween()
    function move_down()
        flux.to(topcloud,1,{y=0}):ease("sineinout"):delay(0.1):oncomplete(move_up)
    end
    function move_up()
        flux.to(topcloud, 1, { y = -20 }):ease("sineinout"):delay(0.1):oncomplete(move_down)
    end
    
    move_up()

end
function topcloud:draw()
    love.graphics.draw(topcloudImage,topcloud.x,topcloud.y,0)
    

end
