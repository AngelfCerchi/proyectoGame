import wollok.game.*

class Botiquin{
	var property position
	const property image = "botiquin.png"
	var property aporta = 15
	method puedeComerse() = true
	method serConsumido(){
		game.removeVisual(self)
		
	}
	method afectar(bubba){return 0}
}

class Hamburguesa{
	var property position
	const property image = "hamburger.png"
	var property aporta = 5
	method accion(direccion){}
	method puedeComerse() = true
	method serConsumido(){
		game.removeVisual(self)
		
	}
	method afectar(bubba){return 0}

}