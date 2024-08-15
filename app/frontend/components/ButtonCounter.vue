<script>
export default {
  data() {
    return {
      count: 0
    }
  }
}
</script>

<template>
  <button class="button" @click="count++">You clicked me {{count}} times.</button>
</template>
