<template>
  <v-container>
    <v-layout text-center wrap>
      <v-flex mb-4>
        <h1 class="display-2 font-weight-bold mb-3">Intuit Manager</h1>
        <v-btn v-on:click="make">Make and Run</v-btn>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    ecosystem: [
      {
        text: "how to use",
        href:
          "https://www.notion.so/seonglae/How-To-Use-Intuit-5831be99599e49dba750bd8d4620fc47"
      },
      {
        text: "github",
        href: "https://github.com/vuetifyjs/vuetify"
      },
      {
        text: "awesome-vuetify",
        href: "https://github.com/vuetifyjs/awesome-vuetify"
      }
    ],
    importantLinks: [
      {
        text: "Documentation",
        href: "https://vuetifyjs.com"
      },
      {
        text: "Chat",
        href: "https://community.vuetifyjs.com"
      },
      {
        text: "Made with Vuetify",
        href: "https://madewithvuejs.com/vuetify"
      },
      {
        text: "Twitter",
        href: "https://twitter.com/vuetifyjs"
      },
      {
        text: "Articles",
        href: "https://medium.com/vuetify"
      }
    ],
    whatsNext: [
      {
        text: "Explore components",
        href: "https://vuetifyjs.com/components/api-explorer"
      },
      {
        text: "Select a layout",
        href: "https://vuetifyjs.com/layout/pre-defined"
      },
      {
        text: "Frequently Asked Questions",
        href: "https://vuetifyjs.com/getting-started/frequently-asked-questions"
      }
    ]
  }),
  methods: {
    make() {
      let path = require("electron").remote.app.getAppPath()
      console.log(path)
      // command run
      let cmd = require("node-cmd")
      cmd.get(
        '"resources\\ahk\\exe\\ahk\\AutoHotkey.exe" "resources\\ahk\\make.ahk"',
        this.after_make
      )
    },

    after_make(err, data, stderr) {
      if (!err) {
        const remote = require("electron").remote
        let win = remote.getCurrentWindow()
        win.close()
        return
      }
      this.if_error(err, data, stderr)
    },
    
    if_error(err, data, stderr) {
      const { dialog } = require("electron")
      const options = {
        type: "error",
        title: "Error",
        message: "Some Error Occured",
        detail: "please press make button one more time"
      }
      dialog.showMessageBox(null, options, response => {
        console.log(response)
      })
      console.log("error", err, data, stderr)
    }
  }
}
</script>
