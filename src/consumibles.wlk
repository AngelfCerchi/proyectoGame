import wollok.game.*
import elementos.*
import direcciones.*
class Consumibles inherits Elementos{
	var property aporta 
	override method puedePisarse() = false
	override method puedeConsumirse() = true
	override method puedeRecibirDanio() = false
	override method moverse(dir) {}
	
	//Abstract
	method serConsumido(player)
	
	
}
class Energia inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		player.energia(player.energia() + aporta)
		
	}
}

class Salud inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		player.salud(player.salud() + aporta)
		
	}
}

class Municion inherits Consumibles{
	override method aporta() = 1
	override method serConsumido(player){
		game.removeVisual(self)
		player.municiones(player.municiones() + aporta)
	}
	method avanzar(direccion){
		position = direccion.moverSiguiente(position,self)
	}
}
class Dinero inherits Consumibles{ 
	override method puedePisarse() = true
	override method serConsumido(player){
		game.removeVisual(self)
		player.dinero(player.dinero() + aporta)	
		game.say(player,aporta.toString() + '! :D')	
	}
}