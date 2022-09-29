<template>
  <v-data-table :headers="headers" :items="reports" sort-by="title" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Reports</v-toolbar-title>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>

        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">New Item</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.title" label="Title"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="12" md="12">
                    <v-text-field v-model="editedItem.link" label="Link"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.source" label="Source"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.version" label="Version"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="save(editedItem)">Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>

        <v-dialog v-model="showDialog" max-width="500px">
          <v-card>
            <v-card-title>
              <span class="headline">{{ "Show report" }}</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="report.title" label="Title"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="12" md="12">
                    <v-text-field readonly v-model="report.link" label="Link"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="report.source" label="Source"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field readonly v-model="report.version" label="Version"></v-text-field>
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
      <v-icon small class="mr-2" @click="getReport(item)">show</v-icon>
      <v-icon small class="mr-2" @click="editItem(item)">edit</v-icon>
      <v-icon small @click="deleteItem(item)">delete</v-icon>
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
      {
        text: "Title",
        align: "left",
        sortable: false,
        value: "title"
      },
      { text: "Link", value: "link" },
      { text: "Source", value: "source" },
      { text: "Version", value: "version" },
      { text: "is_downloaded", value: "is_downloaded" },
      { text: "is_url_valid", value: "is_url_valid" },
      { text: "Actions", value: "action", sortable: false }
    ],
    reports: [],
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
    report: []
  }),
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    }
  },
  watch: {
    dialog(val) {
      val || this.close();
    }
  },
  created() {
    this.initialize();
  },
  methods: {
    initialize() {
      return axios
          .get("http://localhost:3000/reports")
          .then(response => {
            console.log(response.data);
            this.reports = response.data;
          })
          .catch(e => {
            console.log(e);
          });
    },
    editItem(item) {
      this.editedIndex = item.id;
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },
    deleteItem(item) {
      const index = this.reports.indexOf(item);
      confirm("Are you sure you want to delete this item?");
      axios
          .delete(`http://localhost:3000/reports/${item.id}`)
          .then(response => {
            console.log(response);
            console.log(response.data.json);
            alert(response.data.json);
            this.initialize();
          })
          .catch(error => {
            console.log(error);
          });
      this.reports.splice(index, 1);
    },
    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },
    closeShowDialog() {
      this.showDialog = false;
    },
    save(item) {
      if (this.editedIndex > -1) {
        axios
            .put(`http://localhost:3000/reports/${item.id}`, {
              id: this.editedItem.id,
              title: this.editedItem.title,
              link: this.editedItem.link,
              source: this.editedItem.source,
              version: this.editedItem.version
            })
            .then(response => {
              console.log(response);
              this.initialize();
            })
            .catch(error => {
              console.log(error);
            });
      } else {
        console.log(item);
        axios
            .post(`http://localhost:3000/reports/`, {
              report: this.editedItem
            })
            .then(response => {
              console.log(response);
              console.log("Created!");
              this.initialize();
            })
            .catch(error => {
              console.log(error);
            });
        this.reports.push(this.editedItem);
      }
      this.close();
    },
    getReport(item) {
      axios
          .get(`http://localhost:3000/reports/${item.id}`)
          .then(response => {
            console.log(response.data);
            this.report = response.data;
          })
          .catch(error => {
            console.log(error);
          });
      this.showDialog = true;
    }
  }
};
</script>