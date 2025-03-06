// review modal
import { pool } from '../config/config.js'; // Adjust the path as needed
// Get all reviews
export const getAllReviews = async () => {
  const [rows] = await pool.query('SELECT * FROM reviews');
  return rows;
};

// get reviews for product
export const getReviewsForProduct = async (product_id) => {
  try {
    const [rows] = await pool.query(`
SELECT review_id,product_id,rating,comment, users.name
FROM reviews
INNER JOIN users
ON reviews.user_id = users.user_id
      WHERE product_id = ?;
    `, [product_id]);
    console.log("Fetched Reviews:", rows); // Debugging
    return rows;
  } catch (error) {
    console.error('Error fetching reviews:', error);
    throw error;
  }
};

// Get review by ID
export const getReviewById = async (id) => {
  const [rows] = await pool.query('SELECT * FROM Reviews WHERE review_id = ?', [id]);
  return rows[0];
};
// Create a new review
export const createReview = async (product_id, user_id, rating, comment) => { //add review_title
  const [result] = await pool.query(
    'INSERT INTO reviews (product_id, user_id, rating, comment) VALUES (?, ?, ?, ?)', //add review_title
    [product_id, user_id, rating, comment] //add review_title
  );
  return { review_id: result.insertId, product_id, user_id, rating, comment }; //add review_title
};
// Update a review
export const updateReview = async (id, product_id, user_id, rating, comment) => { //add review_title
  const [result] = await pool.query(
    'UPDATE Reviews SET product_id = ?, user_id = ?, rating = ?, comment = ? WHERE review_id = ?', //add review_title
    [product_id, user_id, rating, comment, id] //add review_title
  );
  return result;
};
// Delete a review
export const deleteReview = async (id) => {
  const [result] = await pool.query('DELETE FROM Reviews WHERE review_id = ?', [id]);
  return result;
};