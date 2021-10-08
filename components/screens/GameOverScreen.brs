function init()
    m.DESCRIPTION_TRANSLATION = [345, 245]
    m.DESCRIPTION_TRANSLATION2 = [785, 245]

    m.BACKGROUND_TRANSLATION = [295, 230]
    m.BACKGROUND_TRANSLATION2 = [305, 240]
    m.BACKGROUND_OPACITY = 0.5

    m.TIMER_DURATION = 0.1

    m.ELEMENT_WIDTH = 700
    m.ELEMENT_HEIGHT = 200

    m.ELEMENT_WIDTH2 = 680
    m.ELEMENT_HEIGHT2 = 180

    m.SCREEN_WIDTH = 1920
    m.SCREEN_HEIGHT = 1080
    m.BACKGROUND_COLOR = "#808080"
    m.BACKGROUND_COLOR2 = "#FFFFFF"
    m.BACKGROUND_FULL_COLOR = "#000000"

    m.question_lose = "YOU LOSE"
    m.question_won = "YOU WON"
    m.question_color = "#990000"

    m.BUTTON_TRANSLATION = [530, 280]
    m.BUTTONS_SPACING = [0]

    m.RESTART_LABEL = "RESTART"
    m.MAIN_MENU_LABEL = "MAIN MENU"

    m.CHANGE_TRANSLATION = 20

    m.descriptionTranslation = m.DESCRIPTION_TRANSLATION

    m.descriptionTranslation2 = m.DESCRIPTION_TRANSLATION2

    m.descriptions = []

    m.descriptions2 = []

    m.top.observeField("focusedChild", "onFocusStateChanged")
    initElements()
    startAnimationShow()
end function

function initElements()
    m.backgroundfull = m.top.findNode("background_full")
    m.backgroundfull.width = m.SCREEN_WIDTH
    m.backgroundfull.height = m.SCREEN_HEIGHT
    m.backgroundfull.color = m.BACKGROUND_FULL_COLOR
    m.backgroundfull.opacity = m.BACKGROUND_OPACITY

    m.descriptionGroup = m.top.findNode("descriptionGroup")

    m.background = m.top.findNode("background")
    m.background.translation = m.BACKGROUND_TRANSLATION
    m.background.width = m.ELEMENT_WIDTH
    m.background.height = m.ELEMENT_HEIGHT
    m.background.color = m.BACKGROUND_COLOR
    m.background.opacity = m.BACKGROUND_OPACITY

    m.background2 = m.top.findNode("background2")
    m.background2.translation = m.BACKGROUND_TRANSLATION2
    m.background2.width = m.ELEMENT_WIDTH2
    m.background2.height = m.ELEMENT_HEIGHT2
    m.background2.color = m.BACKGROUND_COLOR2

    m.buttonsGroup = m.top.findNode("buttonsGroup")
    m.buttonsGroup.layoutDirection = "vert"
    m.buttonsGroup.itemspacings = m.BUTTONS_SPACING
    m.buttonsGroup.translation = m.BUTTON_TRANSLATION

    m.restartButton = m.top.findNode("restartButton")
    m.restartButton.buttonName = m.RESTART_LABEL

    m.mainmenuButton = m.top.findNode("mainmenuButton")
    m.mainmenuButton.buttonName = m.MAIN_MENU_LABEL
end function

function startAnimationShow()
    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.duration = m.TIMER_DURATION
    m.timer.repeat = true
    m.timer.observeField("fire", "animationShow")
    m.timer.control = "start"
end function

function animationShow()
    m.description = CreateObject("roSGNode", "Label")
    m.description.translation = m.descriptionTranslation
    m.description.color = m.question_color
    if m.top.state = true
        m.description.text = m.question_won
    else
        m.description.text = m.question_lose
    end if
    m.descriptionGroup.appendChild(m.description)

    m.descriptions.push(m.description)

    if m.descriptionTranslation[1] < m.ELEMENT_HEIGHT2 + m.BACKGROUND_TRANSLATION2[1] - m.CHANGE_TRANSLATION
        m.descriptionTranslation = [m.descriptionTranslation[0], m.descriptionTranslation[1] + m.CHANGE_TRANSLATION]
    else
        m.descriptionTranslation = m.DESCRIPTION_TRANSLATION
        removeLabels()
    end if

    m.description2 = CreateObject("roSGNode", "Label")
    m.description2.translation = m.descriptionTranslation2
    m.description2.color = m.question_color
    if m.top.state = true
        m.description2.text = m.question_won
    else
        m.description2.text = m.question_lose
    end if
    m.descriptionGroup.appendChild(m.description2)

    m.descriptions2.push(m.description2)

    if m.descriptionTranslation2[1] < m.ELEMENT_HEIGHT2 + m.BACKGROUND_TRANSLATION2[1] - m.CHANGE_TRANSLATION
        m.descriptionTranslation2 = [m.descriptionTranslation2[0], m.descriptionTranslation2[1] + m.CHANGE_TRANSLATION]
    else
        m.descriptionTranslation2 = m.DESCRIPTION_TRANSLATION2
        removeLabels()
    end if
end function

function removeLabels()
    m.descriptionCount = m.descriptions.count() - 1

    m.descriptionCount2 = m.descriptions2.count() - 1

    for i = 0 to m.descriptionCount
        m.descriptionGroup.removeChild(m.descriptions[i])
    end for

    for j = 0 to m.descriptionCount2
        m.descriptionGroup.removeChild(m.descriptions2[j])
    end for

    m.descriptions = []
    m.descriptions2 = []
end function

function onFocusStateChanged()
    if (m.top.hasFocus())
        m.restartButton.setFocus(true)
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if(key = "back")
            return true
        end if

        if (key = "down")
            if (m.restartButton.hasFocus())
                m.mainmenuButton.setFocus(true)
            end if
        end if

        if (key = "up")
            if (m.mainmenuButton.hasFocus())
                m.restartButton.setFocus(true)
            end if
        end if

        if (key = "OK")
            if (m.mainmenuButton.hasFocus())
                m.top.mainmenu = true
            else if (m.restartButton.hasFocus())
                m.top.restart = true
            end if
        end if
    end if
end function

function destroyView()
    m.top.unObserveField("focusedChild")
end function