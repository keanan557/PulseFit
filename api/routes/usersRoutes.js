// users routes page

// imports
import express from 'express'
import { loginUser,addUser,deleteUser } from '../controller/usersController.js'
import { resetPassword } from '../controller/apiController.js';

const router = express.Router()

router.post('/api/register', addUser);
router.post('/api/user/login', loginUser);
router.post('/api/reset-password', resetPassword )
router.delete('/api/delete-account', deleteUser)

export default router