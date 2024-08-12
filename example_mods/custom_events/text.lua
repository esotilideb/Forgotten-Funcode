function onCreate()
    precacheImage('persona5')
    precacheImage('portrait')

    makeLuaSprite('blackSquare', '', 0, 0)
    makeGraphic('blackSquare', 1280, 720, '000000')
    setObjectCamera('blackSquare', 'hud')
    screenCenter('blackSquare')
    addLuaSprite('blackSquare', true)
    setObjectOrder('blackSquare', 30)
    setProperty('blackSquare.alpha', 0)
end

function onEvent(eventName, value1)
    if eventName == 'text' then
        doTweenAlpha('blackSquare', 'blackSquare', 0.9, 0.8, 'linear')

        makeLuaSprite('portrait', 'portrait', 50, 180)
        addLuaSprite('portrait')
        setObjectCamera('portrait', 'hud')
        setObjectOrder('portrait', 100)
        setProperty('portrait.alpha', 0)
        doTweenAlpha('portrait', 'portrait', 1, 0.15, 'linear')
        doTweenX('portraitx', 'portrait', 235, 0.2, 'CubeOut')

        makeAnimatedLuaSprite('text', 'persona5', 20, 250)
	    addAnimationByPrefix('text', 'box', 'persona5box', 24, true)
        addAnimationByPrefix('text', 'spawn', 'persona5spawn', 24, false)
	    addLuaSprite('text', false)
        setObjectCamera('text', 'hud')
        setObjectOrder('text', 103)
        addOffset('text', 'box', -23, -95)

        makeLuaText('dialogue', value1, 1000, 100, 450)
        addLuaText('dialogue')
        setProperty('dialogue.alpha', 0)
        setTextSize('dialogue', 30)
        setObjectOrder('dialogue', 105)
        setTextFont('dialogue', 'Fontsona.ttf')
        setTextAlignment('dialogue', 'left')
    end
end

function onUpdatePost()
    if getProperty('text.animation.finished') and getProperty('text.animation.name') == 'spawn' then
        playAnim('text', 'box')

        doTweenAlpha('dialogue', 'dialogue', 1, 0.075, 'linear')
    end
end
