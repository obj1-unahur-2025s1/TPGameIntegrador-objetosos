object prueba {
  var property position = game.at(0, 6)
  method text() = "0, 6"
}

object prueba2 {
  var property position = game.at(6, 0)
  method text() = "6, 0"
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

