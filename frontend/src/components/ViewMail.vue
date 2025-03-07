<template>
  <div class="header">
    <h1>MAIL</h1>
    <div class="user-info">
    </div>
  </div>
  <!-- mails -->
  <div class="container">
    <div v-if="loading" class="loading">Loading...</div>
    <div v-else-if="mail.length === 0" class="no-mail">No mail found.</div>
    <div v-else>
      <ul>
        <li v-for="message in mail" :key="message.id" class="mail-item">
          <strong>Name:</strong> {{ message.name }}<br>
          <strong>Email:</strong> {{ message.email }}<br><br>
          <p><strong>Message:<br></strong> {{ message.message }}</p>
          <hr>
          <button @click="deleteMail(message.contact_id)" class="delete-btn">Delete mail</button>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
// imports
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
/* css */
body {
  background-color: #121212;
  color: white;
  font-family: Arial, sans-serif;
}
h1 {
  color: white;
  text-align: center;
}
.loading, .no-mail {
  text-align: center;
  font-size: 18px;
  color: white;
}
/* Increased width for the outer container */
.container {
  width: 90%; /* Adjusted width of the container */
  max-width: 1200px; /* Limit the max width */
  margin: 0 auto;
}
/* Flexbox-based responsive layout for mail container */
ul {
  list-style-type: none;
  padding: 0;
  margin: 0 auto;
  display: flex;
  flex-wrap: wrap; /* Allows the items to wrap into the next row */
  gap: 20px; /* Adds space between items */
  justify-content: center; /* Centers items horizontally */
}
/* Styling for each mail item */
.mail-item {
  border: 1px solid #444;
  padding: 20px;
  border-radius: 8px;
  background-color: #0B0606;
  color: white;
  transition: transform 0.2s ease-in-out;
  text-align: center;
  width: calc(33.333% - 20px); /* Each item takes up 1/3 of the container */
  max-width: 300px; /* Limit the width */
}
/* Hover effect for mail items */
.mail-item:hover {
  transform: scale(1.02);
}
/* Styling for the delete button */
.delete-btn {
  background-color: red;
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
  border-radius: 5px;
  font-size: 16px;
}
.delete-btn:hover {
  background-color: darkred;
}
</style>