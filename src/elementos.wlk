import wollok.game.*
import direcciones.*
class Bloque {
	var property position
	const property llegadas
	const property image = "caja.png" 	
	method puedePisarse() = false
	method puedeConsumirse() = false
	
	
	method movete(direccion){
		self.validarLugar(direccion)
		position = direccion.moverSiguiente(self.position(),self)
	}
	method validarLugar(direccion){
		const posAlLado = direccion.moverSiguiente(self.position(),self)
		const hayLugar = game.getObjectsIn(posAlLado).all{ obj => obj.puedePisarse()}
		
		if(!hayLugar){
			throw new Exception(message = "No puedo moverme!")
		}
	}
	method afectar(player){
		player.retroceder()
		return 1
	}
	method estaEnDeposito(){
		return llegadas.map{ llegada => llegada.position()}.contains(self.position())
	}
}


