import wollok.game.*
class Consumibles{
	var property position
	var property image
	var property aporta 
	method puedeComerse() = true
	method serConsumido(player)
	method movete(dir) {}
	
}
class Energia inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		const nuevaEnergia = player.energia() + aporta
		player.energia(nuevaEnergia)
		
	}
}

class Salud inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		const nuevaSalud = player.salud() + aporta
		player.salud(nuevaSalud)
		
	}
}

class Municion inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		const nuevaMunicion = player.municiones() + aporta
		player.salud(nuevaMunicion)
	}
}

class Dinero inherits Consumibles{
	override method serConsumido(player){
		game.removeVisual(self)
		const nuevoDinero = player.dinero() + aporta
		player.salud(nuevoDinero)		
	}
}