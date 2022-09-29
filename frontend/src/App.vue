<template>
  <v-app>
    <Header />
    <div style="margin-top: 35px">
      <router-view/>
    </div>
  </v-app>
</template>

<script>
import Header from '@/components/Header.vue'

export default {
  name: 'App',
  components: {
    Header
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>