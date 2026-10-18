# Dealer Pricing Microservice (Node.js)

## Description
This microservice provides dealer pricing information for products. Built with Express and Node.js.

## Endpoints

### GET /
Health check endpoint
```json
{
  "service": "Dealer Pricing Microservice",
  "status": "running",
  "version": "1.0.0"
}
```

### GET /dealers/:productId
Returns all dealers offering a specific product
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

### GET /dealers/:productId/:dealerId
Returns pricing from a specific dealer for a product
```json
{
  "success": true,
  "productId": 1,
  "dealer": {
    "dealerId": 101,
    "dealerName": "TechWorld",
    "price": 1299.99,
    "location": "New York, NY"
  }
}
```

### GET /health
Service health check
```json
{
  "status": "healthy",
  "service": "dealer-pricing-service"
}
```

## Local Development

### Install dependencies
```bash
npm install
```

### Run locally
```bash
npm start
```
Service will be available at http://localhost:3000

### Development mode (with auto-reload)
```bash
npm run dev
```

### Test the service
```bash
curl http://localhost:3000/dealers/1
```

## Docker Build

```bash
docker build -t dealer-pricing-service .
docker run -p 3000:3000 dealer-pricing-service
```

## Deploy to IBM Code Engine

```bash
# Login to IBM Cloud
ibmcloud login

# Target your region
ibmcloud target -r us-south

# Select your project
ibmcloud ce project select --name microservices-project

# Deploy the application
ibmcloud ce application create \
  --name dealer-pricing-service \
  --build-source . \
  --port 3000 \
  --min-scale 1 \
  --max-scale 2

# Get the URL
ibmcloud ce application get --name dealer-pricing-service
```

## Environment Variables
- `PORT`: Port number (default: 3000)
- `NODE_ENV`: Environment mode (default: development)
