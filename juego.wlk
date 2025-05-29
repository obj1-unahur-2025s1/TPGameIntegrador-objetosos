
object juego {
  //var property patitos = [new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = )]


    method iniciar {
        



    }
}


object mira {

}

class Patito {
    var position = null

    method image() = "patito.png"
    method position() = position

    method mover(){
        position = position.left(1)
        if (position.x() == -1)
            self.posicionar()
    }

    method posicionar() {
        position = game.at(game.width()-1, suelo.position().y())
    }

    method iniciar(){
        self.posicionar()
        game.onTick(velocidad, "moverPatito", {self.mover()})
    }

    method chocar(){
        juego.terminar()
    }
    method detener(){
        game.removeTickEvent("moverPatito")
    }
}