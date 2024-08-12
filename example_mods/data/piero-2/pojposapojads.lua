local freaky = 0

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

function onStepHit()
    if curStep == 551 then
        triggerEvent("text", "So much fun!")
    end

    if curStep == 592 then
        triggerEvent("text continue", "But something is wrong...")
    end

    if curStep == 640 then
        triggerEvent("text continue", "We already did this one! That's reaaally boring kid")
    end

    if curStep == 704 then
        triggerEvent("text continue", "It's time to try something new! You don't mind, do you?")
    end

    if curStep == 768 then
        doTweenAlpha('blackSquare', 'blackSquare', 0, 1.5, 'linear')
    end

    if curStep == 1920 then
        if shadersEnabled then
            cameraFlash('hud', 'FFFFFF', 1)
            setObjectOrder('earthbound', 5)
        end
    end
end

function onBeatHit()
    velocida = getRandomFloat(1.5, 3.0)
    sapallo = getRandomInt(1, 50)

    if curSection > 51 and curSection < 116 then
        if sapallo == 1 then
            triggerEvent("goober", velocida)
        end
    end
end

function getWindowsUsername()
    local handle = io.popen("echo %USERNAME%")
    local username = handle:read("*a")
    handle:close()
    return string.gsub(username, "\n", "")
end