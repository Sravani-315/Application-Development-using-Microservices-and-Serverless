# Dealer Evaluation Frontend

## Description
This is the frontend microservice for the Dealer Evaluation System. It provides a user interface to browse products, view dealers, and compare prices.

## Features
- 📦 Product selection dropdown (preloaded from Product Service)
- 🏬 Dealer listing for selected products
- 💰 Individual dealer price display
- 🌟 All dealers price comparison with summary statistics
- 📊 Visual indication of best prices
- 📱 Responsive design for mobile and desktop

## Configuration

Before deploying, you **MUST** update the API endpoints in `index.html`:

```javascript
const API_CONFIG = {
    PRODUCT_SERVICE: 'YOUR_PRODUCT_SERVICE_URL',
    DEALER_SERVICE: 'YOUR_DEALER_PRICING_SERVICE_URL'
};
```

Replace with your actual deployed URLs, for example:
```javascript
const API_CONFIG = {
    PRODUCT_SERVICE: 'https://product-service.xxxxx.us-south.codeengine.appdomain.cloud',
    DEALER_SERVICE: 'https://dealer-pricing-service.xxxxx.us-south.codeengine.appdomain.cloud'
};
```

## Local Development

### Using a simple HTTP server (Python)
```bash
python -m http.server 8080
```

### Using Node.js http-server
```bash
npx http-server -p 8080
```

### Using Live Server (VS Code extension)
- Install Live Server extension
- Right-click on index.html
- Select "Open with Live Server"

Visit http://localhost:8080 in your browser.

## Docker Build and Run

```bash
docker build -t dealer-frontend .
docker run -p 8080:8080 dealer-frontend
```

## Deploy to IBM Code Engine

### Prerequisites
1. Deploy the Product Service first
2. Deploy the Dealer Pricing Service second
3. Get the URLs from both deployments

### Update the Frontend Code
1. Edit `index.html`
2. Find the `API_CONFIG` object
3. Replace placeholder URLs with your deployed service URLs
4. Save the file

### Deploy

```bash
# Login to IBM Cloud
ibmcloud login

# Target your region
ibmcloud target -r us-south

# Select your project
ibmcloud ce project select --name microservices-project

# Deploy the application
ibmcloud ce application create \
  --name dealer-frontend \
  --build-source . \
  --port 8080 \
  --min-scale 1 \
  --max-scale 2

# Get the URL
ibmcloud ce application get --name dealer-frontend
```

## Testing the Application

1. **Open the frontend URL** - You should see the homepage
2. **Verify products load** - The dropdown should show products
3. **Select a product** - Product details should display
4. **View dealers** - Dealers supplying the product should be listed
5. **Select a dealer** - Individual dealer price should display
6. **Select "All Dealers"** - Compare all prices with summary

## Screenshots Needed for Grading

1. ✅ Product Service deployment on Code Engine
2. ✅ Dealer Pricing Service deployment on Code Engine
3. ✅ Git clone of this frontend repository
4. ✅ Code change in index.html showing updated API endpoints
5. ✅ Frontend deployment on Code Engine
6. ✅ Homepage with products preloaded in dropdown
7. ✅ Dealers list when product is selected
8. ✅ Individual dealer price when dealer is selected
9. ✅ All dealers prices when "All Dealers" is selected

## Troubleshooting

### Products not loading
- Check if Product Service URL is correct
- Verify Product Service is running: `curl YOUR_PRODUCT_SERVICE_URL/health`
- Check browser console for CORS errors
- Ensure Product Service has CORS enabled

### Dealers not loading
- Check if Dealer Service URL is correct
- Verify Dealer Service is running: `curl YOUR_DEALER_SERVICE_URL/health`
- Check browser console for errors
- Ensure Dealer Service has CORS enabled

### CORS Issues
Both backend services include CORS support. If you still have issues:
- Verify services are deployed correctly
- Check that URLs don't have trailing slashes
- Clear browser cache

## Environment Variables
- `PORT`: Port number (default: 8080)

## Technologies Used
- HTML5
- CSS3 (with CSS Grid and Flexbox)
- Vanilla JavaScript (ES6+)
- Nginx (for serving static files)
