// product routes page
import express from 'express'
import { deleteProductsById,addProducts,updateProduct,fetchProducts } from "../controller/productsController.js";

const router = express.Router()

router.patch('/api/products/:id', updateProduct);
router.post('/api/products', addProducts);
router.get('/api/products', fetchProducts);
router.delete('/api/products/:id', deleteProductsById);

export default router;