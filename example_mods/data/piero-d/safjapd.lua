local start = false

function onCreate()
    addCharacterToList('jamso', 'dad')
    addCharacterToList('bf', 'boyfriend')
    playSound('presong taunt', 1, 'playaso')
end

function onCreatePost()
    if shadersEnabled then
        initLuaShader('earthbound')
	    makeLuaSprite('earthbound', '', 375, 70)
        makeGraphic('earthbound', 2200, 850, '')
        setSpriteShader('earthbound', 'earthbound')
        addLuaSprite('earthbound')
        setObjectOrder('earthbound', 0)
    end
end

function onUpdatePost(elapsed)
    setShaderFloat('earthbound', 'iTime', os.clock())
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