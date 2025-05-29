object juego {
    method iniciar() {
        // añadimos interfaz
        game.addVisual(tiempo)
        game.addVisual(patitosDetonados)

        // añadimos patitos y mira
        //var patitos = [new Patito()]
        var patito1 = new 
        Patito()
        game.addVisual(patito1)
        game.addVisual(mira)
        game.addVisual(prueba)
        game.addVisual(prueba2)

        // que cada un segundo, se muevan
        game.onTick(1000, "movimiento", { [patito1, mira].forEach {
            objeto => objeto.moverse()
        }} )
    }
}


class Patito {
    var property position = game.at(14, 4)
    var property image = "patito.png"
    method position() = position

    method moverse() {
        position = position.left(1)
    }


    // method subirBajar()  { 
    //     if (subio) {
    //         position = position.down(1)
    //     }
    //     else {
    //         position = position.up(1)
    //     }
    // }
}

object mira {
    var property image = "mira.png"
    var property position = game.at(0, 4)
    var dirDerecha = true

    method moverse() {
        if (dirDerecha) {
            position = position.right(1)
        } else {
            position = position.left(1)
        }
    }
}

// interfaz
object tiempo {
    var property position = game.at(2, 8)
    var property text = "Tiempo: " + self.contador()

    var contador = 30
    method contador() = contador
    method pasarTiempo() {
        text = (text - 1).max(0)
    }
}

object patitosDetonados {
    var property position = game.at(4, 8)
    var property text = "Patitos: " + self.cantidad()

    var cantidad = 0
    method cantidad() = cantidad
    method sumar() {
        cantidad += 1
    }
}

object prueba {
  var property position = game.at(0, 6)
  method text() = "0, 6"
}

object prueba2 {
  var property position = game.at(6, 0)
  method text() = "6, 0"
}
/*object juego {
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

	method image() = if (not detonado) "patito.jpg" else "pumm.jpg"

	method position() = position
	
	method moverse() {
		game.onTick(1000,"subir y bajar",{self.subirBajar()})
	}


    method subirBajar()  { 
        if (subio) {
            position = position.down(1)
            subio = false
        }
        else {
            position = position.up(1)
            subio = true
        }
    }

    method detonarse(){
        detonado = true
		game.removeTickEvent("subir y bajar")
        self.image()
        game.schedule(1500, {game.removeVisual(self)})
	} 
}


object mira {
    var posicion = null
    method posicion() = posicion
    method disparar() {
        if (game.onSameCell(Patito.position(), self.posicion())) Patito.detonarse()
    }
//
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