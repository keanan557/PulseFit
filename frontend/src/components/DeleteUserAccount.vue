<template>
    <div class="container">

      <h1>Delete My Account</h1>
      <label>Enter your email:</label>

      <!-- input -->
      <input type="email" v-model="email" placeholder="Your email" class="input-field">
      <p v-if="message" class="message">{{ message }}</p>
      <button @click="confirmDelete" class="delete-btn">Delete my account</button>
      <div v-if="showModal" class="modal-overlay">

        <!-- delete modal -->
        <div class="modal-content">
          <p>Are you sure you want to delete your account?</p>
          <button @click="deleteAccount" class="confirm-btn">Yes</button>
          <button @click="showModal = false" class="cancel-btn">No</button>
        </div>

      </div>
    </div>
  </template>


  <script>
  import { ref } from "vue";
  export default {
    setup() {
      const email = ref("");
      const showModal = ref(false);
      const message = ref("");

      // methods and fetch api
      const confirmDelete = () => {
        message.value = "";
        if (!email.value) {
          message.value = "Please enter your email.";
          return;
        }
        showModal.value = true;
      };
      const deleteAccount = async () => {
        try {
          const response = await fetch("http://localhost:3000/api/delete-account", {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email: email.value })
          });
          const data = await response.json();
          if (!response.ok) throw new Error(data.error || "Failed to delete account");
          message.value = "Your account has been deleted.";
        } catch (error) {
          message.value = error.message;
        } finally {
          showModal.value = false;
        }
      };
      return { email, showModal, message, confirmDelete, deleteAccount };
    }
  };
  </script>

  <style>
  /* styles */
  body {
    background: linear-gradient(to right, red, black);
  }
  .container {
    max-width: 400px;
    margin: 50px auto;
    text-align: center;
    font-family: Arial, sans-serif;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    background: rgba(0, 0, 0, 0.8);
  }
  h1 {
    font-size: 22px;
    margin-bottom: 15px;
  }
  .input-field {
    width: 80%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
    color: black;
  }
  .delete-btn {
    background-color: #B4201B;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 15px;
  }
  .delete-btn:hover {
    background-color: #C9302C;
  }
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .modal-content {
    background: white;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    color: black;
  }
  .confirm-btn {
    background-color: rgb(0, 0, 0);
    color: white;
    padding: 8px 12px;
    border: none;
    border-radius: 5px;
    margin-right: 10px;
    cursor: pointer;
  }
  .confirm-btn:hover {
    background-color: #000000;
  }
  .cancel-btn {
    background-color: #FF0000;
    color: white;
    padding: 8px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
  .cancel-btn:hover {
    background-color: #FF0000;
  }
  .message {
    margin-top: 15px;
    color: #D9534F;
    font-weight: bold;
  }
  /* Responsive Styles */
  @media (max-width: 600px) {
    .container {
      width: 90%;
      padding: 15px;
    }
    h1 {
      font-size: 18px;
    }
    .input-field {
      width: 100%;
      padding: 12px;
    }
    .delete-btn {
      width: 100%;
      padding: 12px;
    }
    .modal-content {
      width: 80%;
      padding: 15px;
    }
    .confirm-btn, .cancel-btn {
      width: 45%;
      margin: 5px 0;
    }
    .confirm-btn {
      margin-right: 10px;
    }
  }
  @media (max-width: 400px) {
    h1 {
      font-size: 16px;
    }
    .input-field {
      padding: 10px;
    }
    .delete-btn {
      padding: 10px;
    }
  }
  </style>