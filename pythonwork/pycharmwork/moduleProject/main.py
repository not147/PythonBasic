'''
game/
    sound/
        echo.py
        --------
        def echo_test():
            print("echo")

    graphic/
        render.py
        ---------
        def render_test():
            print("render")

    play.py
'''

import game.play
import game.sound.echo
import game.graphic.render

game.play.play_test()
game.sound.echo.echo_test()
game.graphic.render.render_test()

print("main.py :", __name__)



