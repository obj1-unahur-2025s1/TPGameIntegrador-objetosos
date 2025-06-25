import visuales.*
import sonidos.*

object juego {
    var objetos = null

    method iniciar() {
        game.clear()

        //Imagenes de pantalla de inicio:
        game.addVisual(imagenInicio1)
        keyboard.enter().onPressDo { 
            game.removeVisual(imagenInicio1)
            game.addVisual(imagenInicio2)
            quack.play()
        }

        keyboard.num1().onPressDo( {
            objetos = [new Patito(ejeX = 14), new Patito(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new Patito(ejeX = 22), new Patito(ejeX = 24), new Patito(ejeX = 26), new Patito(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Cofre(ejeX = 36), new Patito(ejeX = 38), new Patito(ejeX = 40), new Reloj(ejeX=42), new Patito(ejeX = 44), new Patito(ejeX = 46), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new Patito(ejeX = 54), new Patito(ejeX = 56), new Patito(ejeX = 58), new Patito(ejeX = 60), new Patito(ejeX = 62), new Patito(ejeX = 64), new Patito(ejeX = 66), new Patito(ejeX = 68), new Patito(ejeX = 70), new Patito(ejeX = 72), new Patito(ejeX = 74), new Patito(ejeX = 76), new Patito(ejeX = 78), new Patito(ejeX = 80), new Patito(ejeX = 82), new Patito(ejeX = 84), new Patito(ejeX = 86), new Patito(ejeX = 88), new Cofre(ejeX = 90), new Patito(ejeX = 92), new Patito(ejeX = 94), new Patito(ejeX = 96), new Patito(ejeX = 98), new Patito(ejeX = 100), new Patito(ejeX = 102), new Patito(ejeX = 104), new Patito(ejeX = 106), new Patito(ejeX = 108), new Patito(ejeX = 110)]
            self.configurate() 
            quack.play()
            })
        keyboard.num2().onPressDo({
            objetos = [new Patito(ejeX = 14), new PatitoAlternativo(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new PatitoAlternativo(ejeX = 22, subio = false), new Patito(ejeX = 24), new Patito(ejeX = 26), new PatitoAlternativo(ejeX = 28), new Patito(ejeX = 30), new Patito(ejeX = 32), new Patito(ejeX = 34), new Cofre(ejeX = 36), new Patito(ejeX = 38), new PatitoAlternativo(ejeX = 40, subio = false), new Patito(ejeX = 42), new Patito(ejeX = 44), new PatitoAlternativo(ejeX = 46, subio=false), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new PatitoAlternativo(ejeX = 54), new Patito(ejeX = 56), new PatitoAlternativo(ejeX = 58, subio =false), new PatitoAlternativo(ejeX = 60), new Patito(ejeX = 62), new Patito(ejeX = 64), new Patito(ejeX = 66), new PatitoAlternativo(ejeX = 68, subio=false), new Patito(ejeX = 70), new Patito(ejeX = 72), new Patito(ejeX = 74), new PatitoAlternativo(ejeX = 76), new PatitoAlternativo(ejeX = 78, subio =false), new Patito(ejeX = 80), new Patito(ejeX = 82), new Patito(ejeX = 84), new PatitoAlternativo(ejeX = 86), new Patito(ejeX = 88), new Patito(ejeX = 90), new PatitoAlternativo(ejeX = 92, subio=false), new Patito(ejeX = 94), new Patito(ejeX = 96)]
            self.configurate()
            quack.play() 
            })
    }
    
    method configurate() {
        // añadimos interfaz
        game.clear()
        [contadorBalas, tiempo, patitosDetonados, contadorPuntos].forEach {interfaz => interfaz.reiniciar()}
        game.addVisual(contadorPuntos)
        game.addVisual(tiempo)
        game.addVisual(patitosDetonados)
        game.addVisual(contadorBalas)
        
        //añadimos musica y sonidos
        game.sound(cancionFondo)
        game.sound(sonidoGolpe)

        // añadimos patitos y mira
        objetos.forEach { patito => game.addVisual(patito) }
        game.addVisual(mira)

        // que cada un segundo, se muevan
        game.onTick(250, "movimiento", { 
            objetos.forEach { patito => patito.moverse() }
            })
        
        // que se mueva la mira
        game.onTick(50, "movimiento de la mira", {
            mira.moverse()
            if (mira.position().x() == game.width() - 1.2 or mira.position().x() == 0) {
                mira.cambiarDireccion()
            }
        })
        
        // para que el tiempo se actualice
        game.onTick(1000, "tiempo", {
            tiempo.restar()
            if (tiempo.contador() == 0 or contadorBalas.balas() == 0) {
                [tiempo, patitosDetonados, contadorPuntos, contadorBalas].forEach {interfaz => game.removeVisual(interfaz)}
                game.addVisual(new Texto(text="¡Tiempo!", position=game.at(7, 5)))
                game.addVisual(new Texto(text="Patitos detonados: " + patitosDetonados.cantidad(), position = game.at(7, 4)))
                game.addVisual(new Texto(text="Puntos: " + contadorPuntos.puntos(), position = game.at(7, 3)))
                game.addVisual(new Texto(text="¿Jugar de vuelta? (R)", position = game.at(7, 1)))
                game.removeVisual(mira)
            }
        })
        
        // matar patito
        keyboard.space().onPressDo {
            contadorBalas.gastarBala()
            var objetoEncontrado = objetos.find { patito => game.onSameCell(patito.position(), mira.position())}
            if (objetoEncontrado != null and contadorBalas.balas() != 0 and tiempo.contador() != 0) {
                game.removeVisual(objetoEncontrado)
                objetoEncontrado.recibirDisparo()
                contadorPuntos.sumar(objetoEncontrado.puntosQueDa())
            } 
        }

        // reiniciar
        keyboard.r().onPressDo {
            self.iniciar()
        }
    }
}