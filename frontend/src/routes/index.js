import { createRouter, createWebHistory } from 'vue-router'
import ProductsList from '@/components/ProductsList.vue'
import ProductCart from '@/components/ProductCart.vue'
import HomePage from '@/components/HomePage.vue'
import LoginPage from '@/components/LoginPage.vue'
import RegisterPage from '@/components/RegisterPage.vue'
import AdminLogin from '@/components/AdminLogin.vue'
import AdminHome from '@/components/AdminHome.vue'
import AddNewProducts from '@/components/AddNewProducts.vue'
import AdminEditProducts from '@/components/AdminEditProducts.vue'
// import Orders from '@/components/OrdersPage.vue'
import OrdersPage from '@/components/OrdersPage.vue'
import AddNewAdmin from '@/components/AddNewAdmin.vue'
import ForgotPassword from '@/components/ForgotPassword.vue'
import DeleteUserAccount from '@/components/DeleteUserAccount.vue'
import CustomerProfile from '@/components/CustomerProfile.vue'

const routes = [
  {
    path: '/',
    component: HomePage
  },
  {
    path: '/products',
    component: ProductsList
  },
  {
    path: '/cart',
    component: ProductCart
  },
  {
    path: '/login',
    component: LoginPage
  },
  {
    path: '/register',
    component: RegisterPage
  },
  {
    path: '/AdminLogin',
    component: AdminLogin,
    meta: { hideNavbar: true } 
  },
  {
    path: '/AdminHome',
    component: AdminHome
  },
  {
    path: '/AddNewProducts',
    component: AddNewProducts
  },
  {
    path: '/AdminEditProducts',
    component: AdminEditProducts
  },
  {
    path: '/OrdersPage',
    component: OrdersPage
  },
  {
    path: '/AddNewAdmin',
    component: AddNewAdmin
  },
  {
    path: '/forgotpassword',
    component: ForgotPassword
  },
  {
    path: '/deleteaccount',
    component: DeleteUserAccount
  },
  {
    path: '/MyProfile',
    component: CustomerProfile
  }
  

]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
