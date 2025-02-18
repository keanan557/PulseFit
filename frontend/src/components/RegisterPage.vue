<template>
    <div class="min-h-screen flex items-center justify-center bg-gradient-to-r from-purple-400 to-indigo-600 px-6 py-12">
      <div class="max-w-md w-full bg-white p-8 rounded-xl shadow-xl space-y-6">
        <h2 class="text-center text-3xl font-extrabold text-gray-900">Sign Up</h2>
        <p class="text-center text-sm text-gray-600">
          Already have an account?
          <router-link to="/login" class="text-blue-600 hover:underline">Log in</router-link>
        </p>
        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700">Full Name</label>
            <input v-model="formData.fullName" type="text" required class="input-field" />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700">E-mail</label>
            <input v-model="formData.email" type="email" required class="input-field" />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700">Password</label>
            <div class="relative">
              <input
                v-model="formData.password"
                :type="showPassword ? 'text' : 'password'"
                required
                class="input-field"
              />
              <button type="button" @click="togglePassword" class="password-toggle">
                <i :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
              </button>
            </div>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700">Confirm Password</label>
            <input
              v-model="formData.confirmPassword"
              :type="showPassword ? 'text' : 'password'"
              required
              class="input-field"
            />
          </div>
          <p v-if="error" class="text-red-600 text-sm text-center animate-fade-in">{{ error }}</p>
          <p v-if="success" class="text-green-600 text-sm text-center animate-fade-in">
            Registration successful! Redirecting...
          </p>
          <button type="submit" :disabled="loading" class="submit-button">
            <span v-if="loading" class="fas fa-spinner fa-spin mr-2"></span>
            <span v-else>Create Account</span>
          </button>
        </form>
      </div>
    </div>
  </template>
  
  <script>
  import { ref, reactive } from "vue";
  import { useRouter } from "vue-router";
  
  export default {
    name: "RegisterPage",
    setup() {
      const router = useRouter();
      const showPassword = ref(false);
      const error = ref("");
      const success = ref(false);
      const loading = ref(false);
      const formData = reactive({
        fullName: "",
        email: "",
        password: "",
        confirmPassword: "",
      });
  
      const togglePassword = () => {
        showPassword.value = !showPassword.value;
      };
  
      const validateForm = () => {
        if (!formData.fullName || !formData.email || !formData.password || !formData.confirmPassword) {
          error.value = "All fields are required";
          return false;
        }
        if (!formData.email.includes("@")) {
          error.value = "Invalid email address";
          return false;
        }
        if (formData.password.length < 8) {
          error.value = "Password must be at least 8 characters";
          return false;
        }
        if (formData.password !== formData.confirmPassword) {
          error.value = "Passwords do not match";
          return false;
        }
        error.value = "";
        return true;
      };
  
      const handleSubmit = async () => {
        if (!validateForm()) return;
        loading.value = true;
        try {
          const response = await fetch("http://localhost:3000/api/register", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              name: formData.fullName,
              email: formData.email,
              password: formData.password,
            }),
          });
          const data = await response.json();
          if (response.ok) {
            success.value = true;
            setTimeout(() => router.push("/login"), 2000);
          } else {
            error.value = data.error || "Registration failed";
          }
        } catch (err) {
          error.value = "An error occurred. Please try again.";
        } finally {
          loading.value = false;
        }
      };
  
      return { showPassword, error, success, loading, formData, togglePassword, handleSubmit };
    },
  };
  </script>
  
  <style scoped>
  .input-field {
    width: 90%;
    padding: 10px 16px;
    border-radius: 8px;
    border: 1px solid #ddd;
    font-size: 1rem;
    transition: all 0.2s ease;
  }
  .input-field:focus {
    outline: none;
    border-color: #4c51bf;
    box-shadow: 0 0 0 2px rgba(75, 81, 191, 0.2);
  }
  .password-toggle {
    position: absolute;
    top: 50%;
    right: 12px;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: #4c51bf;
    cursor: pointer;
  }
  .submit-button {
    width: 40%;
    padding: 9px;
    background-color: #4c51bf;
    color: white;
    font-weight: 600;
    font-size: 1.125rem;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .submit-button:disabled {
    background-color: #d1d5db;
    cursor: not-allowed;
  }
  .submit-button:hover:enabled {
    background-color: #434190;
  }
  .text-center {
    text-align: center;
  }
  .text-red-600 {
    color: #e53e3e;
  }
  .text-green-600 {
    color: #38a169;
  }
  .text-sm {
    font-size: 0.875rem;
  }
  .animate-fade-in {
    animation: fadeIn 0.5s ease-in-out;
  }
  @keyframes fadeIn {
    50% { opacity: 0; }
    100% { opacity: 1; }
  }
  .min-h-screen { min-height: 100vh; }
  .flex { display: flex; }
  .items-center { align-items: center; }
  .justify-center { justify-content: center; }
  .bg-gradient-to-r { background: linear-gradient(to right, #23182a, #ff0015); }
  .bg-white { background-color: white; }
  .px-6 { padding-left: 24px; padding-right: 24px; }
  .py-12 { padding-top: 48px; padding-bottom: 48px; }
  .max-w-md { max-width: 28rem; }
  .w-full { width: 100%; }
  .p-8 { padding: 32px; }
  .rounded-xl { border-radius: 1rem; }
  .shadow-xl { box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
  .space-y-6 > *:not(:last-child) { margin-bottom: 24px; }
  .text-3xl { font-size: 1.875rem; }
  .font-extrabold { font-weight: 800; }
  .text-gray-900 { color: #1a202c; }
  .text-gray-600 { color: #718096; }
  .text-blue-600 { color: #3182ce; }
  .hover\:underline:hover { text-decoration: underline; }
  .fas { font-family: "Font Awesome 5 Free", sans-serif; }
  .fa-eye, .fa-eye-slash { font-size: 1.25rem; }
  </style>
  