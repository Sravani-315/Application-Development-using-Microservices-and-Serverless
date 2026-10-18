const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Enable CORS for all routes
app.use(cors());
app.use(express.json());

// Sample dealer pricing data
const DEALER_PRICING = {
  1: [ // Laptop Dell XPS 15
    { dealerId: 101, dealerName: "TechWorld", price: 1299.99, location: "New York, NY" },
    { dealerId: 102, dealerName: "ElectroMart", price: 1249.99, location: "Los Angeles, CA" },
    { dealerId: 103, dealerName: "ComputerHub", price: 1279.99, location: "Chicago, IL" },
    { dealerId: 104, dealerName: "GadgetStore", price: 1289.99, location: "Houston, TX" }
  ],
  2: [ // iPhone 14 Pro
    { dealerId: 201, dealerName: "MobileWorld", price: 999.99, location: "New York, NY" },
    { dealerId: 202, dealerName: "PhoneHub", price: 1049.99, location: "San Francisco, CA" },
    { dealerId: 203, dealerName: "TechDepot", price: 989.99, location: "Seattle, WA" },
    { dealerId: 204, dealerName: "GadgetGalaxy", price: 1019.99, location: "Miami, FL" }
  ],
  3: [ // Samsung Galaxy S23
    { dealerId: 201, dealerName: "MobileWorld", price: 799.99, location: "New York, NY" },
    { dealerId: 202, dealerName: "PhoneHub", price: 829.99, location: "San Francisco, CA" },
    { dealerId: 205, dealerName: "AndroidCenter", price: 779.99, location: "Austin, TX" },
    { dealerId: 206, dealerName: "SmartphonePlus", price: 809.99, location: "Denver, CO" }
  ],
  4: [ // MacBook Pro M2
    { dealerId: 101, dealerName: "TechWorld", price: 1999.99, location: "New York, NY" },
    { dealerId: 103, dealerName: "ComputerHub", price: 1949.99, location: "Chicago, IL" },
    { dealerId: 207, dealerName: "AppleStore", price: 1999.00, location: "Cupertino, CA" },
    { dealerId: 208, dealerName: "PremiumTech", price: 2049.99, location: "Boston, MA" }
  ],
  5: [ // Sony WH-1000XM5
    { dealerId: 301, dealerName: "AudioPro", price: 399.99, location: "Nashville, TN" },
    { dealerId: 302, dealerName: "SoundWorld", price: 379.99, location: "Portland, OR" },
    { dealerId: 303, dealerName: "HeadphoneHub", price: 389.99, location: "Atlanta, GA" },
    { dealerId: 304, dealerName: "MusicGear", price: 399.00, location: "Las Vegas, NV" }
  ]
};

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    service: 'Dealer Pricing Microservice',
    status: 'running',
    version: '1.0.0'
  });
});

// Get all dealers for a specific product
app.get('/dealers/:productId', (req, res) => {
  const productId = parseInt(req.params.productId);
  const dealers = DEALER_PRICING[productId];

  if (dealers) {
    res.json({
      success: true,
      productId: productId,
      dealers: dealers
    });
  } else {
    res.status(404).json({
      success: false,
      message: 'No dealers found for this product'
    });
  }
});

// Get pricing from a specific dealer for a product
app.get('/dealers/:productId/:dealerId', (req, res) => {
  const productId = parseInt(req.params.productId);
  const dealerId = parseInt(req.params.dealerId);
  
  const dealers = DEALER_PRICING[productId];
  
  if (!dealers) {
    return res.status(404).json({
      success: false,
      message: 'Product not found'
    });
  }

  const dealer = dealers.find(d => d.dealerId === dealerId);
  
  if (dealer) {
    res.json({
      success: true,
      productId: productId,
      dealer: dealer
    });
  } else {
    res.status(404).json({
      success: false,
      message: 'Dealer not found for this product'
    });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    service: 'dealer-pricing-service'
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Dealer Pricing Service running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM signal received: closing HTTP server');
  server.close(() => {
    console.log('HTTP server closed');
  });
});
