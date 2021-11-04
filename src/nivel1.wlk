import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*
import marcador.*
import consumibles.*
import direcciones.*
import deposito.*
object nivelBloques {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo())
			
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(new Bloque(position=game.at(3,5)))
		game.addVisual(new Bloque(position=game.at(3,3)))
		game.addVisual(new Botiquin(position=game.at(3,2)))
		game.addVisual(new Hamburguesa(position=game.at(5,2)))
		game.addVisual(salud)
		game.addVisual(energia)
		game.addVisual(dinero)
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(bubba)
		
		//DEPOSITO
		var depositos = [new Deposito(),new Deposito()]
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		// Movimientos
		keyboard.up().onPressDo({ bubba.direccion(arriba) bubba.avanzar() })
		keyboard.down().onPressDo({ bubba.direccion(abajo) bubba.avanzar() })
		keyboard.left().onPressDo({ bubba.direccion(izquierda) bubba.avanzar() })
		keyboard.right().onPressDo({ bubba.direccion(derecha) bubba.avanzar() })
		keyboard.space().onPressDo({ bubba.comer()})		
		

		// en este no hacen falta colisiones
		game.whenCollideDo(bubba, { elemento => bubba.empujar(elemento)})
		}

	method perder(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="gameover.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="finNivel1.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
			})
		})
	}
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondoCompleto.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="finNivel1.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})
	}
		
}

