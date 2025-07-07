BaseHitbox = Class{}

function BaseHitbox:init(def)
    if type(def) == 'function' then 
        self.lazy_def = def 
        def = def()
    end
    
    self.dx = def.dx 
    self.dy = def.dy 
    
    -- flag movement target like bullet
    self.movement = def.movement 

    -- flag stick hitbox with player during slash state
    self.flag_stick = def.flag_stick
    if self.flag_stick == true then 
        assert(self.lazy_def, 'missing lazy_def, def must be a call-back function')
    end   
    
    -- to delete hitbox after some time 
    self.time_disappear = def.time_disappear or nil
    self.time_accumulate = 0    

    -- what type of slash and ability is mark in hitbox
    self.type_slash = def.type_slash or nil
    self.can_push = def.can_push or false
    -- what damage hitbox cause
    self.damage = def.damage or 0

    -- what attack_id is mark in hitbox to find and remove the same attack_id when done
    self.attack_id = def.attack_id or nil

    -- remove from table hitboxes when true
    self.flag_finished = false

    -- retent entities that being hit cause we just want this hitbox hit each entity 1 time.
    self.wasHitted_entities = {} -- structure lookup like self.wasHitted_entities[enermy] = true
end

function BaseHitbox:update(dt)
    
end

function BaseHitbox:check_whether_finish(dt)
    self.time_accumulate = self.time_accumulate + dt     
    if self.time_disappear and self.time_accumulate >= self.time_disappear then
        self.flag_finished = true 
    end
end

function BaseHitbox:isFinished()
    return self.flag_finished
end