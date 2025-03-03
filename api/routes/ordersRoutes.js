// orders routes

import { addToOrders,getOrders } from '../controller/ordersController.js';

import express from 'express'

const router = express.Router()

router.get('/api/test', (req, res) => {
    res.send('Test route works!');
});

router.post('/api/orders', addToOrders);
router.get('/api/orders', getOrders)

export default router