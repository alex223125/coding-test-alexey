<template>
  <div id="app">
    <v-app>
      <p>{{ message }}</p>
      <report/>
    </v-app>
  </div>
</template>

<script>

import report from "./components/report.vue";

export default {
  data: function() {
    return {
      message: "Hello Vue!"
    };
  },
  components: {
    report: report
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>