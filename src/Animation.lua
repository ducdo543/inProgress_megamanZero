Animation = Class{}

function Animation:init(def)
    self.texture = def.texture
    self.frames = def.frames
    self.interval = def.interval
    self.ratio = def.ratio
    self.timer = 0
    self.currentFrame = 1

    self.looping = def.looping or true
    -- count number of looping
    self.timesPlayed = 0 

    -- information related to animations when almost done or done shortly after one state (actually dont need)
    self.flag_specialAnimation = false
    self.special_frames = def.special_frames
    self.special_interval = def.special_interval
    self.special_currentFrame = 1
end

function Animation:update(dt)
    -- return if animation don't loop again
    if not self.looping and self.timesPlayed > 0 then 
        return 
    end

    -- handle special animations
    if self.flag_specialAnimation == true then
        if #self.special_frames > 1 then
            self.timer = self.timer + dt

            if self.timer > self.special_interval then
                self.timer = self.timer % self.special_interval

                self.special_currentFrame = math.max(1, (self.special_currentFrame + 1) % (#self.special_frames + 1))
            end
        end
        return
    end

    -- no need to update if animation is only one frame
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            -- when go to the next loop, record
            if self.currentFrame == 1 then 
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    if self.flag_specialAnimation == true then
        return self.special_frames[self.special_currentFrame]
    end

    return self.frames[self.currentFrame]
end