// Elementos del visuales: 
import sonidos.*


class Contador {
    var ejeX
    var texto
    var valorInicial

    var contador = valorInicial
    var property textColor = "#000000"
    var property position = game.at(ejeX, 7)
    method text() = texto + contador
    method contador() = contador
    method sumar(n) {
        contador += n
    }
    method restar(n) {
        contador = (contador - n).max(0)
    }
    method reiniciar() {
        contador = valorInicial
    }
}

class Patito {
    var ejeX 
	var property position = game.at(ejeX, 4)
    method image() = "patito.png"
    method position() = position

	method moverse() {
        position = position.left(1)
	}
    method recibirDisparo() {
        patitosDetonados.sumar(1)
        sonidoGolpe.play()
    }
    method puntosQueDa() = 100
    method contador() = 1
}

class PatitoAlternativo inherits Patito {
    var subio = true

    method subirBajar()  { 
        if (subio) {
            position = position.down(1)
        }
        else {
            position = position.up(1)
        }
        subio = !subio
    }

    override method puntosQueDa() = 300
    override method moverse() {
        super()
        self.subirBajar()
    }
}

class PatitoMalo inherits Patito {
    override method image() = "patitoMalo.png"
    override method puntosQueDa() = -400
}

class Cofre inherits Patito {
    override method image() = "cofre.png"
    override method puntosQueDa() = 50
    override method recibirDisparo() {
        contadorBalas.sumar(5)
        recargarSonido.play()
    }
}

class Reloj inherits Patito {
    override method image() = "reloj.png"
    override method puntosQueDa() = 50
    override method recibirDisparo() {
        tiempo.sumar(5)
        relojSonido.play()
    }
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



object tiempo {
    var property position = game.at(2, 7)
    method text() = "Tiempo: " + self.contador()
    var property textColor = "#000000"

    var contador = 20
    method contador() = contador
    method restar(n) {
        contador = (contador - n).max(0)
    }
    method sumar(n) {
        contador += n
    }
    method reiniciar() {
        contador = 20
    }
}

object patitosDetonados {
    var property position = game.at(5, 7)
    method text() = "Patitos: " + contador
    var property textColor = "#000000"

    var contador = 0
    method contador() = contador
    method sumar(n) {
        contador += n
    }
    method reiniciar() {
        contador = 0
    }
}

object contadorBalas {
    var property position = game.at(8, 7)
    method text() = "Balas restantes: " + contador
    var property textColor = "#000000"
    var contador = 20

    method contador() = contador
    method restar(n) {
        contador = (contador - n).max(0)
    }
    method reiniciar() {
        contador = 20
    }
    method sumar(n) {
        contador += n
    }
}

object contadorPuntos {
    var property position = game.at(11, 7)
    method text() = "Puntos: " + contador
    var property textColor = "#000000"
    var contador = 0

    method contador() = contador
    method reiniciar() {
        contador = 0
    }
    method sumar(n) {
        contador += n
    }
    method restar(n) {
        contador = (contador - n).max(0)
    }
}

// Imagen de inicio 
object pantalla {
    var imagen = "inicio1.png"
    method image() = imagen
    method position() = game.origin()

    method cambiarImagen() {
        imagen = "inicio2.png"
    }
    method imagenFinal() {
        imagen = "pantalla_final.png"
    }
    method reiniciar() {
        imagen = "inicio1.png"
    }

}