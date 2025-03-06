import {createStore} from 'vuex'

export default createStore({
    state:{
        products:[],
        cart: JSON.parse(localStorage.getItem('cart')) || [],
        user:null
        // user:localStorage.getItem("userName") && localStorage.getItem("userEmail")
        // ?{name:localStorage.getItem("userName"),email: localStorage.getItem("userEmail")}
        // : null
    },
    mutations:{
        setUser(state, user){
            if(user){
              state.user = {
                name: user.name,
                email: user.email
              }
            }else{
                state.user = null
            }
        },
        
        set_products(state, products){
            state.products = products
        },
        add_to_cart(state, product) {
            // Use product.product_id if it exists, otherwise fallback to product.id
            const uniqueId = product.product_id || product.id;
            // Check if a product with this id is already in the cart
            const existingProduct = state.cart.find(item => item.product_id === uniqueId);
            if (existingProduct) {
              existingProduct.quantity += 1;
            } else {
              // Make sure to set product_id on the cart item
              state.cart.push({ ...product, product_id: uniqueId, quantity: 1 });
            }

            localStorage.setItem('cart',JSON.stringify(state.cart))
          }
          ,
          update_cart_quantity(state, { id, change }) {
            const product = state.cart.find(item => item.product_id === id);
            if (product) {
              product.quantity += change;
            }
            localStorage.setItem('cart',JSON.stringify(state.cart))
          },
          remove_from_cart(state, id) {
            state.cart = state.cart.filter(item => item.product_id !== id);
            localStorage.setItem('cart',JSON.stringify(state.cart))
          },
          clearCart(state){
            state.cart = []
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
        login({commit}, {token, user}){
            localStorage.setItem("authToken", token);
            localStorage.setItem("userId", user.id)
            localStorage.setItem("userName", user.name);
            localStorage.setItem("userEmail", user.email)
            commit('setUser', user)
        },
        logout({commit}){
            localStorage.removeItem("authToken")
            localStorage.removeItem("userId")
            localStorage.removeItem("userName")
            localStorage.removeItem("userEmail")
            commit('setUser', null)
        }
    },
    getters: {
        allProducts: (state) => state.products,
        cartItems: (state) => state.cart,
        user(state){
            return state.user
        },
        cartItemCount(state){
            return state.cart.reduce((total, item)=> total + item.quantity, 0)
        }
      }
})