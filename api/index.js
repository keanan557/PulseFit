import cors from 'cors'
import express from 'express'
import apiRoutes from './routes/apiRoutes.js'
import { config } from 'dotenv'
config()

const PORT = process.env.PORT || 3000
const app = express()

app.use(cors())
app.use(express.json())
app.use('/', apiRoutes)

app.listen(PORT, ()=>{
  console.log('http://localhost:3000');
})





