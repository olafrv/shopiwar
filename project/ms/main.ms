init = function()
  hits = 0
  mouse_icon = "mnone"
  entities = []
  enemies = ["amazon","shopify", "ebay","shopify", "mercadolibre", "shopify"]
  misiles = []
  jet =  new Friend("jet")
  enemy = new Enemy(enemies)
  entities.push(jet)
  entities.push(enemy)
  thread = every 1500 do
    enemy.update_position()
  end
  audio.playMusic("fluffingaduck", 0.1, 1)
end

update = function()
  local mouse_x = floor(mouse.x)
  local mouse_y = floor(mouse.y)
  jet.x = mouse_x
  jet.y = mouse_y
  for m in misiles
    if m.in_collision(enemy) then
      m.destroyed = true
      enemy.destroyed = true
    end
  end
  if mouse.right == 1 then
    mouse_icon = "mright"
    enemy.switch(enemies)
  elsif mouse.left == 1 then
    mouse_icon = "mleft"
    local misile = new Misile("misile", mouse_x, mouse_y)
    misiles.push(misile)
    entities.push(misile)
  else
    mouse_icon = "mnone"
  end
end

draw = function()
  screen.clear()
  screen.drawText("Hits: " + hits, screen.width/2-75,screen.height/2-20, 30, "#FFF")
  screen.drawSprite(mouse_icon, screen.width/2-24, -(screen.height/2-24), 24, 24)
  for i in entities
    if i.destroyed then
      if i.name != "misile" then
        screen.drawSprite("explosion2", i.x, i.y)
        i.switch(enemies)
        i.destroyed = false
        hits += 1
      else
        screen.drawSprite("explosion1", i.x, i.y)
        entities.removeElement(i)
        misiles.removeElement(i)
      end
    else
      screen.drawSprite(i.name, i.x, i.y, i.w, i.h)
    end
  end
end