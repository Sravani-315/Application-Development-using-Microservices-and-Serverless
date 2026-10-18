# Product Details Microservice (Python)

## Description
This microservice provides product catalog information. Built with Flask and Python.

## Endpoints

### GET /
Health check endpoint
```json
{
  "service": "Product Details Microservice",
  "status": "running",
  "version": "1.0.0"
}
```

### GET /products
Returns all available products
```json
{
  "success": true,
  "products": [...]
}
```

### GET /products/:id
Returns a specific product by ID
```json
{
  "success": true,
  "product": {...}
}
```

### GET /health
Service health check
```json
{
  "status": "healthy",
  "service": "product-service"
}
```

## Local Development

### Install dependencies
```bash
pip install -r requirements.txt
```

### Run locally
```bash
python app.py
```
Service will be available at http://localhost:5000

### Test the service
```bash
curl http://localhost:5000/products
```

## Docker Build

```bash
docker build -t product-service .
docker run -p 5000:5000 product-service
```

## Deploy to IBM Code Engine

```bash
# Login to IBM Cloud
ibmcloud login

# Target your region
ibmcloud target -r us-south

# Create or select a project
ibmcloud ce project create --name microservices-project
ibmcloud ce project select --name microservices-project

# Deploy the application
ibmcloud ce application create \
  --name product-service \
  --build-source . \
  --port 5000 \
  --min-scale 1 \
  --max-scale 2

# Get the URL
ibmcloud ce application get --name product-service
```

## Environment Variables
- `PORT`: Port number (default: 5000)
- `FLASK_APP`: Flask application file (default: app.py)
