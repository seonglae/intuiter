<template>
  <v-app>
    <v-app-bar app style="-webkit-app-region: drag">
      <v-toolbar-title class="headline text-uppercase">
        <span>Intuiter - </span>
        <span class="font-weight-light">Intuit Manager</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn text v-on:click="close">
        Exit
      </v-btn>
    </v-app-bar>

    <v-content>
      <LandingPage/>
    </v-content>
  </v-app>
</template>

<script>
import LandingPage from './components/LandingPage';

export default {
  methods: {
    close () {
      const remote = require('electron').remote
      let win = remote.getCurrentWindow()
      win.close()
    }
  },
  name: 'App',
  components: {
    LandingPage,
  },
  data: () => ({
    //
  }),
};
</script>

<style>
::-webkit-scrollbar {
    display: none;
}
button {
  -webkit-app-region: no-drag;
}
</style>
