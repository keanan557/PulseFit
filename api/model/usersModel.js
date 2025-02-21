// usersModel.js 
import { pool } from "../config/config.js"

export const getUserByEmail = async(email) => {
    const [rows] = await pool.query('select * from users where email = ?',[email])
    return rows
}

export const updateUserPassword = async(hashedPassword, email)=>{
    // update the user password
    await pool.query('update users set password_hash = ? where email=?',[hashedPassword, email])
}
