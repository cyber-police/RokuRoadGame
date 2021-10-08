function init()
    m.ROAD_WIDTH = 1200
    m.ROAD_HEIGHT = 650

    m.CHARACTER_WIDTH = 50
    m.CHARACTER_HEIGHT = 50

    m.STEP = 1.75

    m.TIMER_DURATION = 0.01

    m.CHARACTER_TRANSLATION = [50, 400]

    m.top.characterTranslation = m.CHARACTER_TRANSLATION

    m.isKill = false

    m.whichkey = ""

    initElements()
end function

function initElements()
    m.character = m.top.findNode("character")
    m.character.translation = m.top.characterTranslation
    m.character.uri = "pkg:/images/char-right-side.png"

    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.observeField("fire", "onChangePosition")
    m.timer.duration = m.TIMER_DURATION
    m.timer.repeat = true
    m.timer.control = "start"
end function

function onChangePosition()
    if (m.whichkey = "down")
        m.character.uri = "pkg:/images/char-front.png"
        if (m.top.characterTranslation[1] < m.ROAD_HEIGHT)
            m.top.characterTranslation = [m.top.characterTranslation[0], m.top.characterTranslation[1] + m.STEP]
        end if
    end if

    if (m.whichkey = "up")
        m.character.uri = "pkg:/images/char-back.png"
        if (m.top.characterTranslation[1] > 30)
            m.top.characterTranslation = [m.top.characterTranslation[0], m.top.characterTranslation[1] - m.STEP]
        end if
    end if
    if (m.whichkey = "right")
        m.character.uri = "pkg:/images/char-right-side.png"
        if (m.top.characterTranslation[0] < m.ROAD_WIDTH)
            m.top.characterTranslation = [m.top.characterTranslation[0] + m.STEP, m.top.characterTranslation[1]]
        end if
    end if

    if (m.whichkey = "left")
        m.character.uri = "pkg:/images/char-left-side.png"
        if (m.top.characterTranslation[0] > 30)
            m.top.characterTranslation = [m.top.characterTranslation[0] - m.STEP, m.top.characterTranslation[1]]
        end if
    end if

    m.character.translation = m.top.characterTranslation
end function

function onKill()
    m.character.uri = "pkg:/images/broken-egg.png"
    destroyView()
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        m.whichkey = key
    else
        m.whichkey = ""
    end if

    return true
end function

function destroyView()
    if m.timer <> invalid
        m.timer.control = "stop"
        m.timer.unobserveField("fire")
        m.timer = invalid
    end if
end function