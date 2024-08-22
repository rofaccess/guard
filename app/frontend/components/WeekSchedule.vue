<script>
export default {
  props: {
    schedule: Object,
    employeeColors: Array
  },
  data() {
    return {
      schedule: this.schedule
    }
  },
  mounted() {
    console.log('El componente WeekSchedule ha sido montado en el DOM');
    console.log(this.schedule);
    console.log(this.employeeColors);
  }
}
</script>

<template>
  <div class="fixed-grid has-1-cols-mobile has-5-cols-desktop has-7-cols-fullhd">
    <div class="grid">
      <div v-for="(timeBlocks, day) in schedule" :key="day" class="cell">
        <h2 class="subtitle"><strong>{{ day }}</strong></h2>
        <table class="table is-bordered">
          <thead>
          <tr class="is-dark">
            <th class="has-text-white">Hora</th>
            <th class="has-text-white">Empleado</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(employee, timeBlock) in timeBlocks" :key="timeBlock">
            <td class="has-background-success-light">{{ timeBlock }}</td>
            <td :class="[employeeColors[employee]]">{{ employee }}</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
