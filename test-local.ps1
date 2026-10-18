# PowerShell Script to Test Microservices Locally
# This helps verify services work before deploying to Code Engine

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Local Testing Script" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor Yellow

$pythonCheck = Get-Command python -ErrorAction SilentlyContinue
$nodeCheck = Get-Command node -ErrorAction SilentlyContinue

if (-not $pythonCheck) {
    Write-Host "ERROR: Python is not installed!" -ForegroundColor Red
    exit 1
}

if (-not $nodeCheck) {
    Write-Host "ERROR: Node.js is not installed!" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Python found: $(python --version)" -ForegroundColor Green
Write-Host "✓ Node.js found: $(node --version)" -ForegroundColor Green
Write-Host ""

# Test Product Service
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Testing Product Service (Python)" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "Installing Python dependencies..." -ForegroundColor Yellow
Set-Location -Path ".\product-service"

if (Test-Path "venv") {
    Write-Host "Virtual environment exists, activating..." -ForegroundColor Yellow
    .\venv\Scripts\Activate.ps1
} else {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv venv
    .\venv\Scripts\Activate.ps1
}

pip install -q -r requirements.txt

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
    Write-Host ""
    Write-Host "Starting Product Service on http://localhost:5000" -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop and move to next test" -ForegroundColor Yellow
    Write-Host ""
    
    # Start the service
    python app.py
} else {
    Write-Host "Failed to install dependencies" -ForegroundColor Red
}

deactivate
Set-Location -Path ".."

# Test Dealer Pricing Service
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Testing Dealer Pricing Service (Node.js)" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "Installing Node.js dependencies..." -ForegroundColor Yellow
Set-Location -Path ".\dealer-pricing-service"

npm install

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
    Write-Host ""
    Write-Host "Starting Dealer Pricing Service on http://localhost:3000" -ForegroundColor Cyan
    Write-Host "Press Ctrl+C to stop and move to next test" -ForegroundColor Yellow
    Write-Host ""
    
    # Start the service
    npm start
} else {
    Write-Host "Failed to install dependencies" -ForegroundColor Red
}

Set-Location -Path ".."

# Test Frontend
Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Testing Frontend" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host "Starting Frontend on http://localhost:8080" -ForegroundColor Cyan
Write-Host ""
Write-Host "IMPORTANT: Update index.html with local URLs first:" -ForegroundColor Yellow
Write-Host "  PRODUCT_SERVICE: 'http://localhost:5000'" -ForegroundColor Yellow
Write-Host "  DEALER_SERVICE: 'http://localhost:3000'" -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to start frontend..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

Set-Location -Path ".\dealer-evaluation-frontend"

Write-Host "Starting HTTP server..." -ForegroundColor Yellow
python -m http.server 8080

Set-Location -Path ".."

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Local Testing Complete" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
