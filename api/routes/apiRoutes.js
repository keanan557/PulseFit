import express from 'express'
import { resetPassword } from '../controller/apiController.js'

const router = express.Router()

router.post('/reset-password', resetPassword )

export default router
