object juegoCopia {
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