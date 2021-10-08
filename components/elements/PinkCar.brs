function init()
    m.direction = "upside"
end function

function initCarElements()
    m.car = m.top.findNode("carPoster")
    m.car.uri = "pkg:/images/car2-above.png"
    m.car.scaleRotateCenter = [m.top.carWidth / 2, m.top.carHeight / 2]
end function