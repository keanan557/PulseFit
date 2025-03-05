<template>
    <h1>Contact Page</h1>

    <label>Name: </label>
    <input type="text" v-model="name">

    <br>

    <label>Email: </label>
    <input type="email" v-model="email">

    <br>

    <label>Message</label>
    <textarea type="text" v-model="message"></textarea>

    <br>

    <button @click="sendContact">Send</button>
</template>

<script>
import {ref} from 'vue'

export default {
    setup(){
        const name = ref('')
        const email = ref('')
        const message = ref('')

        const sendContact = async () => {
      try {
        const response = await fetch('http://localhost:3000/api/contact', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ name: name.value, email: email.value, message: message.value }),
        });

        if (response.ok) {
          alert('Message sent successfully!');
          name.value = '';
          email.value = '';
          message.value = '';
        } else {
          alert('Failed to send message.');
        }
      } catch (error) {
        console.error('Error sending message:', error);
        alert('An error occurred while sending the message.');
      }
    };

    return {
      name,
      email,
      message,
      sendContact
    };
    
}
}

</script>

<style>
textarea{
    width: 300px;
    min-height: 100px;
    resize: vertical;
}

</style>