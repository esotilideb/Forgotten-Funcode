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
    if curStep == 547 then
        if misses == 0 then
            freaky = 1
        elseif misses < 11 then
            freaky = 2
        elseif misses >= 11 then
            freaky = 3
        end
    end

    if curStep == 551 then
        if freaky == 1 then
            triggerEvent("text", "Hey! You're pretty good at this!")
        end

        if freaky == 2 then
            triggerEvent("text", "Not bad. Not bad.")
        end

        if freaky == 3 then
            triggerEvent("text", "Wow... you kinda suck")
        end
    end

    if curStep == 592 then
        if freaky == 1 then
            triggerEvent("text continue", "I guess "..getWindowsUsername().." plays a lot of rhythm games!")
        end

        if freaky == 2 then
            triggerEvent("text continue", "You're doing pretty well actually")
        end

        if freaky == 3 then
            triggerEvent("text continue", "I guess it makes sense, though")
        end
    end

    if curStep == 640 then
        if freaky == 1 then
            triggerEvent("text continue", "I haven't seen anyone in a long time...")
        end

        if freaky == 2 then
            triggerEvent("text continue", "Puhuhuhuhu! Let's keep having fun together!")
        end

        if freaky == 3 then
            triggerEvent("text continue", "I can't expect anything from someone named "..getWindowsUsername()..", \nunless that's not your name...")
        end
    end

    if curStep == 704 then
        if freaky == 1 then
            triggerEvent("text continue", "So let's keep this up! This is really fun!")
        end

        if freaky == 2 then
            triggerEvent("text continue", "Follow my lead! It won't be anything too crazy, anyway")
        end

        if freaky == 3 then
            triggerEvent("text continue", "But it's getting boring. Keep up the pace for a bit, will ya?")
        end
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

function getWindowsUsername()
    local handle = io.popen("echo %USERNAME%")
    local username = handle:read("*a")
    handle:close()
    return string.gsub(username, "\n", "")
end