<template>
    <h1>Mail</h1>
    <div v-if="loading">Loading...</div>
    <div v-else-if="mail.length === 0">No mail found.</div>
    <div v-else>
      <ul>
        <li v-for="message in mail" :key="message.id">
          <strong>From:</strong> {{ message.name }}<br>
          <strong>Subject:</strong> {{ message.email }}<br>
          <p><strong>Body:</strong> {{ message.message }}</p>
          <hr>
          <button @click="deleteMail(message.contact_id)">Delete mail</button>
        </li>
      </ul>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue';
  
  export default {
    setup() {
      const mail = ref([]);
      const loading = ref(true);
  
      onMounted(async () => {
        try {
          const response = await fetch('http://localhost:3000/api/contact'); // Replace with your API endpoint
          if (response.ok) {
            mail.value = await response.json();
          } else {
            console.error('Failed to fetch mail.');
            alert('Failed to fetch mail.');
          }
        } catch (error) {
          console.error('Error fetching mail:', error);
          alert('An error occurred while fetching mail.');
        } finally {
          loading.value = false;
        }
      });

      const deleteMail = async (messageId) => {
      try {
        const response = await fetch(`http://localhost:3000/api/contact/${messageId}`, {
          method: 'DELETE',
        });

        if (response.ok) {
          mail.value = mail.value.filter((message) => message.contact_id !== messageId);
          alert('Mail deleted successfully!');
        } else {
          alert('Failed to delete mail.');
        }
      } catch (error) {
        console.error('Error deleting mail:', error);
        alert('An error occurred while deleting mail.');
      }
    };
  
      return {
        mail,
        loading,
        deleteMail
      };
    },
  };
  </script>
  
  <style scoped>
  ul {
    list-style-type: none;
    padding: 0;
  }
  
  li {
    margin-bottom: 20px;
    border: 1px solid #ddd;
    padding: 10px;
  }
  </style>