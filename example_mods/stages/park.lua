function onCreate()
	makeLuaSprite('sky', 'sky', 30, 0)
	addLuaSprite('sky', false)
	setScrollFactor('sky', 0.5, 1.0)

	makeAnimatedLuaSprite('wind', 'wind', 375, 0)
	addAnimationByPrefix('wind', 'wind', 'remolicocosa export', 24, true)
	addLuaSprite('wind', false)
	setProperty('wind.alpha', 0.4)
	setBlendMode('wind', 'multiply')

	makeLuaSprite('park2', 'park2', -150, 0)
	addLuaSprite('park2', false)
	setScrollFactor('park2', 0.6, 1.0)

	makeLuaSprite('park1', 'park1', 200, 100)
	addLuaSprite('park1', false)
	setScrollFactor('park1', 0.95, 1.0)

	makeLuaSprite('piso', 'piso', 0, 0)
	addLuaSprite('piso', false)

	makeLuaSprite('overlay', 'overlay', 350, 60)
	addLuaSprite('overlay', true)
	setBlendMode('overlay', 'multiply')

	makeLuaSprite('lineas', '', 0, -40)
    makeGraphic('lineas', 1280, 110, '000000')
    addLuaSprite('lineas', true)
    setObjectCamera('lineas', 'hud')
	setObjectOrder('lineas', 6)

	makeLuaSprite('hotline', '', 0, 650)
    makeGraphic('hotline', 1280, 110, '000000')
    addLuaSprite('hotline', true)
    setObjectCamera('hotline', 'hud')
	setObjectOrder('hotline', 6)

    close(true);
end
