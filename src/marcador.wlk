import personajes.*
import wollok.game.*

//object fondoMarcador{
//	var property position = game.at(0,game.height())
// 	method imagen() = 'fondoBlanco.png'
//}
object energia{
	var property position = game.at(2,game.height()-1)
	method text() = "Energia: " + bubba.energia()
}
object salud{
	var property position = game.at(4,game.height()-1)
	method text() = "Salud: " + bubba.salud()
}
object dinero{
	var property position = game.at(6,game.height()-1)
	method text() = "Dinero: " + bubba.dinero()
}
object municion{
	var property position = game.at(8,game.height()-1)
	method text() = "Municiones: " + bubba.municiones()
}