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
      <!-- <side-bar/> -->
      <option-space/>
      <make-space/>
    </v-content>
  </v-app>
</template>

<script>
import MakeSpace from './components/MakeSpace';
//import SideBar from './components/SideBar';
import OptionSpace from './components/OptionSpace';

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
    MakeSpace,
    //SideBar,
    OptionSpace
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
