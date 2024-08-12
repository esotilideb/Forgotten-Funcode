local start = false
local sapallo = 0
local velocida = 0

function onCreate()
    addCharacterToList('jamso', 'dad')
    addCharacterToList('bf', 'boyfriend')
    playSound('presong taunt', 1, 'playaso')

    makeAnimatedLuaSprite('gooberbot', 'run', 1300, 433)
	addAnimationByPrefix('gooberbot', 'run', 'run', 24, true)
	addLuaSprite('gooberbot', false)
    setObjectCamera('gooberbot', 'hud')
    setObjectOrder('gooberbot', 100)

    makeAnimatedLuaSprite('goober2bot', 'run', 1800, 433)
	addAnimationByPrefix('goober2bot', 'run', 'run', 24, true)
	addLuaSprite('goober2bot', false)
    setObjectCamera('goober2bot', 'hud')
    setObjectOrder('goober2bot', 100)

    makeAnimatedLuaSprite('goober3bot', 'run', 2300, 433)
	addAnimationByPrefix('goober3bot', 'run', 'run', 24, true)
	addLuaSprite('goober3bot', false)
    setObjectCamera('goober3bot', 'hud')
    setObjectOrder('goober3bot', 100)

    makeAnimatedLuaSprite('goober4bot', 'run', 2800, 433)
	addAnimationByPrefix('goober4bot', 'run', 'run', 24, true)
	addLuaSprite('goober4bot', false)
    setObjectCamera('goober4bot', 'hud')
    setObjectOrder('goober4bot', 100)

    makeAnimatedLuaSprite('goobertop', 'run', -420, 0)
	addAnimationByPrefix('goobertop', 'run', 'run', 24, true)
	addLuaSprite('goobertop', false)
    setObjectCamera('goobertop', 'hud')
    setObjectOrder('goobertop', 100)
    setProperty('goobertop.flipX', true)
    setProperty('goobertop.flipY', true)

    makeAnimatedLuaSprite('goober2top', 'run', -920, 0)
	addAnimationByPrefix('goober2top', 'run', 'run', 24, true)
	addLuaSprite('goober2top', false)
    setObjectCamera('goober2top', 'hud')
    setObjectOrder('goober2top', 100)
    setProperty('goober2top.flipX', true)
    setProperty('goober2top.flipY', true)

    makeAnimatedLuaSprite('goober3top', 'run', -1420, 0)
	addAnimationByPrefix('goober3top', 'run', 'run', 24, true)
	addLuaSprite('goober3top', false)
    setObjectCamera('goober3top', 'hud')
    setObjectOrder('goober3top', 100)
    setProperty('goober3top.flipX', true)
    setProperty('goober3top.flipY', true)

    makeAnimatedLuaSprite('goober4top', 'run', -1920, 0)
	addAnimationByPrefix('goober4top', 'run', 'run', 24, true)
	addLuaSprite('goober4top', false)
    setObjectCamera('goober4top', 'hud')
    setObjectOrder('goober4top', 100)
    setProperty('goober4top.flipX', true)
    setProperty('goober4top.flipY', true)
end

function onStartCountdown()
	if not start then
        setProperty('healthBar.alpha', 0)
        setProperty('healthBarBG.alpha', 0)
        setProperty('iconP1.alpha', 0)
        setProperty('iconP2.alpha', 0)
        setProperty('scoreTxt.alpha', 0)
        runTimer('anim', 0.8)
		runTimer('wow', 5)
        runTimer('song', 4.6)
        start = true
		return Function_Stop
    end

    triggerEvent('Change Character', 'dad', 'jamso')
    triggerEvent('Change Character', 'boyfriend', 'bf')
    doTweenAlpha('healthBar', 'healthBar', 1, 1, 'linear')
    doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1, 'linear')
    doTweenAlpha('iconP1', 'iconP1', 1, 1, 'linear')
    doTweenAlpha('iconP2', 'iconP2', 1, 1, 'linear')
    doTweenAlpha('scoreTxt', 'scoreTxt', 1, 1, 'linear')
end

function onTimerCompleted(tag)
    if tag == 'anim' then
        playAnim('dad', 'intro')
        playAnim('boyfriend', 'intro')
    end

    if tag == 'song' then
        soundFadeOut('playaso', 1)
    end

    if tag == 'wow' then
        startCountdown()
    end
end

function onPause()
    pauseSound('playaso')
end

function onResume()
    resumeSound('playaso')
end