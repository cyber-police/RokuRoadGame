function init()
    createGameScreen()
    createMenuScreen()
end function

function createMenuScreen()
    m.menuscreen = CreateObject("roSGNode", "MenuScreen")
    m.menuscreen.observeField("playButtonPressed", "onStart")
    m.menuscreen.observeField("quitButtonPressed", "onQuit")
    m.top.appendChild(m.menuscreen)
    m.menuscreen.setFocus(true)
end function

function createGameScreen()
    m.gamescreen = CreateObject("roSGNode", "GameScreen")
    m.gamescreen.observeField("openFinalScreen", "onFinalScreen")
    m.top.appendChild(m.gamescreen)
end function

function createGameOverScreen()
    m.gameoverscreen = CreateObject("roSGNode", "GameOverScreen")
    m.gameoverscreen.observeField("restart", "onRestart")
    m.gameoverscreen.observeField("mainmenu", "onMenu")
    m.top.appendChild(m.gameoverscreen)
    m.gameoverscreen.setFocus(true)
    m.gameoverscreen.state = m.gamescreen.openFinalScreen
end function

function onFinalScreen()
    createGameOverScreen()
end function

function onRestart()
    removeGameOverScreen()
    removeGameScreen()
    createGameScreen()
    m.gamescreen.setFocus(true)
end function

function onMenu()
    removeGameOverScreen()
    removeGameScreen()
    createGameScreen()
    createMenuScreen()
end function

function onStart()
    removeMenuScreen()
    m.gamescreen.setFocus(true)
end function

function onQuit()
    m.top.appExit = true
end function

function removeMenuScreen()
    m.menuscreen.unobserveField("playButtonPressed")
    m.menuscreen.unobserveField("quitButtonPressed")
    m.top.removeChild(m.menuscreen)
    m.menuscreen = invalid
end function

function removeGameScreen()
    m.gamescreen.unobserveField("openFinalScreen")
    m.top.removeChild(m.gamescreen)
    m.gamescreen = invalid
end function

function removeGameOverScreen()
    m.gameoverscreen.unobserveField("restart")
    m.gameoverscreen.unobserveField("mainmenu")
    m.top.removeChild(m.gameoverscreen)
    m.gameoverscreen = invalid
end function