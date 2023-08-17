MySprite = class
  constructor = function(name)
    this.name = name
    this.x = 0
    this.y = 0
    this.w = sprites[name].width
    this.h = sprites[name].height
    this.step = 5
    this.destroyed = false
  end
  switch = function(name)
    this.name = name
  end
  in_collision = function(my_sprite)
    local distance = floor(sqrt(pow(this.x - my_sprite.x,2)+ pow(this.y - my_sprite.y,2)))
    local distance_min = floor(max(this.w,this.h)/2 + max(my_sprite.w, my_sprite.h)/2)
    if distance <= distance_min then
      return true
    else
      return false
    end
  end
end

Friend = class extends MySprite
  constructor = function(name)
    super(name)
    this.w = 48
    this.h = 48
  end
  left = function()
    this.x -= this.step
  end
  right = function()
    this.x += this.step
  end
  down = function()
    this.y -= this.step
  end
  up = function()
    this.y += this.step
  end
end

Misile = class extends MySprite
  constructor = function(name, x, y)
    super(name)
    this.x = x
    this.y = y
    this.step = 10
    this.w = 24
    this.h = 24
    flying = every 50 do
      this.fly()
    end
    audio.playSound("missile", 0.1, 1, 0, 0)    
  end
  fly = function()
    if this.destroyed == false then
      if this.y + this.step < floor(screen.height/2) then
        this.y += this.step
      else
        this.flying.stop()
        this.destroyed = true
      end
    end
  end
end

Enemy = class extends MySprite
  constructor = function(enemies)
    super(this.switch(enemies))
    this.w = 48
    this.h = 48
  end
  switch = function(names)
    local index = random.nextInt(names.length)
    this.name = names[index]
    return this.name
  end
  update_position = function()
      local direction = random.nextInt(2)
      if direction != 1 then direction = -1 end
      this.x = random.nextInt(floor(screen.width/2)) * direction
      this.y = random.nextInt(floor(screen.height/2))
  end
end
