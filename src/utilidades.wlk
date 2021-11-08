import wollok.game.*

object utilidades {
	method posRandom() {
		return game.at(
			0.randomUpTo(game.width()-1).truncate(0), 0.randomUpTo(game.height()-2).truncate(0)
		)
	}
}

