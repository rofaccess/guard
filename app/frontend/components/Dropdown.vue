<script>
export default {
  props: {
    data: Object
  },
  mounted() {
    console.log('El componente Dropdown ha sido montado en el DOM');
    console.log(this.data);
  }
}
</script>

<template>
  <div class="dropdown is-hoverable">
    <div class="dropdown-trigger">
      <button class="button is-primary" aria-haspopup="true" aria-controls="dropdown-menu4">
        <span>Editar Disponibilidad</span>
        <span class="icon is-small">
        <i class="fas fa-angle-down" aria-hidden="true"></i>
      </span>
      </button>
    </div>
    <div class="dropdown-menu" id="dropdown-menu4" role="menu">
      <div class="dropdown-content">
        <div class="dropdown-item">
          <a v-for="(value, key) in data" :href="`/employee_week_schedule/${key}/edit`" :key="key" class="dropdown-item"> {{ value }} </a>
        </div>
      </div>
    </div>
  </div>
</template>
