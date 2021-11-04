import wollok.game.*
import direcciones.*
import nivel1.*

object bubba {
	var property position = game.origin()
	var property image = "mandy.png"	
	var property energia = 30
	var property salud = 10
	var property dinero = 0
	var property municiones = 0
	var property direccion = izquierda
	
	
	// BUBBA COME	
	method comer(){
		const consumiblesArriba = self.objectoEnCeldaA(arriba).filter{ obj => obj.puedeComerse()}
		const consumiblesAbajo = self.objectoEnCeldaA(abajo).filter{ obj => obj.puedeComerse()}
		const consumiblesderecha = self.objectoEnCeldaA(derecha).filter{ obj => obj.puedeComerse()}
		const consumiblesizquierda = self.objectoEnCeldaA(izquierda).filter{ obj => obj.puedeComerse()}
		
		const todosLosConsumibles = [consumiblesArriba,consumiblesderecha,consumiblesAbajo,consumiblesizquierda].flatten()
		todosLosConsumibles.forEach{ consumible =>
			energia = energia+consumible.aporta()
			consumible.serConsumido()
			game.say(self,"Delicioso")
		}
	}
	
	// EMPUJAR ELEMENTOS -CAJAS
	method empujar(elemento){
		try{
			elemento.movete(self.direccion())
		}catch e{
			energia += elemento.afectar(self)
		}
	}
	method objectoEnCeldaA(dir){
		return game.getObjectsIn(dir.moverSiguiente(position,self))
	}


	method retroceder(){
		position = direccion.opuesto().moverSiguiente(position,self)
	}
		
	
	method morir(){
		//Falta implementar imagen al morir y implementar el metodo perder en nivel1
		image = "market.png"
		game.schedule(1500,{
			nivelBloques.perder()
				
			}
		)
	}
	//MOVIMIENTOS:
	method avanzar(){
		if(energia > 0){
			position = direccion.moverSiguiente(position,self)
			energia-=1
		}else{
			self.morir()
		}
		
	}
}

