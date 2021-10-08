function init()
    m.ROAD_HEIGHT = 720

    m.top.carWidth = 70
    m.top.carHeight = 150

    m.TIMER_DURATION = 0.05

    m.ROTATION = 3.141591530269234

    MIN_SPEED = 3
    MAX_SPEED = 10

    m.STEP = Rnd(MAX_SPEED)

    if m.STEP < MIN_SPEED
        m.STEP = MIN_SPEED
    end if

    m.car = invalid
    m.direction = ""

    initElements()
end function

function onSetPosition()
    m.top.carTranslation = [m.top.positionX, Rnd(720)]
    m.car.translation = m.top.carTranslation
end function

function initElements()
    initCarElements()

    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.observeField("fire", "onChangePosition")
    m.timer.duration = m.TIMER_DURATION
    m.timer.repeat = true
    m.timer.control = "start"
end function

function initCarElements()
end function

function onChangePosition()
    if (m.direction = "downside")
        if(m.top.carTranslation[1] <= m.ROAD_HEIGHT)
            m.top.carTranslation = [m.top.carTranslation[0], m.top.carTranslation[1] + m.STEP]
            if(m.top.carTranslation[1] >= m.ROAD_HEIGHT)
                m.direction = "upside"
                m.car.rotation += m.ROTATION
            end if
        end if

    else if (m.direction = "upside")
        if(m.top.carTranslation[1] >= 0)
            m.top.carTranslation = [m.top.carTranslation[0], m.top.carTranslation[1] - m.STEP]
            if(m.top.carTranslation[1] <= 0)
                m.direction = "downside"
                m.car.rotation += m.ROTATION
            end if
        end if
    end if

    m.car.translation = m.top.carTranslation
end function