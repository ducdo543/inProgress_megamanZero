ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 60,
        jump_velocity = -150,
        animations = {
            ['walk'] = {
                frames = {2, 3, 4, 5, 6, 7, 8, 9, 10, 12},
                interval = 0.07,
                texture = 'player-walk',
                ratio = 1/5
            },
            ['idle'] = {
                frames = {1, 2, 3, 4 ,5 ,6},
                interval = 0.12,
                texture = 'player-idle',
                ratio = 1/5
            },
            ['jump'] = {
                frames = {1, 2, 3, 4},
                interval = 0.07,
                texture = 'player-jump-fall',
                ratio = 25/(155-15), -- height virtual = 25, height window size = 140
                special_frames = {5}
            },
            ['fall'] = {
                frames = {7, 8, 9, 10},
                interval = 0.07,
                texture = 'player-jump-fall',
                ratio = 25/(155-15)
            }
        }
    }
}

