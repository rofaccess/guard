# Clase de utilería que agrupa métodos relacionados con el manejo de días.
class DayUtils
  # Se usa class << self para facilitar de manera más legible la privatización de algunos métodos de clase
  class << self
    # Devuelve el numero de un día dado. Monday es el día 1 (primer día de la semana) y Sunday es el día 7
    # > day_number("Monday")
    #   => 1
    # Implementación alternativa:
    #
    #   def day_number(day_name)
    #     day_names.index(day_name) + 1
    #   end
    #
    # Esta implementación no necesita de la construcción del hash day_numbers, pero..., como day_number se va a
    # utilizar muchas veces, es más eficiente obtener el número de un hash cuya construcción inicial no tiene mucho
    # impacto, en cambio day_names.index(day_name) al parecer tiene una complejidad O(n) y a pesar de que el arreglo
    # sólo tiene 7 elementos igual creo que vale la pena usar algo más eficiente como el hash.
    def day_number(day_name)
      day_numbers[day_name]
    end

    # Devuelve un arreglo con los nombres de los días en inglés y capitalizados. Ej.: [ "Monday", "Tuesday", ...]
    def day_names
      # La constante DAYNAMES contiene un arreglo cuyo primer día de la semana es "Sunday". Llamando a rotate
      # se manda "Sunday" al final del arreglo para que se convierte en el último día de la semana
      @day_names ||= Date::DAYNAMES.rotate(1)
      # Tips importantes sobre memoizing en métodos de clase:
      # - Al usar el bloque class << self, las variables pueden declararse con @ y seguirán siendo variables de clase
      #   y el memoizing funciona.
      # - Si no se usa el bloque class << self, osea el metodo se define como self.day_name, se puede usar el @, lo que
      #   estaría declarando una variable de instancia y no de clase, pero sería una variable de instancia de la clase
      #   Class y no de la clase en donde se lo está declarando, lo que supuestamente es una práctica no recomendada
      #   y puede causar problemas si no se entiende bien que es lo que pasa de fondo. Comprobé este caso e igual
      #   funciona, pero aún así por las dudas es mejor declarar una variable de clase @@ en este caso.
    end

    private

    # Devuelve un hash cuya clave es el número de día y valor el nombre del día. Ej.: { 1=>"Monday", 2=>"Tuesday", ... }
    def day_numbers
      # Con .map.with_index se crea un Enumerator cuyo índice comienza desde 1 porque se necesita que Monday sea el día 1,
      # luego se convierte el Enumerator en un hash
      day_names.map.with_index(1).to_h
    end
  end
end
