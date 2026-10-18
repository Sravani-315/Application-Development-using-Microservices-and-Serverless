# Quick Start Guide

This is a condensed guide to get you up and running quickly with the final project.

## Prerequisites

✅ IBM Cloud account  
✅ IBM Cloud CLI installed  
✅ Git installed  
✅ Text editor (VS Code, Notepad++, etc.)

## 5-Step Deployment

### Step 1: Login to IBM Cloud

```bash
ibmcloud login
ibmcloud target -r us-south
ibmcloud ce project create --name microservices-project
```

### Step 2: Deploy Product Service

```bash
cd product-service
ibmcloud ce application create --name product-service --build-source . --port 5000
```

**📸 Take Screenshot 1** - Deployment success

Get URL:
```bash
ibmcloud ce application get --name product-service --output url
```

### Step 3: Deploy Dealer Service

```bash
cd ../dealer-pricing-service
ibmcloud ce application create --name dealer-pricing-service --build-source . --port 3000
```

**📸 Take Screenshot 2** - Deployment success

Get URL:
```bash
ibmcloud ce application get --name dealer-pricing-service --output url
```

### Step 4: Update Frontend Code

**📸 Take Screenshot 3** - Repository in file explorer

Edit `dealer-evaluation-frontend/index.html`:

Find this section:
```javascript
const API_CONFIG = {
    PRODUCT_SERVICE: 'YOUR_PRODUCT_SERVICE_URL',
    DEALER_SERVICE: 'YOUR_DEALER_PRICING_SERVICE_URL'
};
```

Replace with your actual URLs from Steps 2 and 3.

**📸 Take Screenshot 4** - Updated code

### Step 5: Deploy Frontend

```bash
cd ../dealer-evaluation-frontend
ibmcloud ce application create --name dealer-frontend --build-source . --port 8080
```

**📸 Take Screenshot 5** - Deployment success

Get URL:
```bash
ibmcloud ce application get --name dealer-frontend --output url
```

## Testing (4 Screenshots)

Open the frontend URL in your browser and take these screenshots:

**📸 Screenshot 6:** Homepage with products in dropdown  
**📸 Screenshot 7:** Select a product → dealers list appears  
**📸 Screenshot 8:** Select one dealer → price displays  
**📸 Screenshot 9:** Select "All Dealers" → comparison view  

## Quick Commands

```bash
# List all apps
ibmcloud ce application list

# Check logs
ibmcloud ce application logs --name <app-name>

# Update an app
ibmcloud ce application update --name <app-name> --build-source .

# Delete an app
ibmcloud ce application delete --name <app-name>
```

## Troubleshooting

**Build fails?**
```bash
ibmcloud ce buildrun logs --build <build-name>
```

**App not starting?**
```bash
ibmcloud ce application logs --name <app-name> --tail 50
```

**Products not loading?**
- Check Product Service URL in index.html (no trailing slash)
- Test: `curl <product-service-url>/products`
- Check browser console for errors

**Dealers not loading?**
- Check Dealer Service URL in index.html (no trailing slash)
- Test: `curl <dealer-service-url>/dealers/1`
- Make sure you selected a product first

## Cleanup (After Submission)

```bash
ibmcloud ce application delete --name product-service --force
ibmcloud ce application delete --name dealer-pricing-service --force
ibmcloud ce application delete --name dealer-frontend --force
ibmcloud ce project delete --name microservices-project --hard
```

## Grading Checklist

- [ ] Screenshot 1: Product Service deployed (2 pts)
- [ ] Screenshot 2: Dealer Service deployed (2 pts)
- [ ] Screenshot 3: Repository cloned (1 pt)
- [ ] Screenshot 4: Code updated (2 pts)
- [ ] Screenshot 5: Frontend deployed (2 pts)
- [ ] Screenshot 6: Products loaded (2 pts)
- [ ] Screenshot 7: Dealers listed (1 pt)
- [ ] Screenshot 8: Single dealer price (1 pt)
- [ ] Screenshot 9: All dealers comparison (2 pts)

**Total: 15 points**

## URLs to Save

Write down these URLs as you deploy:

```
Product Service: _________________________________

Dealer Service: __________________________________

Frontend: ________________________________________
```

## Need More Help?

- Read `DEPLOYMENT_GUIDE.md` for detailed instructions
- Check `PROJECT_STRUCTURE.md` for architecture details
- Review individual service README files
- Run `.\deploy.ps1` for automated deployment (Windows)

---

**Good luck! 🚀**
