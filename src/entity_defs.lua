ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = 60,
        jump_velocity = -150,
        dashSpeed = 150,
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
                ratio = 25/(155-15),
                special_frames = {11, 12}, 
                special_interval = 0.07
            },
            ['dash'] = {
                frames = {2, 3, 4 ,5},
                interval = 0.07,
                texture = 'player-dash',
                ratio = 1/5
            },
            ['special_idlewalkToDash'] = {
                frames = {1},
                interval = 0.07,
                texture = 'player-dash',
                ratio = 1/5
            },
            ['special_dashToIdle'] = {
                frames = {6, 7},
                interval = 0.05,
                texture = 'player-dash',
                ratio = 1/5
            },
            ['normal-slash1'] = {
                frames = {2, 3, 4, 5, 6},
                interval = 0.3/5,
                texture = 'player-normal-slash',
                ratio = 1/5
            },
            ['normal-slash2'] = {
                frames = {9, 10, 11, 12, 13},
                interval = 0.3/5,
                texture = 'player-normal-slash',
                ratio = 1/5                
            },
            ['normal-slash3'] = {
                frames = {18, 19, 20, 21, 22, 23, 24, 25},
                interval = 0.3/8,
                texture = 'player-normal-slash',
                ratio = 1/5                
            }
        }
    }
}

