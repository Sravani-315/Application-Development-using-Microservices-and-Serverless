# PowerShell Deployment Script for Microservices Final Project
# This script helps deploy all three microservices to IBM Code Engine

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Microservices Deployment Script" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check if IBM Cloud CLI is installed
Write-Host "Checking prerequisites..." -ForegroundColor Yellow
$ibmcloudCheck = Get-Command ibmcloud -ErrorAction SilentlyContinue

if (-not $ibmcloudCheck) {
    Write-Host "ERROR: IBM Cloud CLI is not installed!" -ForegroundColor Red
    Write-Host "Please install from: https://github.com/IBM-Cloud/ibm-cloud-cli-release/releases/" -ForegroundColor Red
    exit 1
}

Write-Host "✓ IBM Cloud CLI found" -ForegroundColor Green

# Check if logged in
Write-Host "Checking IBM Cloud login status..." -ForegroundColor Yellow
$loginCheck = ibmcloud target 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "You need to login to IBM Cloud first." -ForegroundColor Yellow
    Write-Host "Running: ibmcloud login" -ForegroundColor Yellow
    ibmcloud login
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Login failed. Please try again." -ForegroundColor Red
        exit 1
    }
}

Write-Host "✓ Logged in to IBM Cloud" -ForegroundColor Green

# Select or create project
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Step 1: Setting up Code Engine Project" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

$projectName = Read-Host "Enter project name (default: microservices-project)"
if ([string]::IsNullOrWhiteSpace($projectName)) {
    $projectName = "microservices-project"
}

Write-Host "Checking if project exists..." -ForegroundColor Yellow
$projectExists = ibmcloud ce project get --name $projectName 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "Creating new project: $projectName" -ForegroundColor Yellow
    ibmcloud ce project create --name $projectName
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to create project." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Project already exists. Selecting it..." -ForegroundColor Yellow
    ibmcloud ce project select --name $projectName
}

Write-Host "✓ Project ready: $projectName" -ForegroundColor Green

# Deploy Product Service
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Step 2: Deploying Product Service" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "Deploying product-service..." -ForegroundColor Yellow
Set-Location -Path ".\product-service"

ibmcloud ce application create `
    --name product-service `
    --build-source . `
    --port 5000 `
    --min-scale 1 `
    --max-scale 2 `
    --cpu 0.25 `
    --memory 0.5G

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Product Service deployed successfully!" -ForegroundColor Green
    $productUrl = ibmcloud ce application get --name product-service --output url
    Write-Host "Product Service URL: $productUrl" -ForegroundColor Cyan
    Write-Host "📸 Take Screenshot 1: Product Service deployment" -ForegroundColor Magenta
    Read-Host "Press Enter when you've taken the screenshot"
} else {
    Write-Host "Failed to deploy Product Service." -ForegroundColor Red
    Set-Location -Path ".."
    exit 1
}

Set-Location -Path ".."

# Deploy Dealer Pricing Service
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Step 3: Deploying Dealer Pricing Service" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "Deploying dealer-pricing-service..." -ForegroundColor Yellow
Set-Location -Path ".\dealer-pricing-service"

ibmcloud ce application create `
    --name dealer-pricing-service `
    --build-source . `
    --port 3000 `
    --min-scale 1 `
    --max-scale 2 `
    --cpu 0.25 `
    --memory 0.5G

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dealer Pricing Service deployed successfully!" -ForegroundColor Green
    $dealerUrl = ibmcloud ce application get --name dealer-pricing-service --output url
    Write-Host "Dealer Pricing Service URL: $dealerUrl" -ForegroundColor Cyan
    Write-Host "📸 Take Screenshot 2: Dealer Pricing Service deployment" -ForegroundColor Magenta
    Read-Host "Press Enter when you've taken the screenshot"
} else {
    Write-Host "Failed to deploy Dealer Pricing Service." -ForegroundColor Red
    Set-Location -Path ".."
    exit 1
}

Set-Location -Path ".."

# Update Frontend Configuration
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Step 4: Updating Frontend Configuration" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "📸 Take Screenshot 3: Cloned repository in file explorer" -ForegroundColor Magenta
Read-Host "Press Enter when you've taken the screenshot"

Write-Host ""
Write-Host "You need to update the API URLs in index.html" -ForegroundColor Yellow
Write-Host ""
Write-Host "Product Service URL: $productUrl" -ForegroundColor Cyan
Write-Host "Dealer Service URL: $dealerUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "Please update the API_CONFIG in dealer-evaluation-frontend/index.html" -ForegroundColor Yellow
Write-Host "Replace YOUR_PRODUCT_SERVICE_URL with: $productUrl" -ForegroundColor Yellow
Write-Host "Replace YOUR_DEALER_PRICING_SERVICE_URL with: $dealerUrl" -ForegroundColor Yellow
Write-Host ""

$updated = Read-Host "Have you updated index.html? (yes/no)"

if ($updated -ne "yes") {
    Write-Host "Please update index.html and run this script again." -ForegroundColor Red
    exit 1
}

Write-Host "📸 Take Screenshot 4: Updated API_CONFIG in index.html" -ForegroundColor Magenta
Read-Host "Press Enter when you've taken the screenshot"

# Deploy Frontend
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Step 5: Deploying Frontend Service" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "Deploying dealer-evaluation-frontend..." -ForegroundColor Yellow
Set-Location -Path ".\dealer-evaluation-frontend"

ibmcloud ce application create `
    --name dealer-frontend `
    --build-source . `
    --port 8080 `
    --min-scale 1 `
    --max-scale 2 `
    --cpu 0.25 `
    --memory 0.5G

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Frontend deployed successfully!" -ForegroundColor Green
    $frontendUrl = ibmcloud ce application get --name dealer-frontend --output url
    Write-Host "Frontend URL: $frontendUrl" -ForegroundColor Cyan
    Write-Host "📸 Take Screenshot 5: Frontend deployment" -ForegroundColor Magenta
    Read-Host "Press Enter when you've taken the screenshot"
} else {
    Write-Host "Failed to deploy Frontend." -ForegroundColor Red
    Set-Location -Path ".."
    exit 1
}

Set-Location -Path ".."

# Testing Instructions
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Testing Instructions" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Open this URL in your browser: $frontendUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "Take the following screenshots:" -ForegroundColor Yellow
Write-Host "📸 Screenshot 6: Homepage with products in dropdown" -ForegroundColor Magenta
Write-Host "📸 Screenshot 7: Dealers list when product is selected" -ForegroundColor Magenta
Write-Host "📸 Screenshot 8: Individual dealer price display" -ForegroundColor Magenta
Write-Host "📸 Screenshot 9: All dealers price comparison" -ForegroundColor Magenta
Write-Host ""

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Deployment Complete! ✓" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary of URLs:" -ForegroundColor Yellow
Write-Host "Product Service: $productUrl" -ForegroundColor Cyan
Write-Host "Dealer Service: $dealerUrl" -ForegroundColor Cyan
Write-Host "Frontend: $frontendUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "Don't forget to take all 9 screenshots for your assignment!" -ForegroundColor Yellow
Write-Host ""

# Save URLs to file
$urls = @"
Deployment URLs
===============

Product Service: $productUrl
Dealer Pricing Service: $dealerUrl
Frontend: $frontendUrl

Deployed on: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
"@

$urls | Out-File -FilePath "deployment-urls.txt" -Encoding UTF8
Write-Host "URLs saved to deployment-urls.txt" -ForegroundColor Green
