// orders routes

import { addToOrders,getOrders,deleteOrders,getUserOrders,authenticateToken } from '../controller/ordersController.js';

import express from 'express'

const router = express.Router()

// router.get('/api/test', (req, res) => {
//     res.send('Test route works!');
// });

router.post('/api/orders', addToOrders);
router.get('/api/orders', getOrders)
router.delete('/api/orders/:id', deleteOrders)
router.get("/api/orders/user", authenticateToken,getUserOrders);

export default router