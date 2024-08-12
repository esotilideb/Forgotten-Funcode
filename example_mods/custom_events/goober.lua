-- this prolly ugly af sorry

function onEvent(eventName, value1)
    if eventName == 'goober' then
	    local speed = tonumber(value1)
	    if speed == nil then
		    speed = 2.5
	    end

	    doTweenX('gooberbot', 'gooberbot', -1920, speed, 'linear')
        doTweenX('goober2bot', 'goober2bot', -1420, speed, 'linear')
        doTweenX('goober3bot', 'goober3bot', -920, speed, 'linear')
        doTweenX('goober4bot', 'goober4bot', -420, speed, 'linear')

        doTweenX('goobertop', 'goobertop', 2800, speed, 'linear')
        doTweenX('goober2top', 'goober2top', 2300, speed, 'linear')
        doTweenX('goober3top', 'goober3top', 1800, speed, 'linear')
        doTweenX('goober4top', 'goober4top', 1300, speed, 'linear')
    end
end

function onTweenCompleted(tag)
    if tag == 'goober4bot' then
        setProperty('gooberbot.x', 1300)
        setProperty('goober2bot.x', 1800)
        setProperty('goober3bot.x', 2300)
        setProperty('goober4bot.x', 2800)

        setProperty('goobertop.x', -420)
        setProperty('goober2top.x', -920)
        setProperty('goober3top.x', -1420)
        setProperty('goober4top.x', -1920)
    end
end
