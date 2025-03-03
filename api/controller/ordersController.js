// orders controller page

// imports
import * as ordersModel from '../model/ordersModel.js'

export const addToOrders = async (req, res) => {
    console.log("Request Body:", req.body); 
    console.log("Request Headers:", req.headers);


    const { user_id, items, total_price, shipping_address, payment_method } = req.body;
  
    if (!user_id) return res.status(401).json({ error: "Unauthorized" });
  
    try {
      const result = await ordersModel.addToOrders(
        user_id,
        items,
        total_price,
        shipping_address,
        payment_method
      );
  
      res.json({ message: "Order placed successfully", order_id: result.insertId });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };


// authenticate token
export const authenticateToken = (req, res, next) => {
    const authHeader = req.headers["authorization"];
    console.log("Authorization Header:", authHeader);

    if (!authHeader) return res.status(401).json({ error: "Access denied, no token provided" });

    const token = authHeader.split(" ")[1]; // Extract token
    if (!token) return res.status(401).json({ error: "Malformed token" });

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            console.error("JWT Verification Failed:", err.message);
            return res.status(403).json({ error: "Invalid token" });
        }
        req.user = user;
        next();
    });
};


// get orders controller

export const getOrders = async(req,res)=>{
    try{
        const orders = await ordersModel.getOrders()
        res.json(orders)
    }catch(error){
        console.error('Error fetching orders:', error);
        res.status(500).json({ error: 'Failed to fetch orders.' });
    }
}