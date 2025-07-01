import visuales.*
import sonidos.*

object juego {
    var objetos = null
    

    method iniciar() {
        game.clear()
    
        //Imagenes de pantalla de inicio:
        game.addVisual(pantalla)
        keyboard.enter().onPressDo { 
            pantalla.cambiarImagen()
            quack.play()
        }


        keyboard.num1().onPressDo( {
            objetos = [new Patito(ejeX = 14), new Patito(ejeX = 16), new Patito(ejeX = 18), new Patito(ejeX = 20), new PatitoMalo(ejeX = 22), new Patito(ejeX = 24), new Patito(ejeX = 26), new Patito(ejeX = 28), new Patito(ejeX = 30), new PatitoMalo(ejeX = 32), new Patito(ejeX = 34), new Cofre(ejeX = 36), new PatitoMalo(ejeX = 38), new Patito(ejeX = 40), new Reloj(ejeX=42), new Patito(ejeX = 44), new Patito(ejeX = 46), new Patito(ejeX = 48), new Patito(ejeX = 50), new Patito(ejeX = 52), new Patito(ejeX = 54), new Patito(ejeX = 56), new Patito(ejeX = 58), new Patito(ejeX = 60), new Patito(ejeX = 62), new Patito(ejeX = 64), new Patito(ejeX = 66), new Patito(ejeX = 68), new Patito(ejeX = 70), new Patito(ejeX = 72), new Patito(ejeX = 74), new Patito(ejeX = 76), new Patito(ejeX = 78), new Patito(ejeX = 80), new Patito(ejeX = 82), new Patito(ejeX = 84), new Patito(ejeX = 86), new Patito(ejeX = 88), new Cofre(ejeX = 90), new Patito(ejeX = 92), new Patito(ejeX = 94), new Patito(ejeX = 96), new Patito(ejeX = 98), new Patito(ejeX = 100), new Patito(ejeX = 102), new Patito(ejeX = 104), new Patito(ejeX = 106), new Patito(ejeX = 108), new Patito(ejeX = 110)]
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
        // Añadimos interfaz
        game.clear()
        

        // var tiempo = new Contador(ejeX = 2, texto = "Tiempo: ", valorInicial = 20)
        // var patitosDetonados = new Contador(ejeX = 5, texto = "Patitos: ", valorInicial = 0)
        // var contadorBalas = new Contador(ejeX = 8, texto = "Balas restantes: ", valorInicial = 20 )
        // var contadorPuntos = new Contador(ejeX = 11, texto = "Puntos: ", valorInicial = 0)

        [contadorBalas, tiempo, patitosDetonados, contadorPuntos].forEach { interfaz => 
            game.addVisual(interfaz)
            interfaz.reiniciar()
        }
        
        // Añadimos musica y sonidos
        game.sound(cancionFondo)
        game.sound(sonidoGolpe)

        // Aca añadimos patitos y mira
        objetos.forEach { objeto => game.addVisual(objeto) }
        game.addVisual(mira)

        // Para que cada 1/4 de segundo, se muevan
        game.onTick(250, "movimiento", { 
            objetos.forEach { objeto => objeto.moverse() }
            })
        
        // Para que se mueva la mira
        game.onTick(50, "movimiento de la mira", {
            mira.moverse()
            // Esto evita que la mira se salga del tablero, y cambie de direccion al llegar a un extremo
            if (mira.position().x() == game.width() - 1.2 or mira.position().x() == 0) {
                mira.cambiarDireccion()
            }
        })
        
        // Para que el tiempo se actualice
        game.onTick(1000, "tiempo", {
            tiempo.restar(1)
            // En caso de que se acabe el tiempo o las balas, el juego termina
            if (tiempo.contador() == 0 or contadorBalas.contador() == 0) {
                [contadorBalas, tiempo, patitosDetonados, contadorPuntos].forEach {interfaz => game.removeVisual(interfaz)}
                game.addVisual(new Texto(text="Patitos detonados: " + patitosDetonados.contador(), position = game.at(7, 4)))
                game.addVisual(new Texto(text="Puntos: " + contadorPuntos.contador(), position = game.at(7, 3)))
                pantalla.imagenFinal()
                game.addVisual(pantalla)
                game.removeVisual(mira)
            }
        })
        
        // Para dispararle a un objeto con espacio
        keyboard.space().onPressDo {
            contadorBalas.restar(1)
            var objetoEncontrado = objetos.find { patito => game.onSameCell(patito.position(), mira.position())}
            if (objetoEncontrado != null and contadorBalas.contador() != 0 and tiempo.contador() != 0) {
                game.removeVisual(objetoEncontrado)
                objetoEncontrado.recibirDisparo()
                contadorPuntos.sumar(objetoEncontrado.puntosQueDa())
            } 
        }

        // Para reiniciar
        keyboard.r().onPressDo {
            pantalla.reiniciar()
            self.iniciar()
        }
    }
}