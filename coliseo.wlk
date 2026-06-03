class ArmaDeFilo {
  var filo = 0
  //valores admitidos de filo 0 o 1
  var longitud = 0
  
  method valorDeAtaque(){
    return filo * longitud
  }
}
class ArmaContundente {
    var peso
    method valorDeAtaque(){
        return peso
    }
}
class Gladiador {
    var vida = 100
    method curar(){
        vida = 100
    }
    method atacar(unGladiador){
        unGladiador.recibirAtaque(self.poderDeAtaque() - unGladiador.defensa())
    }
    method poderDeAtaque()
    method destreza()
    method contraAtaque(unAtacante){
        if(vida > 0 and unAtacante.vida() > 0){
            self.atacar(unAtacante)
        }
    }
    method recibirAtaque(unValor, unAtacante){
        vida = (vida - unValor).max(0)
        self.contraAtaque(unAtacante)
    }
    method crearGrupoCon(unGladiador)
}
object casco {
    method puntosDeArmadura(unGladiador){
        return 10
    }
}
object escudo {
    method puntosDeArmadura(unGladiador){
        return 5 + unGladiador.destreza() * 0.1
    }
    
}
class Mirmillon inherits Gladiador {
    var fuerza
    var armadura
    var armaDeMano 
    override method destreza(){
        return 15
    }
    method cambiarArmadura(nuevaArmadura){
        armadura = nuevaArmadura
    }
    method cambiarArma(nuevaArma){
        armaDeMano = nuevaArma
    }
    override method poderDeAtaque(){
        return armaDeMano.valorDeAtaque() + fuerza
    }
    method defensa(){
        return armadura.puntosDeArmadura(self) + self.destreza()
    }
    override method crearGrupoCon(unGladiador){
        const mirmillolandia = new Grupo(nombre = "mirmillolandia")
        mirmillolandia.agregarGladiador(self)
        mirmillolandia.agregarGladiador(unGladiador)
        coliseo.agregarGrupo(mirmillolandia)
    }

}
class Dimachaerus inherits Gladiador {
    var destreza
    const armas = []
    const fuerza = 10
    override method destreza(){
        return destreza
    }
    method agregarArma(nuevaArma){
        armas.add(nuevaArma)
    }
    method removerArma(arma){
        armas.remove(arma)
    }
    method defensa(){
        return destreza.div(2)
    }
    override method atacar(unGladiador){
        super(unGladiador)
        destreza += 1
    }

    override method poderDeAtaque(){
        return fuerza + armas.sum({arma => arma.valorDeAtaque()})
    }
    override method crearGrupoCon(unGladiador){
        const poderDelDuo = self.poderDeAtaque() + unGladiador.poderDeAtaque()
        const grupo = new Grupo(nombre = "D -" + "  poderDelDuo ")
        grupo.agregarGladiador(self)
        grupo.agregarGladiador(unGladiador)
        coliseo.agregarGrupo(grupo)
    }
}
object coliseo {
    const grupos = []
    method agregarGrupo(unGrupo){
        grupos.add(unGrupo)
    }
    method removerGrupo(unGrupo){
        grupos.remove(unGrupo)
    }
    method iniciarCombate(grupo1, grupo2){
        self.round(grupo1, grupo2)
        self.round(grupo1, grupo2)
        self.round(grupo1, grupo2)
    }
    method round(grupo1,grupo2){
        const campeon1 = self.determinarCampeon(grupo1)
        const campeon2 = self.determinarCampeon(grupo2)
        if(campeon1.vida() > 0 && campeon2.vida() > 0){ 
            campeon1.atacar(campeon2)
        }
    }
    method determinarCampeon(grupo){
        return grupo.gladiadores().max({g => g.fuerza()})
    }
    method curar(){
        grupos.forEach({grupo =>
                        grupo.gladiadores().forEach({gladiador =>
                                                     gladiador.curar()})})
    }
}
class Grupo {
    var nombre 
    const gladiadores = []
    method gladiadores(){
        return gladiadores
    }
    var peleasParticipadas = 0
    method agregarGladiador(unGladiador){
        gladiadores.add(unGladiador)
    }
    method removerGladiador(unGladiador){
        gladiadores.remove(unGladiador)
    }
}