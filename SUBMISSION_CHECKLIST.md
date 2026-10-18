# Final Project Submission Checklist

Use this checklist to ensure you have everything needed for your submission.

## Before You Start

- [ ] IBM Cloud account is active
- [ ] IBM Cloud CLI is installed
- [ ] Code Engine plugin is installed
- [ ] You have your project files ready

## Deployment Steps

### 1. Product Service (Python) - 2 Points

- [ ] Navigated to `product-service` directory
- [ ] Ran deployment command
- [ ] Deployment succeeded
- [ ] Got the service URL
- [ ] Tested: `curl <product-service-url>/products`
- [ ] **📸 SCREENSHOT 1: Code Engine dashboard showing successful deployment**

**What to capture:**
- Application name: "product-service"
- Status: "Ready"
- URL visible
- Deployment details

### 2. Dealer Pricing Service (Node.js) - 2 Points

- [ ] Navigated to `dealer-pricing-service` directory
- [ ] Ran deployment command
- [ ] Deployment succeeded
- [ ] Got the service URL
- [ ] Tested: `curl <dealer-service-url>/dealers/1`
- [ ] **📸 SCREENSHOT 2: Code Engine dashboard showing successful deployment**

**What to capture:**
- Application name: "dealer-pricing-service"
- Status: "Ready"
- URL visible
- Deployment details

### 3. Repository Clone - 1 Point

- [ ] All project files are in your workspace
- [ ] Directory structure is intact
- [ ] All three microservice folders exist
- [ ] **📸 SCREENSHOT 3: File explorer showing cloned repository structure**

**What to capture:**
- Full path to project directory
- All three folders visible (product-service, dealer-pricing-service, dealer-evaluation-frontend)
- Files visible in each folder

### 4. Code Update - 2 Points

- [ ] Opened `dealer-evaluation-frontend/index.html`
- [ ] Located the `API_CONFIG` object
- [ ] Replaced `YOUR_PRODUCT_SERVICE_URL` with actual Product Service URL
- [ ] Replaced `YOUR_DEALER_PRICING_SERVICE_URL` with actual Dealer Service URL
- [ ] Saved the file
- [ ] **📸 SCREENSHOT 4: index.html showing updated API_CONFIG**

**What to capture:**
```javascript
const API_CONFIG = {
    PRODUCT_SERVICE: 'https://product-service.xxxxx.us-south.codeengine.appdomain.cloud',
    DEALER_SERVICE: 'https://dealer-pricing-service.xxxxx.us-south.codeengine.appdomain.cloud'
};
```
- Line numbers visible
- Both URLs clearly shown
- No placeholder text remaining

### 5. Frontend Deployment - 2 Points

- [ ] Navigated to `dealer-evaluation-frontend` directory
- [ ] Verified index.html has correct URLs
- [ ] Ran deployment command
- [ ] Deployment succeeded
- [ ] Got the frontend URL
- [ ] **📸 SCREENSHOT 5: Code Engine dashboard showing successful deployment**

**What to capture:**
- Application name: "dealer-frontend"
- Status: "Ready"
- URL visible
- Deployment details

### 6. Homepage with Products - 2 Points

- [ ] Opened frontend URL in browser
- [ ] Page loaded without errors
- [ ] Product dropdown is visible
- [ ] Dropdown contains multiple products
- [ ] Products are preloaded (not "Select a Product")
- [ ] **📸 SCREENSHOT 6: Homepage with products in dropdown**

**What to capture:**
- Browser address bar showing frontend URL
- "Dealer Evaluation System" header
- Product dropdown with products visible
- No error messages

**Expected products:**
- Laptop Dell XPS 15
- iPhone 14 Pro
- Samsung Galaxy S23
- MacBook Pro M2
- Sony WH-1000XM5

### 7. Dealers List - 1 Point

- [ ] Selected a product from dropdown
- [ ] Product details displayed
- [ ] Dealer dropdown appeared
- [ ] Dealer dropdown contains multiple dealers
- [ ] Each dealer shows name and location
- [ ] **📸 SCREENSHOT 7: Dealers list when product selected**

**What to capture:**
- Selected product name visible
- Product details displayed
- Dealer dropdown showing multiple dealers
- Dealer names and locations visible

### 8. Individual Dealer Price - 1 Point

- [ ] Selected a specific dealer from dropdown
- [ ] Price section appeared
- [ ] Dealer name is displayed
- [ ] Dealer location is displayed
- [ ] Price is displayed in dollars
- [ ] **📸 SCREENSHOT 8: Individual dealer price**

**What to capture:**
- Product selected
- Single dealer selected
- Dealer information (name and location)
- Price displayed prominently
- "Pricing Information" section

### 9. All Dealers Comparison - 2 Points

- [ ] Selected "All Dealers (Compare Prices)" option
- [ ] All dealer cards displayed
- [ ] Each card shows dealer name, location, and price
- [ ] Best price is highlighted/badged
- [ ] Price summary statistics visible (min, max, average, range)
- [ ] **📸 SCREENSHOT 9: All dealers price comparison**

**What to capture:**
- "All Dealers" selected in dropdown
- Multiple dealer cards in grid layout
- "Best Price" badge/indicator visible
- Price Summary section with statistics
- All prices clearly visible

## Screenshot Quality Guidelines

For all screenshots:
- [ ] Image is clear and readable
- [ ] Text is not blurry
- [ ] URLs are fully visible (not cut off)
- [ ] Date/time stamp visible (if required)
- [ ] No sensitive information visible (passwords, tokens, etc.)
- [ ] File format: PNG or JPG
- [ ] Resolution: Minimum 1280x720

## Pre-Submission Verification

### Technical Verification
- [ ] All three services are deployed and running
- [ ] All three services show "Ready" status in Code Engine
- [ ] Product Service health check passes
- [ ] Dealer Service health check passes
- [ ] Frontend loads without errors
- [ ] Browser console shows no critical errors

### Test User Flow
- [ ] Open frontend URL
- [ ] Products load in dropdown ✓
- [ ] Select product → details show ✓
- [ ] Dealers load in dropdown ✓
- [ ] Select dealer → price shows ✓
- [ ] Select "All Dealers" → comparison shows ✓

### Screenshot Verification
- [ ] Screenshot 1: Product Service deployment (2 pts)
- [ ] Screenshot 2: Dealer Service deployment (2 pts)
- [ ] Screenshot 3: Repository cloned (1 pt)
- [ ] Screenshot 4: Code updated (2 pts)
- [ ] Screenshot 5: Frontend deployment (2 pts)
- [ ] Screenshot 6: Products loaded (2 pts)
- [ ] Screenshot 7: Dealers listed (1 pt)
- [ ] Screenshot 8: Single price (1 pt)
- [ ] Screenshot 9: All prices (2 pts)

**Total Points: 15**

## Common Mistakes to Avoid

❌ **Don't:**
- Submit screenshots before services are "Ready"
- Forget to update API URLs in index.html
- Include trailing slashes in URLs
- Submit blurry or unclear screenshots
- Miss the price summary in screenshot 9
- Forget to show the "Best Price" indicator

✅ **Do:**
- Wait for all deployments to complete
- Verify URLs are correct before deploying frontend
- Test each feature before taking screenshots
- Ensure screenshots are clear and complete
- Show the full browser window including address bar
- Capture all required elements in each screenshot

## Troubleshooting Before Submission

### If products don't load:
1. Check Product Service URL in index.html
2. Verify Product Service is running: `ibmcloud ce application get --name product-service`
3. Test endpoint: `curl <product-service-url>/products`
4. Check browser console for errors

### If dealers don't load:
1. Check Dealer Service URL in index.html
2. Verify Dealer Service is running: `ibmcloud ce application get --name dealer-pricing-service`
3. Test endpoint: `curl <dealer-service-url>/dealers/1`
4. Make sure you selected a product first

### If frontend doesn't load:
1. Check frontend deployment status
2. View logs: `ibmcloud ce application logs --name dealer-frontend`
3. Verify index.html was updated with correct URLs
4. Clear browser cache and reload

### If you see CORS errors:
1. Both backend services have CORS enabled
2. Check that URLs don't have trailing slashes
3. Verify services are deployed correctly
4. Try different browser or incognito mode

## Post-Submission

### Keep Services Running
- [ ] Leave all services deployed until grade is confirmed
- [ ] Don't delete the Code Engine project yet
- [ ] Save all URLs in a text file

### After Grade is Confirmed
- [ ] Delete all applications to avoid charges
- [ ] Delete Code Engine project
- [ ] Keep local code for reference

### Cleanup Commands
```bash
ibmcloud ce application delete --name product-service --force
ibmcloud ce application delete --name dealer-pricing-service --force
ibmcloud ce application delete --name dealer-frontend --force
ibmcloud ce project delete --name microservices-project --hard
```

## Need Help?

If you encounter issues:

1. **Check Documentation**
   - README.md
   - DEPLOYMENT_GUIDE.md
   - QUICK_START.md
   - Individual service README files

2. **Review Logs**
   ```bash
   ibmcloud ce application logs --name <app-name> --tail 50
   ```

3. **Verify Deployment**
   ```bash
   ibmcloud ce application list
   ibmcloud ce application get --name <app-name>
   ```

4. **Test Endpoints**
   ```bash
   curl <service-url>/health
   ```

## Final Checklist Before Submit

- [ ] All 9 screenshots are taken
- [ ] All screenshots are clear and readable
- [ ] All required elements are visible in each screenshot
- [ ] Screenshots are properly labeled (1-9)
- [ ] File names indicate what each screenshot shows
- [ ] All services are still running
- [ ] You have saved all deployment URLs
- [ ] You have tested the complete user flow

## Submission Format

Organize your screenshots:
```
screenshots/
├── 01-product-service-deployment.png
├── 02-dealer-service-deployment.png
├── 03-repository-clone.png
├── 04-code-update.png
├── 05-frontend-deployment.png
├── 06-homepage-with-products.png
├── 07-dealers-list.png
├── 08-individual-dealer-price.png
└── 09-all-dealers-comparison.png
```

---

## Confidence Check

Answer these before submitting:

✅ Can you open the frontend and see products? **YES / NO**  
✅ Can you select a product and see dealers? **YES / NO**  
✅ Can you see individual dealer prices? **YES / NO**  
✅ Can you see the comparison view? **YES / NO**  
✅ Do you have all 9 screenshots? **YES / NO**  
✅ Are all screenshots clear? **YES / NO**

If all answers are **YES**, you're ready to submit! 🎉

---

**Good luck with your submission!** 🚀
