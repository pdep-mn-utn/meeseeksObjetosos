// ---------------------------------------------------------------------
// Punto 1 — Intentos
// ---------------------------------------------------------------------

class Intento {
  const property descripcion
  const property horas
}

// ---------------------------------------------------------------------
// Punto 1b — Colores y escala
// Cada color sabe su propia regla; la escala sabe qué colores tienen
// regla y cuál corresponde "en cualquier otro caso".
// ---------------------------------------------------------------------

object celeste {
  method correspondeA(meeseeks) = meeseeks.esRecienSalido() && meeseeks.tieneNombrePar()
}

object azul {
  method correspondeA(meeseeks) = meeseeks.horasDeExistencia().between(1, 5)
}

object violeta {
  method correspondeA(meeseeks) =
    meeseeks.horasDeExistencia() > 5 && meeseeks.horasDeExistencia() <= 24
}

object negro {}

object escalaDeColores {
  const colores = [celeste, azul, violeta]
  const colorPorDefecto = negro

  method colorPara(meeseeks) =
    colores.findOrDefault({ color => color.correspondeA(meeseeks) }, colorPorDefecto)
}

// ---------------------------------------------------------------------
// Puntos 1 y 3 — Meeseeks
// ---------------------------------------------------------------------

class Meeseeks {
  var nombre = "Mr. Meeseeks"
  const color = celeste
  var horasDeExistencia = 0
  var tareaActual
  const historial = []
  const escala = escalaDeColores

  // Consultas que el diseño obliga a exponer
  method nombre() = nombre
  method tareaActual() = tareaActual
  method horasDeExistencia() = horasDeExistencia
  method cantidadDeIntentos() = historial.size()
  method ultimoIntento() = historial.last()

  // Punto 1b
  method esRecienSalido() = horasDeExistencia < 1
  method tieneNombrePar() = nombre.size().even()
  method colorQueMerece() = escala.colorPara(self)

  // Punto 1c
  method estaSufriendo() = self.tieneColorEquivocado() || self.odiaSuTarea()
  method tieneColorEquivocado() = color != self.colorQueMerece()
  method odiaSuTarea() = tareaActual.contains("golf")

  // Punto 3 — interacciones
  method pedirAyuda(tarea) {
    horasDeExistencia = horasDeExistencia + 1
    tareaActual = tarea
  }

  method golpear() {
    nombre = nombre + " (enojado)"
    horasDeExistencia = self.horasDuplicadas()
  }

  method horasDuplicadas() = if (self.noTieneHoras()) 1 else horasDeExistencia * 2
  method noTieneHoras() = horasDeExistencia == 0

  method agradecer() {
    historial.add(new Intento(descripcion = tareaActual, horas = horasDeExistencia))
    horasDeExistencia = 0
    tareaActual = "ninguna"
  }

  method frustrarse() {
    self.golpear()
    self.golpear()
  }
}

// ---------------------------------------------------------------------
// Punto 4 — Interacciones reificadas (castigos)
// Su valor no es el comportamiento sino ser valores: se guardan,
// se pasan y se intercambian.
// ---------------------------------------------------------------------

object golpe {
  method aplicarA(meeseeks) { meeseeks.golpear() }
}

object agradecimiento {
  method aplicarA(meeseeks) { meeseeks.agradecer() }
}

object frustracion {
  method aplicarA(meeseeks) { meeseeks.frustrarse() }
}

class PedidoDeAyuda {
  const tarea
  method aplicarA(meeseeks) { meeseeks.pedirAyuda(tarea) }
}

// ---------------------------------------------------------------------
// Punto 4 — Criterios de colapso (Strategy)
// La caja sabe si colapsó y le delega el criterio a un objeto
// intercambiable que le consulta cosas a ella.
// ---------------------------------------------------------------------

object todosSufriendo {
  method colapsada(caja) = caja.cantidadDeSufridos() == caja.cantidadDeMeeseeks()
}

object mayoriaSufriendo {
  method colapsada(caja) = caja.cantidadDeSufridos() > caja.cantidadDeMeeseeks() / 2
}

object algunoSufriendo {
  method colapsada(caja) = caja.cantidadDeSufridos() > 0
}

// ---------------------------------------------------------------------
// Punto 4 — Caja
// Los castigos son pedidos reificados que el botón aplica en orden a
// cada Meeseeks; el criterio es parte de la responsabilidad de la caja
// (Strategy).
// ---------------------------------------------------------------------

class Caja {
  const meeseeks = #{}
  var property castigos
  var property criterioDeColapso = todosSufriendo

  method apretarBoton() {
    meeseeks.forEach { unMeeseeks => self.castigar(unMeeseeks) }
  }

  method castigar(unMeeseeks) {
    castigos.forEach { castigo => castigo.aplicarA(unMeeseeks) }
  }

  method colapso() = criterioDeColapso.colapsada(self)
  method cantidadDeSufridos() = meeseeks.count { unMeeseeks => unMeeseeks.estaSufriendo() }
  method cantidadDeMeeseeks() = meeseeks.size()

  // Se aprieta al menos una vez; la recursión sigue hasta el colapso.
  method apretarHastaColapsar() {
    self.apretarBoton()
    if (!self.colapso()) {
      self.apretarHastaColapsar()
    }
  }
}

// ---------------------------------------------------------------------
// Meeseeks de ejemplo
// ---------------------------------------------------------------------

const meeseeksDeJerry = new Meeseeks(
  tareaActual = "sacar dos golpes al golf",
  horasDeExistencia = 3,
  color = azul
)
