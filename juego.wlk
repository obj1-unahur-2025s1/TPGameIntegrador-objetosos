import visuales.*
import sonidos.*

object juego {
    var dificultad = null
    var objetos = null

    method iniciar() {
        game.clear()

		game.addVisual(pantallaInicio1)
		keyboard.space().onPressDo({ 
            game.removeVisual(pantallaInicio1)
            game.addVisual(pantallaInicio2)
         })
        keyboard.num1().onPressDo( {
            objetos = [new Patito(ejeX = 14), new Patito(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new Patito(ejeX = 22), new Patito(ejeX = 24), new Patito(ejeX = 26), new Patito(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Cofre(ejeX = 36), new Patito(ejeX = 38), new Patito(ejeX = 40), new Reloj(ejeX=42), new Patito(ejeX = 44), new Patito(ejeX = 46), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new Patito(ejeX = 54), new Patito(ejeX = 56), new Patito(ejeX = 58), new Patito(ejeX = 60), new Patito(ejeX = 62), new Patito(ejeX = 64), new Patito(ejeX = 66), new Patito(ejeX = 68), new Patito(ejeX = 70), new Patito(ejeX = 72)]
            self.configurate() })
        keyboard.num2().onPressDo({
            objetos = [new Patito(ejeX = 14), new PatitoAlternativo(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new PatitoAlternativo(ejeX = 22, subio = false), new Patito(ejeX = 24), new Patito(ejeX = 26), new PatitoAlternativo(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Patito(ejeX = 36), new Patito(ejeX = 38), new PatitoAlternativo(ejeX = 40, subio = false), new Patito(ejeX = 42), new Patito(ejeX = 44), new Patito(ejeX = 46), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new Patito(ejeX = 54), new Patito(ejeX = 56), new PatitoAlternativo(ejeX = 58, subio =false), new PatitoAlternativo(ejeX = 60), new Patito(ejeX = 62), new Patito(ejeX = 64), new Patito(ejeX = 66), new Patito(ejeX = 68)]
            self.configurate() })
    }
    
    method configurate() {
        // añadimos interfaz
        game.clear()
        [contadorBalas, tiempo, patitosDetonados].forEach {interfaz => interfaz.reiniciar()}
        game.addVisual(tiempo)
        game.addVisual(patitosDetonados)
        game.addVisual(contadorBalas)
        
        //añadimos musica y sonidos
        game.sound(cancionFondo)
        game.sound(sonidoGolpe)

        // añadimos patitos y mira
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


// var objetosDificiles = [new Patito(ejeX = 14), new PatitoAlternativo(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new PatitoAlternativo(ejeX = 22), new Patito(ejeX = 24), new Patito(ejeX = 26), new PatitoAlternativo(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Patito(ejeX = 38), new Patito(ejeX = 40), new PatitoAlternativo(ejeX = 44), new Patito(ejeX = 46), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new Patito(ejeX = 54), new Patito(ejeX = 56), new Patito(ejeX = 58), new Patito(ejeX = 60), new PatitoAlternativo(ejeX = 62), new PatitoAlternativo(ejeX = 64), new Patito(ejeX = 66), new Patito(ejeX = 68), new Patito(ejeX = 70), new Patito(ejeX = 72)]
