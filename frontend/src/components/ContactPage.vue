<template>
  <!-- contact form -->
  <div class="contact-container">
    <h1>Contact Us</h1>

    <div class="input-container">
      <label class="label" for="name">Name: </label>
      <input type="text" id="name" v-model="name" placeholder="Your name" aria-label="Enter your name" />
      <div v-if="errors.name" class="error">{{ errors.name }}</div>
    </div>

    <div class="input-container">
      <label class="label" for="email">Email: </label>
      <input type="email" id="email" v-model="email" placeholder="Your email" aria-label="Enter your email" />
      <div v-if="errors.email" class="error">{{ errors.email }}</div>
    </div>

    <div class="input-container">
      <label class="label" for="message">Message: </label>
      <textarea id="message" v-model="message" placeholder="Your message" aria-label="Enter your message"></textarea>
      <div v-if="errors.message" class="error">{{ errors.message }}</div>
    </div>

    <!-- sendContact function -->
    <button @click="sendContact" class="send-button">Send</button>
  </div>
</template>

<script>
import { ref } from 'vue';

export default {
  setup() {
    // variables
    const name = ref('');
    const email = ref('');
    const message = ref('');
    const errors = ref({});

    // sends contact details
    const sendContact = async () => {
      errors.value = {};

      if (!name.value) {
        errors.value.name = 'Name is required.';
      }
      if (!email.value) {
        errors.value.email = 'Email is required.';
      } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
        errors.value.email = 'Invalid email format.';
      }
      if (!message.value) {
        errors.value.message = 'Message is required.';
      }

      if (Object.keys(errors.value).length > 0) {
        return;
      }

      // api 
      try {
        const response = await fetch('http://localhost:3000/api/contact', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ name: name.value, email: email.value, message: message.value }),
        });
        // response 
        if (response.ok) {
          alert('Message sent successfully!');
          name.value = '';
          email.value = '';
          message.value = '';
        } else {
          alert('Failed to send message. Please try again.');
        }
      } catch (error) {
        // catch error
        console.error('Error sending message:', error);
        alert('An error occurred while sending the message. Please check your network connection.');
      }
    };

    // return variables and send contact

    return {
      name,
      email,
      message,
      sendContact,
      errors,
    };
  },
};
</script>

<style scoped>
/* styles */
.contact-container {
  width: 80%;
  max-width: 600px;
  margin: 0 auto;
  padding: 30px;
  margin-top: 40px;
  background-color: rgba(249, 249, 249, 0.8);
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  background-image: url('@/assets/bg.avif');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

h1 {
  text-align: center;
  font-size: 2rem;
  color: #fff;
  margin-bottom: 20px;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
}

.input-container {
  margin-bottom: 20px;
}

label {
  font-size: 1rem;
  color: #E74C3C;
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

input[type="text"],
input[type="email"],
textarea {
  width: 100%;
  padding: 12px;
  font-size: 1rem;
  border-radius: 5px;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

input[type="text"]:focus,
input[type="email"]:focus,
textarea:focus {
  border-color: #3498DB;
  outline: none;
  box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
}

textarea {
  min-height: 150px;
  resize: vertical;
}

.send-button {
  display: block;
  width: 100%;
  padding: 15px;
  font-size: 1.2rem;
  color: white;
  background-color: #E74C3C;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.send-button:hover {
  background-color: #C0392B;
}

.error {
  color: red;
  font-size: 12px;
}
</style>