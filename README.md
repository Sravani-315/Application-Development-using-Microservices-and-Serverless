# Final Project: Microservices Deployment

## Project Overview
This project demonstrates the deployment of an integrated microservices application consisting of:
- **Product Details Microservice** (Python/Flask)
- **Dealer Pricing Microservice** (Node.js/Express)
- **Dealer Evaluation Frontend** (HTML/JavaScript)

## Architecture
```
┌─────────────────────────────────────┐
│   Dealer Evaluation Frontend        │
│   (HTML + JavaScript)               │
└──────────┬─────────────┬────────────┘
           │             │
           ▼             ▼
    ┌──────────┐  ┌─────────────┐
    │ Product  │  │   Dealer    │
    │ Details  │  │   Pricing   │
    │ (Python) │  │  (Node.js)  │
    └──────────┘  └─────────────┘
```

## Microservices

### 1. Product Details Service (Python)
- **Technology**: Flask (Python)
- **Port**: 5000
- **Endpoint**: `/products`
- **Purpose**: Provides product catalog information

### 2. Dealer Pricing Service (Node.js)
- **Technology**: Express (Node.js)
- **Port**: 3000
- **Endpoint**: `/dealers/:productId`
- **Purpose**: Provides dealer pricing information for products

### 3. Dealer Evaluation Frontend
- **Technology**: HTML, CSS, JavaScript
- **Port**: 8080
- **Purpose**: User interface for product and dealer selection

## Deployment Instructions

### Prerequisites
1. IBM Cloud Account
2. IBM Code Engine access
3. IBM Cloud CLI installed
4. Git installed

### Step 1: Deploy Product Details Microservice

```bash
cd product-service
ibmcloud login
ibmcloud target -r us-south
ibmcloud ce project create --name microservices-project
ibmcloud ce application create --name product-service --build-source . --port 5000
```

### Step 2: Deploy Dealer Pricing Microservice

```bash
cd dealer-pricing-service
ibmcloud ce application create --name dealer-pricing-service --build-source . --port 3000
```

### Step 3: Deploy Frontend Microservice

```bash
cd dealer-evaluation-frontend
# Update index.html with deployed URLs
ibmcloud ce application create --name dealer-frontend --build-source . --port 8080
```

## Testing the Application

1. Open the frontend URL in a browser
2. Select a product from the dropdown
3. View dealers supplying the product
4. Select a dealer to view their price
5. Select "All Dealers" to compare all prices

## Grading Checklist

- [ ] Product Details Service deployed (Screenshot)
- [ ] Dealer Pricing Service deployed (Screenshot)
- [ ] Frontend repository cloned (Screenshot)
- [ ] Code updated with API endpoints (Screenshot)
- [ ] Frontend deployed (Screenshot)
- [ ] Homepage with products loaded (Screenshot)
- [ ] Dealers list displayed (Screenshot)
- [ ] Individual dealer price displayed (Screenshot)
- [ ] All dealers prices displayed (Screenshot)

## Project Structure

```
.
├── README.md
├── product-service/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── dealer-pricing-service/
│   ├── server.js
│   ├── package.json
│   └── Dockerfile
└── dealer-evaluation-frontend/
    ├── index.html
    ├── styles.css
    ├── script.js
    └── Dockerfile
```

## Notes
- All services must be deployed on IBM Code Engine
- Update frontend with actual deployed URLs
- Ensure CORS is enabled on backend services
- Test each endpoint independently before integration
