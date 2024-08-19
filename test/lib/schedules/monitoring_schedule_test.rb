require "test_helper"
require "schedules/monitoring_schedule"

class MonitoringScheduleTest < ActiveSupport::TestCase
  test "create schedule" do
    monitoring_schedule = MonitoringSchedule.new(contract_schedule, employee_availability_schedule)
    assert_equal(monitoring_schedule.assignments, assignments)
  end

  def contract_schedule
    {
      "Monday" => { starts_at: "19:00", ends_at: "00:00" },
      "Tuesday" => { starts_at: "19:00", ends_at: "00:00" },
      "Wednesday" => { starts_at: "19:00", ends_at: "00:00" },
      "Thursday" => { starts_at: "19:00", ends_at: "00:00" },
      "Friday" => { starts_at: "19:00", ends_at: "00:00" },
      "Saturday" => { starts_at: "10:00", ends_at: "00:00" },
      "Sunday" => { starts_at: "10:00", ends_at: "00:00" }
    }
  end

  # Hash de disponibilidades diarias de los empleados
  # Por cada día de la semana, se define un rango de tiempo en el que cada empleado está disponible
  # La disponibilidad de los empleado siempre deben caer dentro del rango de un contrato.
  # Si el contrato especifica que el lunes el turno a cubrir es de 19:00 a 00:00,
  # Ejemplos de rangos validos de disponibilidad son:
  # 1. 19:00 a 00:00 cobertura total
  # 2. 20:00 a 22:00, cobertura parcial
  # Ejemplos de rangos invalidos de disponibilidad son:
  # 1. 18:00 a 01:00 (del otro dia), cobertura total que cae fuera del rango de contrato
  # 2. 18:00 a 21:00, cobertura parcial que cae fuera del rango de contrato
  # TODO: Validar que las disponibilidades siempre estén dentro del rango del contrato, o
  #       simplemente ignorar los bloques de tiempo sobrantes de las disponibilidades de empleados
  #       Ej.: Si el empleado esta disponible de 18:00 y el contrato inicia a las 19:00, considerar
  #       que el empleado cubre desde las 19:00. Tener en cuenta que un validación puede requerir
  #       procesamiento e iteraciones extras por lo que si resulta sencillo y menos demandante,
  #       es mejor ignorar la disponibilidad sobrante.
  def employee_availability_schedule
    {
      "Monday" => [
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Benjamín" }
      ],
      "Tuesday" => [
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Ernesto" },
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Bárbara" },
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Benjamín" }
      ],
      "Wednesday" => [
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Bárbara" },
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Benjamín" }
      ],
      "Thursday" => [
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Ernesto" },
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Bárbara" },
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Benjamín" }
      ],
      "Friday" => [
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Ernesto" },
        { starts_at: "19:00", ends_at: "00:00", employee_id: "Bárbara" }
      ],
      "Saturday" => [
        { starts_at: "10:00", ends_at: "15:00", employee_id: "Ernesto" },
        { starts_at: "18:00", ends_at: "21:00", employee_id: "Bárbara" },
        { starts_at: "18:00", ends_at: "00:00", employee_id: "Benjamín" }
      ],
      "Sunday" => [
        { starts_at: "10:00", ends_at: "00:00", employee_id: "Bárbara" }
      ]
    }
  end
  def employees
    [
      {
        name: "Ernesto",
        availability: [
          { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
          { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
          { starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # Vie 06 de Marzo
          { starts_at: Time.parse("2020-03-07 10:00:00"), ends_at: Time.parse("2020-03-07 15:00:00") } # Sáb 07 de Marzo
        ]
      },
      {
        name: "Bárbara",
        availability: [
          { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
          { starts_at: Time.parse("2020-03-04 19:00:00"), ends_at: Time.parse("2020-03-05 00:00:00") }, # Mie 04 de Marzo
          { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
          { starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # Vie 06 de Marzo
          { starts_at: Time.parse("2020-03-07 18:00:00"), ends_at: Time.parse("2020-03-07 21:00:00") }, # Sáb 07 de Marzo
          { starts_at: Time.parse("2020-03-08 10:00:00"), ends_at: Time.parse("2020-03-09 00:00:00") } # Dom 08 de Marzo
        ]
      },
      {
        name: "Benjamín",
        availability: [
          { starts_at: Time.parse("2020-03-02 19:00:00"), ends_at: Time.parse("2020-03-03 00:00:00") }, # Lun 02 de Marzo
          { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
          { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
          { starts_at: Time.parse("2020-03-07 18:00:00"), ends_at: Time.parse("2020-03-08 00:00:00") } # Sáb 07 de Marzo
        ]
      }
    ]
  end

  def shifts
    [
      { starts_at: Time.parse("2020-03-02 19:00:00"), ends_at: Time.parse("2020-03-03 00:00:00") }, # Lun 02 de Marzo
      { starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
      { starts_at: Time.parse("2020-03-04 19:00:00"), ends_at: Time.parse("2020-03-05 00:00:00") }, # Mie 04 de Marzo
      { starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
      { starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # Vie 06 de Marzo
      { starts_at: Time.parse("2020-03-07 10:00:00"), ends_at: Time.parse("2020-03-08 00:00:00") }, # Sáb 07 de Marzo
      { starts_at: Time.parse("2020-03-08 10:00:00"), ends_at: Time.parse("2020-03-09 00:00:00") } # Dom 08 de Marzo
    ]
  end

  def assignments
    [
      { employee: "Benjamín", starts_at: Time.parse("2020-03-02 19:00:00"), ends_at: Time.parse("2020-03-03 00:00:00") }, # Lun 02 de Marzo
      { employee: "Ernesto", starts_at: Time.parse("2020-03-03 19:00:00"), ends_at: Time.parse("2020-03-04 00:00:00") }, # Mar 03 de Marzo
      { employee: "Benjamín", starts_at: Time.parse("2020-03-04 19:00:00"), ends_at: Time.parse("2020-03-05 00:00:00") }, # Mie 04 de Marzo
      { employee: "Ernesto", starts_at: Time.parse("2020-03-05 19:00:00"), ends_at: Time.parse("2020-03-06 00:00:00") }, # Jue 05 de Marzo
      { employee: "Bárbara", starts_at: Time.parse("2020-03-06 19:00:00"), ends_at: Time.parse("2020-03-07 00:00:00") }, # Vie 06 de Marzo
      { employee: "Ernesto", starts_at: Time.parse("2020-03-07 10:00:00"), ends_at: Time.parse("2020-03-07 15:00:00") }, # Sáb 07 de Marzo
      { employee: "Sin Asignar", starts_at: Time.parse("2020-03-07 15:00:00"), ends_at: Time.parse("2020-03-07 18:00:00") }, # Sáb 07 de Marzo
      { employee: "Benjamín", starts_at: Time.parse("2020-03-07 18:00:00"), ends_at: Time.parse("2020-03-08 00:00:00") }, # Sáb 07 de Marzo
      { employee: "Barbara", starts_at: Time.parse("2020-03-08 10:00:00"), ends_at: Time.parse("2020-03-09 00:00:00") } # Dom 08 de Marzo
    ]
  end
end
