function init(plugin)
  print("Plugin Initialization")

  plugin:newCommand{
    id="DungeondraftEffect",
    title="Dungeondraft Effect",
    group="edit_fx",
    onclick=dungeondraft_effect
  }
end

function dungeondraft_effect()
    if not app.activeSprite then
  		app.alert("There are no sprites to apply the effect to")
  		return
	end

    local dialog = Dialog("Dungeondraft Effect")
	 dialog:slider{ id="factor", label="Factor:", min=1, max=20, value=10, focus=false }
	 dialog:button{ id="ok", text="&OK", focus=true }
	 dialog:button{ text="&Cancel" }
	 dialog:show()

	local data = dialog.data
	if not data.ok then return end

	local factor = data.factor
	local sprite = app.activeSprite
    local cel = app.activeCel
	local image = Image(cel.image.width, cel.image.height, cel.image.colorMode)
                
    for x = 0, cel.image.width do
    	for y = 0, cel.image.height do

        	local alpha = app.pixelColor.rgba(0, 0, 0, 0)  

        	if cel.image:getPixel(x, y) ~= alpha then
        		if x == 0 or y == 0 or x == cel.image.width - 1 or y == cel.image.height - 1 or cel.image:getPixel(x - 1, y) == alpha or cel.image:getPixel(x + 1, y) == alpha or cel.image:getPixel(x, y - 1) == alpha or cel.image:getPixel(x, y + 1) == alpha then 
               		if math.random(0, 100) < factor then
               			image:drawPixel(x, y, alpha)
               		else
               			image:drawPixel(x, y, cel.image:getPixel(x, y))
               		end
        		else
        			image:drawPixel(x, y, cel.image:getPixel(x, y))
        		end  
    		end
    	end
	end
      
    cel.image = image
    app.refresh()
end

function exit(plugin)
  print("Effect applied")
end