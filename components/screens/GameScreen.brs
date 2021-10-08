function init()
    m.CAR_WIDTH = 70
    m.CAR_HEIGHT = 150

    m.WIN_CONDITION = 1125

    m.CHARACTER_TRANSLATION = [50, 400]

    m.CHARACTER_WIDTH = 50
    m.CHARACTER_HEIGHT = 50

    m.TIMER_DURATION = 0.01

    m.cars = []

    m.top.observeField("focusedChild", "onFocusStateChanged")

    initElements()
end function

function initElements()
    m.road = CreateObject("roSGNode", "Poster")
    m.road.uri = "pkg:/images/road-im.jpg"
    m.top.appendChild(m.road)
end function

function onFocusStateChanged()
    if (m.top.hasFocus())
        m.character = CreateObject("roSGNode", "Character")
        m.top.appendChild(m.character)
        m.character.setFocus(true)

        car = CreateObject("roSGNode", "BlueCar")
        car.positionX = 300
        m.top.appendChild(car)
        m.cars.push(car)

        car = CreateObject("roSGNode", "PinkCar")
        car.positionX = 490
        m.top.appendChild(car)
        m.cars.push(car)

        car = CreateObject("roSGNode", "BlueCar")
        car.positionX = 690
        m.top.appendChild(car)
        m.cars.push(car)

        car = CreateObject("roSGNode", "PinkCar")
        car.positionX = 890
        m.top.appendChild(car)
        m.cars.push(car)

        m.timer = CreateObject("roSGNode", "Timer")
        m.timer.observeField("fire", "roadAccident")
        m.timer.duration = m.TIMER_DURATION
        m.timer.repeat = true
        m.timer.control = "start"
    end if
end function

function roadAccident() as void
    count = m.cars.count() - 1

    for i = 0 to count
        car = m.cars[i]

        x1 = car.carTranslation[0] - m.CAR_WIDTH / 2
        y1 = car.carTranslation[1] - m.CAR_HEIGHT / 2
        x2 = car.carTranslation[0] + m.CAR_WIDTH / 2
        y2 = car.carTranslation[1] + m.CAR_HEIGHT / 2

        x3 = m.character.characterTranslation[0]
        y3 = m.character.characterTranslation[1] - m.CHARACTER_HEIGHT
        x4 = m.character.characterTranslation[0] + m.CHARACTER_WIDTH
        y4 = m.character.characterTranslation[1]

        if(y4 >= y1 and y3 <= y2 and x3 <= x2 and x4 >= x1)
            check()
            return
        end if
    end for

    if m.character.characterTranslation[0] >= m.WIN_CONDITION
        win()
    end if

end function

function win()
    m.top.openFinalScreen = true
    m.timer.unobserveField("fire")
    m.timer.control = "stop"
end function

function check()
    m.top.openFinalScreen = false
    m.character.kill = true
    m.timer.unobserveField("fire")
    m.timer.control = "stop"
end function