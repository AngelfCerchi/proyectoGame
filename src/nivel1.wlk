import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel2.*
import marcador.*
import direcciones.*
import deposito.*
import consumibles.*
import enemigo.*
import celdaSorpresa.*
object nivelBloques {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image= "fondoNivelUno.jpg"))
		const hamburgesa = new Energia(position=game.at(3,2),image = 'hamburger.png',aporta = 10)
		const botiquin = new Salud(position=game.at(5,2),image = 'botiquin.png',aporta = 5)
		const lingotes = new Dinero(position=game.at(4,4), image='lingotes.png',aporta=20)
		const enemigoNormal = new EnemigoNormal(position = game.at(3,1), image="almacenaje.png",nivelDanio = 3,direccion = izquierda)
		const enemigoRandom = new EnemigoRandom(position = game.at(9,10), image="almacenaje.png",nivelDanio = 3,direccion = izquierda)
		const enemigoAsecho = new EnemigoAlAsecho(position = game.at(9,10), image="almacenaje.png",nivelDanio = 3,direccion = izquierda)
		const celdaElementorRnd = new CeldaElementoRandom(image = 'lingotes.png',position = game.at(5,5),puntos=0)
		const celdaTeleport = new CeldaTeleport(image = 'lingotes.png',position = game.at(5,10),puntos=0)
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(new Cajas(image = "caja.png", position=game.at(3,5)))
		game.addVisual(new Cajas(image = "caja.png",position=game.at(3,3)))
		game.addVisual(celdaElementorRnd)
		//CONSUMIBLES
		game.addVisual(hamburgesa)
		game.addVisual(lingotes)
		//ENEMIGOS
		const enemigos =[enemigoNormal,enemigoRandom,enemigoAsecho] // arreglo enemigos
		enemigos.forEach{ e => nivelBloques.dibujar(e)}
		enemigos.forEach{ e => game.whenCollideDo(e,{player => if(player.puedeRecibirDanio()){
			e.hacerDanio(player)
		}})}
		enemigos.forEach{ e => game.onTick(1000,"movimientoEnemigo",{
			if (e.seDesplazaNormal()){
				e.desplazarse()
			}else{
				e.desplazarseHacia(bubba)
			}
			
		})}
		//CELDA SORPRESA:
		const celdasSorpresas = [celdaElementorRnd,celdaTeleport]
		game.addVisual(celdaTeleport)
		celdasSorpresas.forEach{ e => game.whenCollideDo(e,{player => if(player.puedeRecibirDanio()){
			e.afectar(player)
		}})}
		
		//game.whenCollideDo(enemigo,{ player => if (player.puedeRecibirDanio()){
		//	enemigoNormal.hacerDanio(player)

		//}})
		
		
		
		//MARCADOR
		game.addVisual(salud)
		game.addVisual(energia)
		game.addVisual(dinero)
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(bubba)
		
		//DEPOSITO

		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		// Movimientos
		keyboard.up().onPressDo({ bubba.direccion(arriba) bubba.avanzar() })
		keyboard.down().onPressDo({ bubba.direccion(abajo) bubba.avanzar() })
		keyboard.left().onPressDo({ bubba.direccion(izquierda) bubba.avanzar() })
		keyboard.right().onPressDo({ bubba.direccion(derecha) bubba.avanzar() })
		keyboard.w().onPressDo({  
			if(bubba.municiones() > 0){
				const bala = new Municion(aporta = 0,image="hamburger.png",position=arriba.moverSiguiente(bubba.position(),bubba))
				game.addVisual(bala)
				bubba.municiones(bubba.municiones()-1)
				3.times({  n => bala.avanzar(arriba)})
				game.removeVisual(bala)
				
		}
		})

		keyboard.space().onPressDo({ bubba.comer()})		
		

		// en este no hacen falta colisiones
		game.whenCollideDo(bubba, { elemento =>
			if(!elemento.puedePisarse()){
				bubba.mover(elemento)
			}else{
				if(elemento.puedeConsumirse()){
					elemento.serConsumido(bubba)
				}
				
			}
		})
		//game.whenCollideDo(enemigoNormal, { elemento => 
		//	if(elemento.puedeRecibirDanio()){
		//		enemigoNormal.hacerDanio(elemento)
		//	}
		//})
}
	method dibujar(elemento) = game.addVisual(elemento)
		

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

