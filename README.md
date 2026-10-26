class Asistente{
    var property tipoAbono
    var historialDeEntradas = []
    var historialDeBandas = #{}
    var property dineroDisponible = 0

    method comprar(entrada) = productora.comprar(entrada, self)

    method agregarAlHistorial(entrada){
        historialDeEntradas.add(entrada)
        historialDeBandas.add(entrada.banda())
    }

}

//ASISTENTES----------------------------------------

class Vip{
    var porcentajeDescuento

}


object fan{
    var porcentajeDeDescuento = 0
} 

//-----------------------------------------------------

class Entrada{

    const property banda
    var property fecha
    var precioBase = 1000
    
    method precio(){
        return precioBase + productora.impuesto()
    }


}


object sistema{



}



//------------------------------------------------

object productora{

    var property gananciaTotal
    var property cantEntradasVendidas
    var property impuesto = 0
    
    var property recaudacion
    var property listaDeAsistentes = []
    var property vendieronEntradas = #{}



    method precioTotal(asistente, entrada){
        if(asistente.tipoAbono()!=vip){
        return entrada.precio()
        }else{
        return entrada.precio() - (entrada.precio() * asistente.abono().porcentajeDeDescuento())
        }
    }



    method comprar(entrada, asistente){
        if(asistente.dineroDisponible() < entrada.precio()){
            return "No cuenta con dinero suficiente"
        }else{
            asistente.dineroDisponible(asistente.dineroDisponible() - self.precioTotal())
            asistente.agregarAlHistorial(entrada)
            recaudacion = recaudacion + self.precioTotal()
            listaDeAsistentes.add(asistente)
            return "Se compro entrada"

        }
    }






    method presupuestoTotalBandas(){
        productira.listaDeAsistentes().map({unAsistente =>
        unAsistente.historialDeEntradas
        
        
        })
    }

    method gananciaTotal(){

    }


    method bandaMasPopular(){

    }

    method bonificarAsistente(){

    }


}







//CODIGO DE BANDAS ------------------------------

class Banda{

    var nombre
    var canon = 1000000
    var property presupuesto
    var propertyt cantEntradasVenddidas

    method presupuesto()

    method popularidad()


}


class Rock inherits Banda{
    const property nombre
    const property gastoExtra = 10000
    var property solosDeGuitarra

    override method presupuesto(){
        return canon + gastoExtra
    }

    override method popularidad(){
        return solosDeGuitarra * 1000
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

    override method presupuesto(){
        if(self.popularidad()>0){
            canon = canon * self.popularidad()
            return canon
        }
    }
}

class Indie inherits Banda{

    var property gastoExtra
    var property cantInstrumentos

    method gastoExtra(){
        return cantInstrumentos * 500
    }

    override method popularidad(){
        return (nombre.size() * 3.14).abs()
    }

    override method presupuesto(){
        return canon + self.gastoExtra()
    }

}

//---------------------------------------------------------



