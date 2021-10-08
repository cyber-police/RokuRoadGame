function init()
    m.SCREEN_WIDTH = 1920
    m.SCREEN_HEIGHT = 1080

    m.SCREEN_OPACITY = 0.5
    m.SCREEN_COLOR = "#000000"

    m.BACKGROUND_COLOR = "#808080"
    m.BACKGROUND_OPACITY = 0.8

    m.BACKGROUND2_WIDTH = 500
    m.BACKGROUND2_HEIGHT = 480
    m.BACKGROUND2_COLOR = "#666600"

    m.MENU_WIDTH = 540
    m.MENU_HEIGHT = 520

    m.BACKGROUND_TRANSLATION = [380, 130]
    m.MENU_TRANSLATION = [400, 150]

    m.ELEMENT_WIDTH = 500
    m.ELEMENT_HEIGHT = 200
    m.ELEMENT_COLOR = "#990000"

    m.BUTTON_TRANSLATION = [530, 300]
    m.BUTTONS_SPACING = [20]

    m.PLAY_LABEL = "PLAY"
    m.QUIT_LABEL = "QUIT"

    m.CHANGE_TRANSLATION = 20

    m.TITLE_TEXT = "ROAD ON ROAD ON ROAD ON ROAD ON"

    m.TIMER_DURATION = 0.1

    m.titleTranslation = m.MENU_TRANSLATION

    m.titles = []

    m.top.observeField("focusedChild", "onFocusStateChanged")

    initElements()
    startAnimationShow()
end function

function initElements()
    m.background_full = m.top.findNode("background_full")
    m.background_full.width = m.SCREEN_WIDTH
    m.background_full.height = m.SCREEN_HEIGHT
    m.background_full.opacity = m.SCREEN_OPACITY
    m.background_full.color = m.SCREEN_COLOR

    m.titleGroup = m.top.findNode("titleGroup")

    m.background = m.top.findNode("background")
    m.background.width = m.MENU_WIDTH
    m.background.height = m.MENU_HEIGHT
    m.background.translation = m.BACKGROUND_TRANSLATION
    m.background.opacity = m.BACKGROUND_OPACITY
    m.background.color = m.BACKGROUND_COLOR

    m.background2 = m.top.findNode("background2")
    m.background2.width = m.BACKGROUND2_WIDTH
    m.background2.height = m.BACKGROUND2_HEIGHT
    m.background2.translation = m.MENU_TRANSLATION
    m.background2.color = m.BACKGROUND2_COLOR

    m.buttonsGroup = m.top.findNode("buttonsGroup")
    m.buttonsGroup.layoutDirection = "vert"
    m.buttonsGroup.itemspacings = m.BUTTONS_SPACING
    m.buttonsGroup.translation = m.BUTTON_TRANSLATION

    m.playButton = m.top.findNode("playButton")
    m.playButton.buttonName = m.PLAY_LABEL

    m.qiutButton = m.top.findNode("qiutButton")
    m.qiutButton.buttonName = m.QUIT_LABEL
end function

function startAnimationShow()
    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.duration = m.TIMER_DURATION
    m.timer.repeat = true
    m.timer.observeField("fire", "animationShow")
    m.timer.control = "start"
end function

function animationShow()
    title = CreateObject("roSGNode", "Label")
    title.width = m.ELEMENT_WIDTH
    title.height = m.ELEMENT_HEIGHT
    title.translation = m.titleTranslation
    title.color = m.ELEMENT_COLOR
    title.text = m.TITLE_TEXT
    m.titleGroup.appendChild(title)

    m.titles.push(title)

    if m.titleTranslation[1] < m.BACKGROUND2_HEIGHT + m.MENU_TRANSLATION[1] - m.CHANGE_TRANSLATION
        m.titleTranslation = [m.titleTranslation[0], m.titleTranslation[1] + m.CHANGE_TRANSLATION]
    else
        m.titleTranslation = m.MENU_TRANSLATION
        removeLabels()
    end if
end function

function removeLabels()
    m.titlesCount = m.titles.count() - 1

    for i = 0 to m.titlesCount
        m.titleGroup.removeChild(m.titles[i])
    end for

    m.titles = []
end function

function onFocusStateChanged()
    if (m.top.hasFocus())
        m.playButton.setFocus(true)
    end if
end function


function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if (key = "down")
            if (m.playButton.hasFocus())
                m.qiutButton.setFocus(true)
            end if
        end if

        if (key = "up")
            if (m.qiutButton.hasFocus())
                m.playButton.setFocus(true)
            end if
        end if

        if (key = "OK")
            if (m.playButton.hasFocus())
                m.top.playButtonPressed = true
                destroyView()
            else if (m.qiutButton.hasFocus())
                m.top.quitButtonPressed = true
            end if
        end if
    end if
end function

function destroyView()
    m.top.unObserveField("focusedChild")
    m.top.unObserveField("fire")
    m.timer.control = "stop"
    m.titles = []
end function