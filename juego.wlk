
object juego {
  //var property patitos = [new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = ), new Patito(ubicacion = )]

    method configurar(){
		game.width(900)
		game.height(900)
		game.boardGround("fondo.jpg")
	} 

    method terminar() {}

    method gameOver() {}

    
    
}


class Patito {
	var position
    var detonado = false
    var subio = false

	method image() = "patito.jpg"

	method position() = position
	
	method moverse() {
		game.onTick(1000,"subir y bajar",{self.subirBajar()})
	}


    method subirBajar()  { 
        if (subio) {
            position = position.down(1)
        }
        else {
            position = position.up(1)
        }
    }

    method detonarse(){
		game.removeTickEvent("")
	} 
}



object mira {
//game.onSameCell(patito.position(), mira.position())
}

/*class Patito {
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


game.onTick(1000, "subir y bajar", patitos.forEach { patito => patito.subirBajar() }

object patito {
  var subio = false

  method subirBajar()  { 
    if (subio) {
      position = position.down(1)
     } else {
        position = position.up(1)
    }
} 

*/