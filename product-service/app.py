from flask import Flask, jsonify
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Sample product data
PRODUCTS = [
    {
        "id": 1,
        "name": "Laptop Dell XPS 15",
        "category": "Electronics",
        "description": "High-performance laptop with 16GB RAM and 512GB SSD"
    },
    {
        "id": 2,
        "name": "iPhone 14 Pro",
        "category": "Mobile",
        "description": "Latest iPhone with advanced camera system"
    },
    {
        "id": 3,
        "name": "Samsung Galaxy S23",
        "category": "Mobile",
        "description": "Flagship Android phone with excellent display"
    },
    {
        "id": 4,
        "name": "MacBook Pro M2",
        "category": "Electronics",
        "description": "Apple's latest professional laptop with M2 chip"
    },
    {
        "id": 5,
        "name": "Sony WH-1000XM5",
        "category": "Audio",
        "description": "Premium noise-cancelling headphones"
    }
]

@app.route('/')
def home():
    return jsonify({
        "service": "Product Details Microservice",
        "status": "running",
        "version": "1.0.0"
    })

@app.route('/products', methods=['GET'])
def get_products():
    """Get all products"""
    return jsonify({
        "success": True,
        "products": PRODUCTS
    })

@app.route('/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    """Get a specific product by ID"""
    product = next((p for p in PRODUCTS if p["id"] == product_id), None)
    
    if product:
        return jsonify({
            "success": True,
            "product": product
        })
    else:
        return jsonify({
            "success": False,
            "message": "Product not found"
        }), 404

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        "status": "healthy",
        "service": "product-service"
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=False)
