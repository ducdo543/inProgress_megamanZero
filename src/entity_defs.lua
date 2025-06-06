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
                frames = {1, 2, 3, 4 ,5 ,6},
                interval = 0.07,
                texture = 'player-jump-fall',
                ratio = 5/138
            },
            ['fall'] = {
                frames = {1, 2, 3, 4 ,5 ,6},
                interval = 0.07,
                texture = 'player-jump-fall',
                ratio = 5/138
            }
        }
    }
}

