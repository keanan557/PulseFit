import express from 'express'
// import { resetPassword } from '../controller/apiController.js'
import productRoutes from './productRoutes.js'
import adminRoutes from './adminRoutes.js'
import usersRoutes from './usersRoutes.js'
import ordersRoutes from './ordersRoutes.js'

const router = express.Router()

router.use(productRoutes)
router.use(adminRoutes)
router.use(usersRoutes)
router.use(ordersRoutes)

export default router
