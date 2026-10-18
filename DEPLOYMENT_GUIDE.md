# Complete Deployment Guide for Final Project

## Overview
This guide will walk you through deploying all three microservices to IBM Code Engine and completing the final project assignment.

## Prerequisites Checklist
- [ ] IBM Cloud account created
- [ ] IBM Cloud CLI installed
- [ ] Git installed
- [ ] Code Engine access enabled
- [ ] Project workspace ready

## Installation Steps

### 1. Install IBM Cloud CLI

**Windows:**
```powershell
# Download and run the installer from:
# https://github.com/IBM-Cloud/ibm-cloud-cli-release/releases/
```

**Verify Installation:**
```bash
ibmcloud --version
```

### 2. Install Code Engine Plugin

```bash
ibmcloud plugin install code-engine
```

## Deployment Steps

### Step 1: Login to IBM Cloud

```bash
# Login
ibmcloud login

# Or login with SSO
ibmcloud login --sso

# Target your region (choose closest to you)
ibmcloud target -r us-south
# Other regions: us-east, eu-gb, eu-de, jp-tok, au-syd
```

### Step 2: Create Code Engine Project

```bash
# Create a new project
ibmcloud ce project create --name microservices-project

# Or select existing project
ibmcloud ce project select --name microservices-project

# Verify project
ibmcloud ce project current
```

### Step 3: Deploy Product Details Service (Python)

```bash
# Navigate to product service directory
cd product-service

# Deploy the application
ibmcloud ce application create \
  --name product-service \
  --build-source . \
  --port 5000 \
  --min-scale 1 \
  --max-scale 2 \
  --cpu 0.25 \
  --memory 0.5G

# Wait for deployment to complete
ibmcloud ce application get --name product-service --output url

# Save this URL! You'll need it later.
```

**📸 Screenshot 1: Take a screenshot showing successful deployment**

Test the service:
```bash
# Replace with your actual URL
curl https://product-service.xxxxx.us-south.codeengine.appdomain.cloud/products
```

### Step 4: Deploy Dealer Pricing Service (Node.js)

```bash
# Navigate to dealer pricing service directory
cd ../dealer-pricing-service

# Deploy the application
ibmcloud ce application create \
  --name dealer-pricing-service \
  --build-source . \
  --port 3000 \
  --min-scale 1 \
  --max-scale 2 \
  --cpu 0.25 \
  --memory 0.5G

# Get the URL
ibmcloud ce application get --name dealer-pricing-service --output url

# Save this URL! You'll need it for the frontend.
```

**📸 Screenshot 2: Take a screenshot showing successful deployment**

Test the service:
```bash
# Replace with your actual URL
curl https://dealer-pricing-service.xxxxx.us-south.codeengine.appdomain.cloud/dealers/1
```

### Step 5: Prepare Frontend Service

```bash
# Navigate to frontend directory
cd ../dealer-evaluation-frontend
```

**📸 Screenshot 3: Take a screenshot of the cloned repository in your file explorer**

Now update the frontend code:

1. Open `index.html` in a text editor
2. Find the `API_CONFIG` object (around line 94)
3. Replace the placeholder URLs with your actual service URLs:

```javascript
const API_CONFIG = {
    PRODUCT_SERVICE: 'https://product-service.xxxxx.us-south.codeengine.appdomain.cloud',
    DEALER_SERVICE: 'https://dealer-pricing-service.xxxxx.us-south.codeengine.appdomain.cloud'
};
```

**📸 Screenshot 4: Take a screenshot showing the updated API_CONFIG in index.html**

### Step 6: Deploy Frontend Service

```bash
# Deploy the frontend
ibmcloud ce application create \
  --name dealer-frontend \
  --build-source . \
  --port 8080 \
  --min-scale 1 \
  --max-scale 2 \
  --cpu 0.25 \
  --memory 0.5G

# Get the frontend URL
ibmcloud ce application get --name dealer-frontend --output url
```

**📸 Screenshot 5: Take a screenshot showing successful frontend deployment**

### Step 7: Test the Complete Application

Open the frontend URL in your browser.

**📸 Screenshot 6: Homepage with products preloaded in the dropdown**
- The product dropdown should show all products

**📸 Screenshot 7: Dealers list when a product is selected**
- Select any product from the dropdown
- The dealers supplying that product should be listed

**📸 Screenshot 8: Individual dealer price**
- Select a specific dealer from the dealer dropdown
- The price from that dealer should be displayed

**📸 Screenshot 9: All dealers prices comparison**
- Select "All Dealers (Compare Prices)" from the dealer dropdown
- All dealer prices should be displayed with comparison statistics

## Verification Commands

```bash
# List all applications
ibmcloud ce application list

# Check logs for product service
ibmcloud ce application logs --name product-service

# Check logs for dealer service
ibmcloud ce application logs --name dealer-pricing-service

# Check logs for frontend
ibmcloud ce application logs --name dealer-frontend

# Get application details
ibmcloud ce application get --name product-service
ibmcloud ce application get --name dealer-pricing-service
ibmcloud ce application get --name dealer-frontend
```

## Troubleshooting

### Build Failed
```bash
# Check build logs
ibmcloud ce buildrun logs --build <build-name>

# List builds
ibmcloud ce build list
```

### Application Not Starting
```bash
# Check application events
ibmcloud ce application events --name <app-name>

# Check application logs with tail
ibmcloud ce application logs --name <app-name> --tail 100
```

### Update Application
```bash
# Update an application
ibmcloud ce application update --name <app-name> --build-source .
```

### Delete and Redeploy
```bash
# Delete an application
ibmcloud ce application delete --name <app-name>

# Redeploy
ibmcloud ce application create --name <app-name> --build-source . --port <port>
```

### CORS Issues
If you see CORS errors in the browser console:
1. Both backend services have CORS enabled by default
2. Make sure you're using the correct URLs (no trailing slashes)
3. Check that services are deployed correctly
4. Clear browser cache and try again

### Products Not Loading
1. Check Product Service is running:
   ```bash
   curl https://your-product-service-url/health
   ```
2. Verify URL in frontend code is correct (no trailing slash)
3. Check browser console for errors
4. Check Product Service logs

### Dealers Not Loading
1. Check Dealer Service is running:
   ```bash
   curl https://your-dealer-service-url/health
   ```
2. Verify URL in frontend code is correct (no trailing slash)
3. Select a valid product first
4. Check Dealer Service logs

## Cost Management

Code Engine charges based on usage. To minimize costs:

```bash
# Scale down applications when not testing
ibmcloud ce application update --name <app-name> --min-scale 0 --max-scale 1

# Delete applications after completing the assignment
ibmcloud ce application delete --name product-service
ibmcloud ce application delete --name dealer-pricing-service
ibmcloud ce application delete --name dealer-frontend

# Delete the project
ibmcloud ce project delete --name microservices-project
```

## Grading Checklist

Complete all these steps and submit screenshots:

- [ ] 1. Product Service deployed successfully (2 points)
- [ ] 2. Dealer Pricing Service deployed successfully (2 points)
- [ ] 3. Frontend repository cloned (1 point)
- [ ] 4. Code updated with API endpoints in index.html (2 points)
- [ ] 5. Frontend deployed successfully (2 points)
- [ ] 6. Homepage showing products preloaded (2 points)
- [ ] 7. Dealers list displayed when product selected (1 point)
- [ ] 8. Individual dealer price displayed (1 point)
- [ ] 9. All dealers prices displayed (2 points)

**Total: 15 points**

## Additional Resources

- [IBM Code Engine Documentation](https://cloud.ibm.com/docs/codeengine)
- [IBM Cloud CLI Reference](https://cloud.ibm.com/docs/cli)
- [Code Engine Samples](https://github.com/IBM/CodeEngine)

## Support

If you encounter issues:
1. Check the troubleshooting section
2. Review application logs
3. Verify all URLs are correct
4. Ensure all services are running
5. Check IBM Cloud status page for outages

## Clean Up After Submission

After you've submitted your assignment and received your grade:

```bash
# Delete all applications
ibmcloud ce application delete --name product-service --force
ibmcloud ce application delete --name dealer-pricing-service --force
ibmcloud ce application delete --name dealer-frontend --force

# Delete the project
ibmcloud ce project delete --name microservices-project --hard
```

This will prevent any unexpected charges on your IBM Cloud account.

---

**Good luck with your final project! 🚀**
