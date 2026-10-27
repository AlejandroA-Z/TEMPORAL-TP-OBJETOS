
//ASISTENTE
class Asistente{
    var property tipoAbono
    var property historialDeEntradas = []
    var property dineroDisponible = 0

    method comprar(entrada, fecha) = productora.comprar(entrada, self, fecha)

    method montoAPagar(entrada) = tipoAbono.precioFinal(entrada.precio())

    method agregarAlHistorial(entrada){
        historialDeEntradas.add(entrada)
    }
    
    method pagar(monto){
        dineroDisponible = dineroDisponible - monto
    }

    method esVip() = tipoAbono.esVip()

    method bonificar(){
      tipoAbono.bonificar()
    }

    
    method entradasDelAnioAnterior(unAnio){
       return historialDeEntradas.filter({unaEntrada => unaEntrada.obtenerAnio() == (unAnio-1)})
    }

    method verBandas(){
        return historialDeEntradas.map({unaEntrada => unaEntrada.banda().nombre()})
    }

}


//TIPO DE ABONO DE LOS ASISTENTES----------------------------------------

object fan {
  const property porcentajeDescuento = 0

  method esVip() = false

  method precioFinal(precio) = precio

  method bonificar(){}

} 


class Vip{
  var property porcentajeDescuento

  method esVip() = true

  method precioFinal(precio) = precio - (precio * porcentajeDescuento / 100)

  method bonificar(){
    porcentajeDescuento += 1
  }
}



//-----------------------------------------------------

//ENTRADA
class Entrada{

    const property banda
    var property fecha
    const property precioBase = 1000
    
    //PRECIO INICIAL
    method precio(){
        return precioBase + productora.impuesto()
    }

    method obtenerAnio(){
        return self.fecha() % 10000
    }


}



//------------------------------------------------

object productora{

    var property impuesto = 0
    
    var property recaudacion = 0
    var property listaAsistentes = #{}
    var property bandasExistentes = #{}

    method agregarBanda(unaBanda){
      bandasExistentes.add(unaBanda)
    }

    method agregarAsistente(asistente){
      listaAsistentes.add(asistente)
    }


    method comprar(entrada, asistente, fecha){
        if(asistente.dineroDisponible() <= 0){
            self.error("No hay dinero suficiente")
        }else{
            if(entrada.fecha() == fecha){
            asistente.pagar(asistente.montoAPagar(entrada))
            asistente.agregarAlHistorial(entrada)
            self.agregarAsistente(asistente)
            recaudacion = recaudacion + entrada.precio()
            (entrada.banda()).sumarEntrada()
            return "Se compro entrada"
        }else{
           return "No hay entrada para esa fecha"
        }
    }
    
    }

    //GANANCIA TOTAL
    method gananciaTotal(){
        return recaudacion - self.presupuestoTotalBandas()
    }

    method presupuestoTotalBandas(){
        return bandasExistentes.sum({unaBanda => unaBanda.presupuesto()})
    }

    //--------------------------------------------------------------------

    //TOTAL ENTRADAS VENDIDAS
    method totalEntradasVendidas(){
        return bandasExistentes.sum({unaBanda => unaBanda.cantEntradasVendidas()})
    }
    //--------------------------------------------------------------------

    //BANDA MAS POPULAR 
    method bandaMasPopular(){
      return (bandasExistentes.max({ unaBanda => unaBanda.cantEntradasVendidas()})).nombre()
    }
    //---------------------------------------------------------------------
    
    //BONIFICAR VIP
    method obtenerVips() = listaAsistentes.filter({unAsistente => unAsistente.esVip()})

    method bonificarAsistentes(){
      (self.obtenerVips()).forEach({unAsistente => unAsistente.bonificar()})
    }




}





//CODIGO DE BANDAS ------------------------------

class Banda{

    var property nombre
    var property cantEntradasVendidas = 0

    method canon() = 1000000

    method sumarEntrada(){
        cantEntradasVendidas = cantEntradasVendidas + 1
    }

    method gastoExtra() = 0

    method presupuesto() = self.canon() + self.gastoExtra()

    method popularidad()


}



class Rock inherits Banda{
    var property solosDeGuitarra

    override method gastoExtra() = 10000

    override method popularidad(){
        return solosDeGuitarra * 100
    }

}


class Indie inherits Banda{

    var property cantInstrumentos

    override method gastoExtra() = cantInstrumentos * 500

    override method popularidad(){
        return (nombre.size() * 3.14)
    }

}


class Trap inherits Banda{
    var property hielo

    override method popularidad(){
        if(hielo){
            return 1000
        }else{
            return 0
        }
    }

    override method canon(){
      return 1000000 * self.popularidad()
    }

}
