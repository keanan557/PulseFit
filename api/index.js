import cors from 'cors'
import express from 'express'
import mysql from 'mysql2/promise'
import jwt from 'jsonwebtoken'
import bcrypt from 'bcryptjs'
import multer from 'multer'
// import fs from 'fs'
import path from 'path'
import { config } from 'dotenv'
config()
const PORT = process.env.PORT || 3000

const app = express()
app.use(cors())
app.use(express.json())

app.use('/uploads', express.static('uploads'));


const pool = mysql.createPool({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE 
})

// Admin login API
app.post('/api/admin/login', async (req, res) => {
    const { username, password } = req.body;
  // console.log('papi');
  
    try {
      // Check if the admin exists
      const [rows] = await pool.query('SELECT * FROM admin_users WHERE username = ?', [username]);
  
      if (rows.length === 0) {
        return res.status(400).json({ error: 'Invalid username or password' });
      }
  
      // Compare the password with the stored hashed password
      const admin = rows[0];
      console.log(admin, password);
    //   let hash = await bcrypt.hash(password,10)
      const isMatch = await bcrypt.compare(password, admin.password);
  console.log(isMatch);
  
      if (!isMatch) {
        return res.status(400).json({ error: 'Invalid username or password' });
      }
  
      // Generate a JWT token with username only
      const token = jwt.sign(
        { id: admin.id, username: admin.username },
        process.env.JWT_SECRET,  // Store JWT secret in .env
        { expiresIn: '1h' }
      );
      let value = jwt.verify(token, process.env.JWT_SECRET)
  
      // Return the token to the client
      res.json({ token });
  
    } catch (error) {
      console.error('Error during login:', error);
      res.status(500).json({ error: 'Server error' });
    }
});

import fs from 'fs';

// Ensure uploads folder exists
const uploadDir = path.join(process.cwd(), 'uploads');
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}

  // Configure storage for uploaded files
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Make sure this folder exists in your project root
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

// Create the multer instance with the storage configuration
const upload = multer({ storage });


  // Updated POST route for adding a product using multer for image upload
app.post('/api/products', upload.single('image'), async (req, res) => {
  try {
    // Extract text fields from req.body
    const { name, description, price, quantity } = req.body;
const image = req.file ? req.file.filename : null;

// Default quantity to 0 if missing
const productQuantity = quantity ? parseInt(quantity) : 0;

if (!name || !description || !price || !image) {
  return res.status(400).json({ error: "Missing required fields." });
}

const [result] = await pool.query(
  'INSERT INTO products (name, description, price, image, quantity) VALUES (?, ?, ?, ?, ?)',
  [name, description, price, image, productQuantity]
);


    res.status(201).json({
      message: 'Product inserted successfully',
      productId: result.insertId
    });
  } catch (error) {
    console.error('Error inserting product:', error);
    res.status(500).json({ error: 'Failed to insert product.' });
  }
});


// Get all products
app.get('/api/products', async (req, res) => {
  try {
      const [rows] = await pool.query('SELECT * FROM products');
      res.json(rows);
  } catch (error) {
      console.error('Error fetching products:', error);
      res.status(500).json({ error: 'Failed to fetch products.' });
  }
});


  

app.listen(PORT, ()=>{
    console.log('http://localhost:3000');
})
