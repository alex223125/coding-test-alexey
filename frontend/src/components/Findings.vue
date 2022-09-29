<template>
  <v-data-table :headers="headers" :items="findings" sort-by="title" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Findings</v-toolbar-title>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>



        <v-dialog v-model="showDialog" max-width="900px">
          <v-card>
            <v-card-title>
              <span class="headline">{{ "Show finding" }}</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.port" label="Port"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.svc_name" label="Svc name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.protocol" label="Protocol"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.severity" label="Severity"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.plugin_id" label="Plugin id"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="12" md="12">
                    <v-text-field readonly v-model="finding.plugin_name" label="Plugin name"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.plugin_family" label="Plugin family"></v-text-field>
                  </v-col>

                  <v-col cols="16" sm="12" md="12">
                    <v-textarea readonly v-model="finding.data" label="Data"></v-textarea>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.fname" label="fname"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.plugin_modification_date" label="Plugin modification date"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.plugin_publication_date" label="Plugin publication date"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.plugin_type" label="Plugin type"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.risk_factor" label="Risk factor"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="finding.script_version" label="Script version"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="12" md="12">
                    <v-text-field readonly v-model="finding.synopsis" label="Synopsis"></v-text-field>
                  </v-col>

                  <v-col cols="12" sm="12" md="12">
                    <v-textarea readonly v-model="finding.plugin_output" label="Plugin output"></v-textarea>
                  </v-col>


                </v-row>
              </v-container>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="closeShowDialog">Cancel</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

      </v-toolbar>
    </template>

    <template v-slot:item.action="{ item }">
      <v-icon small class="mr-2" @click="getFinding(item)">show</v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>


  </v-data-table>

</template>

<script>
import axios from "axios";
export default {
  data: () => ({
    dialog: false,
    showDialog: false,
    headers: [
      { text: "Port", value: "port" },
      { text: "Svc name", value: "svc_name" },
      { text: "Protocol", value: "protocol" },
      { text: "Severity", value: "severity" },
      { text: "Plugin id", value: "plugin_id" },
      { text: "Plugin name", value: "plugin_name" },
      { text: "Plugin family", value: "plugin_family" },
      { text: "Actions", value: "action", sortable: false }
    ],
    findings: [],
    editedIndex: -1,
    editedItem: {
      title: "",
      link: "",
      source: "",
      version: ""
    },
    defaultItem: {
      title: "",
      link: "",
      source: "",
      version: ""
    },
    finding: []
  }),
  created() {
    this.initialize();
  },
  methods: {
    initialize() {
      return axios
          .get("http://localhost:3000/findings")
          .then(response => {

            console.log("Initialize method triggered");
            console.log(response.data);
            this.findings = response.data;
          })
          .catch(e => {
            console.log(e);
          });
    },
    closeShowDialog() {
      this.showDialog = false;
    },
    getFinding(item) {
      console.log("request started");
      axios
          .get(`http://localhost:3000/findings/${item.id}`)
          .then(response => {
            console.log("request got reposne");
            console.log(response.data);
            this.finding = response.data;
            console.log("finding assigned");

            console.log("opening window");
            this.showDialog = true;
          })
          .catch(error => {
            console.log(error);
          });

    }
  }
};
</script>