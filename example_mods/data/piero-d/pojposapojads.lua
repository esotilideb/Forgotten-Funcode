function onCreate()
    addCharacterToList('damso', 'dad')
    addCharacterToList('d bf', 'boyfriend')
    addCharacterToList('d gf', 'gf')

    precacheImage('d sky')
    precacheImage('d piso')
    precacheImage('d overlay')
end

function onCreatePost()
    if shadersEnabled then
        initLuaShader('d earthbound')
	    makeLuaSprite('d earthbound', '', 375, 70)
        makeGraphic('d earthbound', 2200, 850, '')
        setSpriteShader('d earthbound', 'd earthbound')
        addLuaSprite('d earthbound')
        setObjectOrder('d earthbound', 0)
    end
end

function onUpdatePost(elapsed)
    setShaderFloat('d earthbound', 'iTime', os.clock())
end

function onStepHit()
    if curStep == 551 then
        triggerEvent("text", "*yaaaawn* it's getting kinda repetitive isn't it?")
    end

    if curStep == 592 then
        triggerEvent("text continue", "Oh, I know! I know!")
    end

    if curStep == 640 then
        triggerEvent("text continue", "Thanks for the idea "..getWindowsUsername().."! Let's see...")
    end

    if curStep == 704 then
        triggerEvent("text continue", "Side B, side C, side D... guess which one we're doing tonight!")
    end

    if curStep == 768 then
        doTweenAlpha('blackSquare', 'blackSquare', 1, 0.4, 'linear')
    end

    if curStep == 800 then
        cameraFlash('other', 'FFFFFF', 1)
        setProperty('blackSquare.alpha', 0)
        triggerEvent('Change Character', 'dad', 'damso')
        triggerEvent('Change Character', 'bf', 'd bf')
        triggerEvent('Change Character', 'gf', 'd gf')
        removeLuaSprite('sky')
        removeLuaSprite('wind')
        removeLuaSprite('piso')
        removeLuaSprite('overlay')

        makeLuaSprite('d sky', 'd sky', 30, 0)
        addLuaSprite('d sky', false)
        setScrollFactor('d sky', 0.5, 1.0)
    
        makeLuaSprite('d piso', 'd piso', 0, 0)
        addLuaSprite('d piso', false)
    
        makeLuaSprite('d overlay', 'd overlay', 350, 60)
        addLuaSprite('d overlay', true)
        setProperty('d overlay.alpha', 0.7)
        setBlendMode('d overlay', 'multiply')

        if shadersEnabled then
            setObjectOrder('park2', 5)
            setObjectOrder('park1', 5)
            setObjectOrder('d piso', 5)
        else
            setObjectOrder('park2', 3)
            setObjectOrder('park1', 3)
            setObjectOrder('d piso', 3)
        end
        
        setProperty('park2.color', 0x57194F)
        setProperty('park1.color', 0x79334E)
    end

    if curStep == 1920 then
        if shadersEnabled then
            cameraFlash('hud', 'FFFFFF', 1)
            setObjectOrder('d earthbound', 5)
        end
    end
end

function getWindowsUsername()
    local handle = io.popen("echo %USERNAME%")
    local username = handle:read("*a")
    handle:close()
    return string.gsub(username, "\n", "")
end