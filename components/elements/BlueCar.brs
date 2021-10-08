function init()
    m.direction = "downside"
end function

function initCarElements()
    m.car = m.top.findNode("carPoster")
    m.car.uri = "pkg:/images/car1_2-above.png"
    m.car.scaleRotateCenter = [m.top.carWidth / 2, m.top.carHeight / 2]
end function