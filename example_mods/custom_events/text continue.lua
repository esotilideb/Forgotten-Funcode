function onEvent(eventName, value1)
    if eventName == 'text continue' then
        setProperty('dialogue.alpha', 0)
        doTweenAlpha('dialogue', 'dialogue', 1, 0.075, 'linear')
        setTextString('dialogue', value1)
    end
end
