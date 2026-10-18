# Project Structure

This document describes the complete structure of the Microservices Final Project.

## Directory Tree

```
Application Development using Microservices and Serverless/
│
├── README.md                          # Main project documentation
├── DEPLOYMENT_GUIDE.md                # Step-by-step deployment instructions
├── PROJECT_STRUCTURE.md               # This file
├── .gitignore                         # Git ignore file
├── deploy.ps1                         # Automated deployment script (PowerShell)
├── test-local.ps1                     # Local testing script (PowerShell)
│
├── product-service/                   # Product Details Microservice (Python)
│   ├── app.py                         # Flask application
│   ├── requirements.txt               # Python dependencies
│   ├── Dockerfile                     # Docker configuration
│   └── README.md                      # Service-specific documentation
│
├── dealer-pricing-service/            # Dealer Pricing Microservice (Node.js)
│   ├── server.js                      # Express application
│   ├── package.json                   # Node.js dependencies
│   ├── Dockerfile                     # Docker configuration
│   └── README.md                      # Service-specific documentation
│
└── dealer-evaluation-frontend/        # Frontend Microservice
    ├── index.html                     # Main HTML file
    ├── styles.css                     # Styling
    ├── Dockerfile                     # Docker configuration
    └── README.md                      # Service-specific documentation
```

## Component Details

### 1. Product Service (Python/Flask)

**Location:** `product-service/`

**Purpose:** Provides product catalog information

**Key Files:**
- `app.py` - Flask application with REST API endpoints
- `requirements.txt` - Python dependencies (Flask, flask-cors)
- `Dockerfile` - Container configuration for deployment

**Endpoints:**
- `GET /` - Service info
- `GET /products` - List all products
- `GET /products/:id` - Get specific product
- `GET /health` - Health check

**Port:** 5000

### 2. Dealer Pricing Service (Node.js/Express)

**Location:** `dealer-pricing-service/`

**Purpose:** Provides dealer pricing information for products

**Key Files:**
- `server.js` - Express application with REST API endpoints
- `package.json` - Node.js dependencies (Express, CORS)
- `Dockerfile` - Container configuration for deployment

**Endpoints:**
- `GET /` - Service info
- `GET /dealers/:productId` - Get all dealers for a product
- `GET /dealers/:productId/:dealerId` - Get specific dealer pricing
- `GET /health` - Health check

**Port:** 3000

### 3. Frontend Service (HTML/CSS/JavaScript)

**Location:** `dealer-evaluation-frontend/`

**Purpose:** User interface for product and dealer selection

**Key Files:**
- `index.html` - Main application page with embedded JavaScript
- `styles.css` - Responsive styling with modern design
- `Dockerfile` - Nginx configuration for serving static files

**Features:**
- Product dropdown (auto-populated)
- Dealer selection
- Individual dealer price display
- All dealers price comparison
- Responsive design

**Port:** 8080

## Data Flow

```
User Browser
    │
    ├─→ GET /products ────────────→ Product Service (Port 5000)
    │                               Returns: List of products
    │
    ├─→ GET /dealers/:productId ──→ Dealer Service (Port 3000)
    │                               Returns: List of dealers for product
    │
    └─→ GET /dealers/:productId/:dealerId → Dealer Service (Port 3000)
                                    Returns: Specific dealer pricing
```

## Deployment Architecture

```
┌─────────────────────────────────────────────┐
│         IBM Code Engine Project             │
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  Product Service Application          │  │
│  │  (Python/Flask on Port 5000)         │  │
│  │  URL: product-service.*.appdomain.cloud │
│  └──────────────────────────────────────┘  │
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  Dealer Pricing Service Application   │  │
│  │  (Node.js/Express on Port 3000)      │  │
│  │  URL: dealer-pricing-service.*.appdomain.cloud │
│  └──────────────────────────────────────┘  │
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  Frontend Application                 │  │
│  │  (Nginx serving static files on 8080)│  │
│  │  URL: dealer-frontend.*.appdomain.cloud │
│  └──────────────────────────────────────┘  │
│                                             │
└─────────────────────────────────────────────┘
```

## Configuration Requirements

### Before Deployment

1. **IBM Cloud Account** - Active account with billing enabled
2. **IBM Cloud CLI** - Installed and configured
3. **Code Engine Plugin** - Installed via IBM Cloud CLI

### During Deployment

1. **Product Service** - Deploy first, save URL
2. **Dealer Service** - Deploy second, save URL
3. **Frontend** - Update `index.html` with both URLs, then deploy

### Environment Variables

**Product Service:**
- `PORT=5000` (set automatically by Code Engine)
- `FLASK_APP=app.py`

**Dealer Pricing Service:**
- `PORT=3000` (set automatically by Code Engine)
- `NODE_ENV=production`

**Frontend:**
- `PORT=8080` (configured in Nginx)

## Testing Checklist

### Local Testing
- [ ] Product Service responds on http://localhost:5000
- [ ] Dealer Service responds on http://localhost:3000
- [ ] Frontend loads on http://localhost:8080
- [ ] Products load in dropdown
- [ ] Dealers load when product selected
- [ ] Prices display correctly

### Deployed Testing
- [ ] Product Service health check passes
- [ ] Dealer Service health check passes
- [ ] Frontend loads without errors
- [ ] Products populate dropdown (Screenshot 6)
- [ ] Dealers list displays (Screenshot 7)
- [ ] Individual price shows (Screenshot 8)
- [ ] All dealers comparison works (Screenshot 9)

## API Response Examples

### Product Service Response
```json
{
  "success": true,
  "products": [
    {
      "id": 1,
      "name": "Laptop Dell XPS 15",
      "category": "Electronics",
      "description": "High-performance laptop..."
    }
  ]
}
```

### Dealer Service Response
```json
{
  "success": true,
  "productId": 1,
  "dealers": [
    {
      "dealerId": 101,
      "dealerName": "TechWorld",
      "price": 1299.99,
      "location": "New York, NY"
    }
  ]
}
```

## Screenshot Requirements

1. **Product Service Deployment** (2 points)
   - Code Engine dashboard showing successful deployment
   - URL visible

2. **Dealer Service Deployment** (2 points)
   - Code Engine dashboard showing successful deployment
   - URL visible

3. **Repository Clone** (1 point)
   - File explorer showing cloned repository structure

4. **Code Update** (2 points)
   - index.html showing updated API_CONFIG with actual URLs

5. **Frontend Deployment** (2 points)
   - Code Engine dashboard showing successful deployment
   - URL visible

6. **Homepage with Products** (2 points)
   - Browser showing frontend URL
   - Product dropdown populated with products

7. **Dealers List** (1 point)
   - Product selected
   - Dealer dropdown showing multiple dealers

8. **Individual Dealer Price** (1 point)
   - Single dealer selected
   - Price displayed for that dealer

9. **All Dealers Comparison** (2 points)
   - "All Dealers" selected
   - Price comparison grid showing all dealers
   - Summary statistics visible

## Troubleshooting Guide

### Common Issues

**Build Failures:**
- Check Dockerfile syntax
- Verify all files are committed
- Review build logs in Code Engine

**Service Not Starting:**
- Check application logs
- Verify port configuration
- Ensure dependencies are correct

**CORS Errors:**
- Verify CORS is enabled in backend services
- Check URL format (no trailing slashes)
- Clear browser cache

**Frontend Not Loading Data:**
- Verify API URLs are correct in index.html
- Check backend services are running
- Use browser dev tools to check network requests

## Resource Management

### Scale Configuration
- Min scale: 1 (keeps one instance always running)
- Max scale: 2 (can scale up to 2 instances under load)
- CPU: 0.25 cores per instance
- Memory: 0.5G per instance

### Cost Considerations
- Free tier: 100,000 vCPU-seconds per month
- Each service uses minimal resources
- Scale to 0 when not in use to save costs

## Cleanup Commands

After completing the assignment:

```bash
# Delete applications
ibmcloud ce application delete --name product-service --force
ibmcloud ce application delete --name dealer-pricing-service --force
ibmcloud ce application delete --name dealer-frontend --force

# Delete project
ibmcloud ce project delete --name microservices-project --hard
```

## Support Resources

- IBM Code Engine Docs: https://cloud.ibm.com/docs/codeengine
- Flask Documentation: https://flask.palletsprojects.com/
- Express Documentation: https://expressjs.com/
- Nginx Documentation: https://nginx.org/en/docs/

---

**Project Version:** 1.0.0  
**Last Updated:** October 2026
