object juego {
    method pantallaInicio() {
        game.addVisual(fondo.imagen())
    }

    method iniciar() {
        
        game.clear()
        [contadorBalas, tiempo, patitosDetonados].forEach {interfaz => interfaz.reiniciar()}

        // añadimos interfaz
        game.addVisual(tiempo)
        game.addVisual(patitosDetonados)
        game.addVisual(contadorBalas)
        
        //añadimos musica y sonidos
        game.sound(cancionFondo)
        game.sound(sonidoGolpe)

        // añadimos patitos y mira
        var objetos = [new Patito(ejeX = 14), new Patito(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new Patito(ejeX = 22), new Patito(ejeX = 24), new Patito(ejeX = 26), new Patito(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Cofre(ejeX = 36), new Patito(ejeX = 38), new Patito(ejeX = 40), new Reloj(ejeX=42), new Patito(ejeX = 44), new Patito(ejeX = 46), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new Patito(ejeX = 54), new Patito(ejeX = 56), new Patito(ejeX = 58), new Patito(ejeX = 60)]
        objetos.forEach { patito => game.addVisual(patito) }
        game.addVisual(mira)
        game.addVisual(prueba)
        game.addVisual(prueba2)

        // que cada un segundo, se muevan
        game.onTick(250, "movimiento", { 
            objetos.forEach { patito => patito.moverse() }
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
            if (tiempo.contador() == 0 or contadorBalas.balas() == 0) {
                game.addVisual(new Texto(text="¡Tiempo!", position=game.center()))
                game.addVisual(new Texto(text="Record: " + patitosDetonados.cantidad() + " patitos detonados.", position = game.at(7, 3)))
                game.addVisual(new Texto(text="¿Jugar de vuelta? (R)", position = game.at(7, 1)))
                game.removeVisual(mira)
            }
        })
        
        // matar patito
        keyboard.space().onPressDo {
            contadorBalas.gastarBala()
            var objetoEncontrado = objetos.find { patito => game.onSameCell(patito.position(), mira.position())}
            if (objetoEncontrado != null) {
                game.removeVisual(objetoEncontrado)
                if (objetoEncontrado.tipo() == "Patito") {
                    patitosDetonados.sumar()
                    sonidoGolpe.play()
                } else if (objetoEncontrado.tipo() == "Cofre") {
                    contadorBalas.sumar(5)
                } else if (objetoEncontrado.tipo() == "Reloj") {
                    tiempo.sumar(5)
                }
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
    method image() = "patito.png"
    method position() = position
    method tipo() = "Patito"

	method moverse() {
        position = position.left(1)
	}
}

class PatitoAlternativo inherits Patito {
    var subio = false

    method subirBajar()  { 
        if (subio) {
            position = position.down(1)
            subio = !subio
        }
        else {
            position = position.up(1)
            subio = !subio
        }
    }

    override method moverse() {
        super()
        self.subirBajar()
    }
}

class Cofre inherits Patito {
    override method image() = "cofre.png"
    override method tipo() = "Cofre"
}

class Reloj inherits Patito {
    override method image() = "reloj.png"
    override method tipo() = "Reloj"
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
    var property textColor = "000000"

    var contador = 10
    method contador() = contador
    method restar() {
        contador = (contador - 1).max(0)
    }
    method sumar(segundos) {
        contador += segundos
    }
    method reiniciar() {
        contador = 10
    }
}

object patitosDetonados {
    var property position = game.at(4, 8)
    method text() = "Patitos: " + self.cantidad()
    var property textColor = "#000000"

    var cantidad = 0
    method cantidad() = cantidad
    method sumar() {
        cantidad += 1
    }
    method reiniciar() {
        cantidad = 0
    }
}

object contadorBalas {
    var property position = game.at(6, 8)
    method text() = "Balas restantes: " + self.balas()
    var property textColor = "#000000"
    var balas = 10

    method balas() = balas
    method gastarBala() {
        balas = (balas - 1).max(0)
    }
    method reiniciar() {
        balas = 10
    }
    method sumar(cantBalas) {
        balas += cantBalas
    }
}

// pantalla inicio
object fondo {
    var property image = "pantallaInicio1.png"

    method imagen() = image
    method cambiarPantalla(unaImagen) {
        image = unaImagen
    }
}

// sonidos
object cancionFondo {
    method play() { 
        game.sound("cancionFond.mp3").play()
    }

    // method stop() {
    //     game.sound("cancionFondo.mp3").stop()
    // }
}

object sonidoGolpe {
    method play() {
        game.sound("golpe.wav").play()
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

