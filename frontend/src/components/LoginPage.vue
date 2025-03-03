<template>
  <div class="page-container">
    <div class="wrapper">
      <form @submit.prevent="handleLogin" class="space-y-4">
        <h1 class="text-center text-3xl font-extrabold text-gray-900">Login</h1>
        <div class="input-box">
          <input
            v-model="email"
            type="email"
            placeholder="Email"
            required
            class="input-field"
          />
        </div>
        <div class="input-box relative">
          <input
            v-model="password"
            :type="showPassword ? 'text' : 'password'"
            placeholder="Password"
            required
            class="input-field"
          />
          <button type="button" @click="togglePassword" class="password-toggle">
            <i :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
          </button>
        </div>
        <div class="remember-forgot">
          <label>
            <input v-model="rememberMe" type="checkbox" /> Remember me
          </label>
          <router-link to="/forgotpassword" class="forgot-link">Forgot Password?</router-link>
        </div>
        <p
          v-if="message"
          class="text-center text-sm"
          :class="{ 'text-red-600': error, 'text-green-600': success }"
        >
          {{ message }}
        </p>
        <button type="submit" class="btn" :disabled="loading">
          <span v-if="loading" class="fas fa-spinner fa-spin mr-2"></span>
          <span v-else>Login</span>
        </button>
      </form>
      <div class="register-link text-center">
        <p>
          Don't have an account?
          <router-link to="/register" class="text-blue-600 hover:underline">
            Register
          </router-link>
        </p>
        <router-link to="/deleteaccount">Delete my account</router-link>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";

export default {
  name: "LoginPage",
  setup() {
    const email = ref("");
    const password = ref("");
    const rememberMe = ref(false);
    const showPassword = ref(false);
    const message = ref("");
    const error = ref(false);
    const success = ref(false);
    const loading = ref(false);

    const router = useRouter();
    const store = useStore();

    const togglePassword = () => {
      showPassword.value = !showPassword.value;
    };

    const handleLogin = async () => {
      message.value = "";
      error.value = false;
      loading.value = true;

      try {
        const response = await fetch("http://localhost:3000/api/user/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            email: email.value,
            password: password.value,
          }),
        });
        const data = await response.json();
        if (response.ok) {
          localStorage.setItem("authToken", data.token);
          localStorage.setItem("userName", data.name); // if backend sends name
          console.log("User ID from login response:", data.user_id)
          localStorage.setItem("userId", data.user_id)
          store.commit("setUser", data.name); // Update Vuex state if you have this mutation
          message.value = "Login successful!";
          success.value = true;
          setTimeout(() => router.push("/"), 1500);
        } else {
          message.value = data.error || "Login failed.";
          error.value = true;
        }
      } catch (err) {
        console.error("Login error:", err);
        message.value = "An error occurred. Please try again.";
        error.value = true;
      } finally {
        loading.value = false;
      }
    };

    return {
      email,
      password,
      rememberMe,
      showPassword,
      message,
      error,
      success,
      loading,
      togglePassword,
      handleLogin,
    };
  },
};
</script>

<style scoped>
.page-container {
  width: 100%;
  height: 100vh;
  background: url('https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')
    no-repeat center center/cover;
  display: flex;
  justify-content: center;
  align-items: center;
}
.wrapper {
  width: 100%;
  max-width: 400px;
  padding: 30px;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 10px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  color: white;
}
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
.input-box.relative {
  position: relative;
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
.btn {
  width: 40%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
}
.btn:disabled {
  background-color: #d1d5db;
  cursor: not-allowed;
}
.remember-forgot {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  margin-top: 10px;
}
.forgot-link {
  color: white;
  text-decoration: underline;
}
.register-link {
  margin-top: 15px;
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
</style>
