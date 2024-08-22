<script>
export default {
  props: {
    summary: Object,
    employeeColors: Array
  },
  data() {
    return {
      summary: this.summary
    }
  },
  mounted() {
    console.log('El componente WeekScheduleSummary ha sido montado en el DOM');
    console.log(this.summary);
  }
}
</script>

<template>
  <table class="table is-striped is-fullwidth is-bordered">
    <thead>
    <tr class="is-dark">
      <th class="has-text-white" v-for="(value, key) in summary" :key="key">{{ key }}</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td v-for="(value, key) in summary" :key="key" :class="[employeeColors[key]]">{{ value }}</td>
    </tr>
    </tbody>
  </table>
</template>
