import wollok.game.*
class Consumibles{
	var property position
	var property image
	var property aporta 
	method puedeConsumirse() = true
	method serConsumido(player)
	method movete(dir) {}
	
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
	override method serConsumido(player){
		game.removeVisual(self)
		player.municiones(player.municiones() + aporta)
	}
}

class Dinero inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		player.dinero(player.dinero() + aporta)		
	}
}