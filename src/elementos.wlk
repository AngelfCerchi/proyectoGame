import wollok.game.*
import direcciones.*
class Elementos{
	var property position
	var property image 
	
	//Abstact
	method puedePisarse()
	method puedeConsumirse()
	method puedeRecibirDanio()
	method moverse(direccion)
	
}
class Cajas inherits Elementos {
	override method puedePisarse() = false
	override method puedeConsumirse() = false
	override method puedeRecibirDanio() = false
	
	override method moverse(direccion){
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
		player.energia(player.energia()+1)
	}

}



