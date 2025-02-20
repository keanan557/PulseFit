import {createStore} from 'vuex'

export default createStore({
    state:{
        products:[],
        cart: [],
        user:null
    },
    mutations:{
        setUser(state, userName){
            state.user = userName ? { name: userName } : null;
        },
        set_products(state, products){
            state.products = products
        },
        add_to_cart(state, product){
            const existingProduct = state.cart.find(item => item.id === product.id)
            if(existingProduct){
                existingProduct.quantity += 1
            }else{
                state.cart.push({...product, quantity: 1})
            }
        },
        update_cart_quantity(state, { id, change }) {
            const product = state.cart.find(item => item.id === id);
            if (product) {
              product.quantity += change;
            }
          },
          remove_from_cart(state, id) {
            state.cart = state.cart.filter(item => item.id !== id);
          }
    },
    actions:{
        async fetchProducts({commit}){
            try {
                const response = await fetch('http://localhost:3000/api/products');
                const data = await response.json();
                commit('set_products', data);
              } catch (error) {
                console.error('Error fetching products:', error);
              }
        },
        addToCart({commit}, product){
            commit('add_to_cart', product)
        },
        updateCartQuantity({ commit }, { id, change }) {
            commit('update_cart_quantity', { id, change });
        },
        removeFromCart({ commit }, id) {
            commit('remove_from_cart', id);
        },
        login({commit}, userName){
            localStorage.setItem("authToken", userName);
            localStorage.setItem("userName", userName);
            commit('setUser', userName)
        },
        logout({commit}){
            commit('setUser', null)
        }
    },
    getters: {
        allProducts: (state) => state.products,
        cartItems: (state) => state.cart,
        user(state){
            return state.user
        }
      }
})