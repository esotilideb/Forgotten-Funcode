function onEvent(eventName)
    if eventName == 'text bye' then
        removeLuaSprite('text')
        removeLuaText('dialogue')

        doTweenAlpha('portrait', 'portrait', 0, 0.3, 'CubeIn')
        runTimer('bye', 3)
    end
end

function onTimerCompleted(tag)
    if tag == 'bye' then
        setProperty('portrait.x', 50)
    end
end