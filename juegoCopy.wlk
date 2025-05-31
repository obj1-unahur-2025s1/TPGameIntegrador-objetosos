object juegoCopia {
    method iniciar() {
        game.clear()

        // añadimos interfaz
        game.addVisual(tiempo)
        game.addVisual(patitosDetonados)
        game.addVisual(contadorBalas)

        // añadimos patitos y mira
        var patitos = [new Patito(ejeX = 14), new Patito(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new Patito(ejeX = 22), new Patito(ejeX = 24), new Patito(ejeX = 26), new Patito(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Patito(ejeX = 36), new Patito(ejeX = 38), new Patito(ejeX = 40)]
        patitos.forEach { patito => game.addVisual(patito) }
        game.addVisual(mira)
        game.addVisual(prueba)
        game.addVisual(prueba2)

        // que cada un segundo, se muevan
        game.onTick(250, "movimiento", { 
            patitos.forEach { patito => patito.moverse() }
            })
        
        // que se mueva la mira
        game.onTick(50, "movimiento de la mira", {
            mira.moverse()
            if (mira.position().x() == game.width() - 1 or mira.position().x() == 0) {
                mira.cambiarDireccion()
            }
        })
        
        // para que el tiempo se actualice
        game.onTick(1000, "tiempo", {
            tiempo.restar()
            if (tiempo.contador() == 0 or contadorBalas().balas() == 0) {
                game.addVisual(new Texto(text="¡Tiempo!", position=game.center()))
                game.addVisual(new Texto(text="¿Jugar de vuelta? (R)", position = game.at(7, 3)))
                game.removeVisual(mira)
            }
        })
        
        // matar patito
        keyboard.space().onPressDo {
            contadorBalas.gastarBala()
            var patitoEncontrado = patitos.find { patito => game.onSameCell(patito.position(), mira.position())}
            if (patitoEncontrado != null) {
                game.removeVisual(patitoEncontrado)
                patitosDetonados.sumar()
            }
        }

        // reiniciar
        keyboard.r().onPressDo {
            self.iniciar()
        }
    }
}

class Patito {
    var ejeX 
	var property position = game.at(ejeX, 4)
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

    method cambiarDireccion() {
        dirDerecha = !dirDerecha
    }
}

class Texto {
    var property position
    var property text
    var property textColor = "#646464"
} 

object tiempoFuera {
    var property position = game.center()
    var property textColor = "#646464"
    var property text = "¡Tiempo!"
}

// interfaz
object tiempo {
    var property position = game.at(2, 8)
    method text() = "Tiempo: " + self.contador()
    var property textColor = "#646464"

    var contador = 10
    method contador() = contador
    method restar() {
        contador = (contador - 1).max(0)
    }
}

object patitosDetonados {
    var property position = game.at(4, 8)
    method text() = "Patitos: " + self.cantidad()
    var property textColor = "#646464"

    var cantidad = 0
    method cantidad() = cantidad
    method sumar() {
        cantidad += 1
    }
}

object contadorBalas {
    var property position = game.at(6, 8)
    method text() = "Balas restantes: " + self.balas()
    var property textColor = "#646464"
    var balas = 10

    method balas() = balas
    method gastarBala() {
        balas = (balas - 1).max(0)
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