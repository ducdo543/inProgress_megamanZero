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
                ratio = 1/5,
                offsetX = 8,
                offsetY = 0
            },
            ['jump'] = {
                name = 'player-jump',
                frames = {1, 2, 3, 4},
                interval = 0.07,
                texture = 'player-jump-fall',
                ratio = 25/(155-15), -- height virtual = 25, height window size = 140
                special_frames = {5},
                offsetX = 8,
                offsetY = 3
            },
            ['fall'] = {
                frames = {7, 8, 9, 10},
                interval = 0.07,
                texture = 'player-jump-fall',
                ratio = 25/(155-15),
                special_frames = {11, 12}, 
                special_interval = 0.07,
                offsetX = 8,
                offsetY = 3                
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
                frames = {2, 3, 4, 5, 6, 7, 8},
                interval = 0.28/7, -- 0.04
                texture = 'player-normal-slash',
                looping = false,
                ratio = 1/5
            },
            ['normal-slash2'] = {
                frames = {9, 10, 11, 12, 13, 14, 15},
                interval = 0.28/7, --0.04
                texture = 'player-normal-slash',
                looping = false,
                ratio = 1/5                
            },
            ['normal-slash3'] = {
                frames = {20, 21, 22, 23, 24, 25, 26, 27, 28},
                interval = 0.2/5, -- 0.04
                texture = 'player-normal-slash',
                looping = false,
                ratio = 1/5                
            },
            ['beHitted'] = {
                frames = {1, 2, 3},
                interval = 0.04,
                texture = 'player-beHitted',
                looping = true,
                ratio = 1/5,
                offsetX = 6,
                offsetY = 1
            },
            ['sting'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9},
                interval = 0.017,
                texture = 'player-sting',
                looping = false,
                ratio = 1/5
            },
            ['dash-slash'] = {
                frames = {1, 2, 3, 4, 5, 6, 7},
                interval = 0.04,
                texture = 'player-dash-slash',
                looping = false,
                ratio = 1/5,
                offsetX = 10,
                offsetY = 14
            },
            ['air-slash'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.03,
                texture = 'player-air-slash',
                looping = false,
                ratio = 1/5,
                offsetX = 12,
                offsetY = 10
            },
            ['load1-slash'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
                interval = 0.04,
                texture = 'player-load1-slash',
                looping = false,
                ratio = 1/5,
                offsetX = 8,
                offsetY = 30
            },
            ['load2-slash'] = {
                frames = {1, 2, 3, 4, 5, 6, 7},
                interval = 0.04,
                texture = 'player-load2-slash',
                looping = false,
                ratio = 1/5,
                offsetX = 8,
                offsetY = 30
            }
        }
    },
    ['enermy2'] = {
        animations = {
            ['idle'] = {
                frames = {1},
                texture = 'enermy2-idle-beHitted',
                ratio = 1/5,
                offsetX = 8,
                offsetY = 0
            },
            ['beHitted'] = {
                frames = {2},
                texture = 'enermy2-idle-beHitted',
                ratio = 1/5,
                offsetX = 8,
                offsetY = 0
            },
            ['death1'] = {
                frames = {}, -- not for looping, but each frame is for each debri
                texture = 'enermy2-death1',
                ratio = 1/5  
            },
            ['explode'] = {
                frames = {1, 2, 3, 4, 5, 6},
                texture = 'effect-explode',
                interval = 0.03,
                looping = true,
                ratio = 1/10,
                offsetX = 10,
                offsetY = 0
            }
        }
    },
    ['effects'] = {
        animations = {
            ['explode'] = {
                frames = {1, 2, 3, 4, 5, 6},
                texture = 'effect-explode',
                interval = 0.03,
                looping = true,
                ratio = 1/10,
                offsetX = 10,
                offsetY = 0
            },
            ['smoke'] = {
                frames = {1, 2, 3, 4},
                texture = 'effect-smoke',
                interval = 0.03,
                looping = false,
                ratio = 1/5,
                offsetX = 5,
                offsetY = 5
            },
            ['energyAbsorb1'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
                texture = 'effect-energyAbsorb',
                interval = 0.04,
                looping = true,
                ratio = 1/5,
                offsetX = 20,
                offsetY = 20
            },
            ['energyAbsorb2'] = {
                frames = {14, 13, 12, 11},
                texture = 'effect-energyAbsorb',
                interval = 0.04,
                looping = true,
                ratio = 1/5,
                offsetX = 20,
                offsetY = 20
            }
        }
    }
}

