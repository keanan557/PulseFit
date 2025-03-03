// orders Model

// import pool
import { pool } from "../config/config.js";

// export const addToOrders = async (user_id, items, total_price, shipping_address, payment_method) => {
//     const [result] = await pool.execute(
//         "INSERT INTO orders (user_id, total_price, shipping_address, payment_method) VALUES (?, ?, ?, ?)",
//         [user_id, total_price, JSON.stringify(shipping_address), payment_method]
//     );

//     const orderId = result.insertId;

//     // Insert each product in a separate order_items table (if you have it)
//     for (const item of items) {
//         await pool.execute(
//             "INSERT INTO items (order_id, product_id, quantity) VALUES (?, ?, ?)",
//             [orderId, item.product_id, item.quantity]
//         );
//     }

//     return result;
// };

// ordersModel.js
export const addToOrders = async (user_id, items, total_price, shipping_address, payment_method) => {
    try {
        const [result] = await pool.execute(
            "INSERT INTO orders (user_id, items, total_price, shipping_address, payment_method) VALUES (?, ?, ?, ?, ?)",
            [user_id, JSON.stringify(items), total_price, JSON.stringify(shipping_address), payment_method]
        );

        return result;
    } catch (error) {
        console.error("Error in addToOrders:", error);
        throw error;
    }
};


// ordersModel.js - getOrders function
export const getOrders = async () => {
    try {
        let [orders] = await pool.query(`
            SELECT 
                orders.order_id,
                orders.user_id,
                users.name AS user_name,
                users.email AS user_email,
                orders.items,
                orders.total_price,
                orders.shipping_address,
                orders.payment_method,
                orders.order_date
            FROM orders
            JOIN users ON orders.user_id = users.user_id
            ORDER BY orders.order_date DESC;
        `);

        return orders.map(order => {
            try {
                const items = order.items ? JSON.parse(order.items) : [];
                const shipping_address = JSON.parse(order.shipping_address);
                return {
                    ...order,
                    items,
                    shipping_address
                };
            } catch (parseError) {
                console.error("JSON parsing error:", parseError);
                console.log("Order data:", order); // Log the order data
                return { ...order, items: [], shipping_address: {} }; // Return defaults on error
            }

        });
    } catch (dbError) {
        console.error("Database error:", dbError);
        throw dbError; // Re-throw the error
    }
};