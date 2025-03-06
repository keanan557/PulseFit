// review modal
import { pool } from '../config/config.js'; // Adjust the path as needed
// Get all reviews
export const getAllReviews = async () => {
  const [rows] = await pool.query('SELECT * FROM reviews');
  return rows;
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