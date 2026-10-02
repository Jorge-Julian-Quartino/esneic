object esneic{
  var segmentos = [cabeza, cuerpo, cola]

  method agregarSegmento(segmento){
    segmentos.add(segmento)
  }

  method posicionOcupada(posicion){
    segmentos.any({ segmento => segmento.posicion() == posicion})
  }
}


object cabeza{
  var property position = self.generarPosicionAleatoria()
  var property direccion = "derecha"

  method generarPosicionAleatoria() {
    const x = 2.randomUpTo(19)
    const y = 0.randomUpTo(19)
    return game.at(x, y)
  }

  method cambiarDireccion(nuevaDireccion){
    direccion = nuevaDireccion
  }

  method mover(){
    if(direccion == "arriba") 
      position = position.up(1)
    if(direccion == "derecha") 
      position = position.right(1)
    if(direccion == "abajo") 
      position = position.down(1)
    if(direccion == "izquierda") 
      position = position.left(1)      
  }

  method image() {
    if(direccion == "abajo") 
      return "esneic/assets/cabeza-abajo.png"
    if(direccion == "izquierda") 
      return "esneic/assets/cabeza-izq.png"
    if(direccion == "arriba") 
      return "esneic/assets/cabeza-arriba.png"

    return "esneic/assets/cabeza-der.png"
  }

  method posicion() = position 
}

object cuerpo{
  var property position = self.seguirLaCabeza()

  method image() {
    if(cabeza.direccion() == "abajo" || cabeza.direccion() == "arriba") //mas que seguir a la cabeza, tiene que seguir al segmento siguiente
      return "esneic/assets/cuerpo-vertical.png"

    return "esneic/assets/cuerpo-horizontal.png"
  }

  method seguirLaCabeza() {
    return cabeza.posicion().left(1)
  }

  method posicion() = position 
}

object cola{
  var property position = cuerpo.posicion().left(1)
  var property direccion = "derecha"

  method image() {
      if(direccion == "abajo") 
        return "esneic/assets/cola-arriba.png"
      if(direccion == "izquierda") 
        return "esneic/assets/cola-der.png"
      if(direccion == "arriba") 
        return "esneic/assets/cola-abajo.png"
    return "esneic/assets/cola-izq.png"
  }
}

object manzana{
  var property position = self.generarPosicionAleatoria()

  method generarPosicionAleatoria() {
    const x = 0.randomUpTo(19)
    const y = 0.randomUpTo(19)
    return game.at(x, y)
  }

  method mover(){
    position = self.generarPosicionAleatoria()
  }

  method image() = "esneic/assets/manzana.png"
}