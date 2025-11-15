# Deploying to AWS S3 + CloudFront

This guide walks you through deploying your MkDocs site to AWS S3 with CloudFront CDN under your custom domain `data-roles.sproodlebuzz.com`.

---

## Cost Estimate

| Service | Monthly Cost (Estimate) |
|---------|------------------------|
| **S3 Storage** | $0.50 - $2 (for ~500 pages) |
| **CloudFront Data Transfer** | $1 - $10 (for 10K-100K visitors) |
| **Route 53 Hosted Zone** | $0.50 |
| **SSL Certificate (ACM)** | $0 (FREE!) |
| **Total** | **$2 - $13/month** |

!!! tip "AWS Free Tier"
    If you're within the first 12 months of AWS, you get:
    
    - 5GB S3 storage free
    - 1TB CloudFront data transfer free
    - 2M CloudFront requests free
    
    This means your costs could be **$0.50 - $2/month** for the first year!

---

## Prerequisites

- [x] AWS account
- [x] Domain `sproodlebuzz.com` (you own this)
- [x] AWS CLI installed locally
- [x] Basic command line knowledge

---

## Step 1: Build Your Site

```bash
# Install dependencies
pip install -r requirements.txt

# Build the static site
mkdocs build

# Output will be in the site/ directory
ls site/
# index.html, assets/, css/, js/, etc.
```

---

## Step 2: Create S3 Bucket

### Via AWS Console

1. Go to [S3 Console](https://s3.console.aws.amazon.com/)
2. Click **"Create bucket"**
3. Settings:
   - **Bucket name:** `data-roles.sproodlebuzz.com` (must match your subdomain exactly)
   - **Region:** `us-east-1` (required for CloudFront)
   - **Block all public access:** UNCHECK (we need public access for website hosting)
4. Click **"Create bucket"**

### Via AWS CLI

```bash
aws s3 mb s3://data-roles.sproodlebuzz.com --region us-east-1
```

---

## Step 3: Configure S3 for Static Website Hosting

### Via AWS Console

1. Select your bucket
2. Go to **Properties** tab
3. Scroll to **Static website hosting**
4. Click **Edit**
5. Settings:
   - **Enable:** Static website hosting
   - **Index document:** `index.html`
   - **Error document:** `404.html`
6. **Save changes**
7. Note the **Bucket website endpoint** (e.g., `http://data-roles.sproodlebuzz.com.s3-website-us-east-1.amazonaws.com`)

### Via AWS CLI

```bash
aws s3 website s3://data-roles.sproodlebuzz.com/ \
    --index-document index.html \
    --error-document 404.html
```

---

## Step 4: Set Bucket Policy (Make Content Public)

Create a file `bucket-policy.json`:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::data-roles.sproodlebuzz.com/*"
        }
    ]
}
```

Apply it:

```bash
aws s3api put-bucket-policy \
    --bucket data-roles.sproodlebuzz.com \
    --policy file://bucket-policy.json
```

---

## Step 5: Upload Your Site

### One-time upload

```bash
aws s3 sync site/ s3://data-roles.sproodlebuzz.com/ \
    --delete \
    --cache-control "max-age=3600"
```

### Automated with GitHub Actions

Create `.github/workflows/deploy-s3.yml`:

```yaml
name: Deploy to AWS S3

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-python@v5
        with:
          python-version: 3.x
          cache: 'pip'
      
      - name: Install dependencies
        run: pip install -r requirements.txt
      
      - name: Build site
        run: mkdocs build
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      
      - name: Deploy to S3
        run: |
          aws s3 sync site/ s3://data-roles.sproodlebuzz.com/ \
            --delete \
            --cache-control "max-age=3600"
      
      - name: Invalidate CloudFront cache
        run: |
          aws cloudfront create-invalidation \
            --distribution-id ${{ secrets.CLOUDFRONT_DISTRIBUTION_ID }} \
            --paths "/*"
```

**Set these GitHub Secrets:**

1. Go to your repo → Settings → Secrets and variables → Actions
2. Add:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `CLOUDFRONT_DISTRIBUTION_ID` (we'll get this in Step 7)

---

## Step 6: Request SSL Certificate (ACM)

!!! warning "Important"
    SSL certificates for CloudFront **must** be in `us-east-1` region, even if your content is in another region.

### Via AWS Console

1. Go to [Certificate Manager Console](https://console.aws.amazon.com/acm/)
2. **Ensure you're in us-east-1 region** (top right)
3. Click **"Request a certificate"**
4. Choose **"Request a public certificate"**
5. **Domain names:**
   - `data-roles.sproodlebuzz.com`
   - Optional: `*.sproodlebuzz.com` (if you want wildcard)
6. **Validation method:** DNS validation
7. Click **"Request"**

### Validate the Certificate

1. Click into your certificate
2. Click **"Create records in Route 53"** (if `sproodlebuzz.com` is in Route 53)
3. Or manually add the CNAME records to your DNS provider
4. Wait 5-30 minutes for validation

### Via AWS CLI

```bash
# Request certificate
aws acm request-certificate \
    --domain-name data-roles.sproodlebuzz.com \
    --validation-method DNS \
    --region us-east-1

# Note the CertificateArn from output
```

---

## Step 7: Create CloudFront Distribution

### Via AWS Console

1. Go to [CloudFront Console](https://console.aws.amazon.com/cloudfront/)
2. Click **"Create distribution"**
3. Settings:

**Origin:**
- **Origin domain:** Select your S3 bucket (or paste website endpoint)
- **Origin path:** leave empty
- **Name:** `data-roles-s3`

**Default cache behavior:**
- **Viewer protocol policy:** Redirect HTTP to HTTPS
- **Allowed HTTP methods:** GET, HEAD
- **Cache policy:** CachingOptimised (recommended)

**Settings:**
- **Alternate domain names (CNAMEs):** `data-roles.sproodlebuzz.com`
- **Custom SSL certificate:** Select your ACM certificate
- **Default root object:** `index.html`

4. Click **"Create distribution"**
5. **Note the Distribution ID** (e.g., `E1234ABCDEF`) - you need this!
6. Wait 10-15 minutes for deployment (Status: "Deployed")

### Via AWS CLI

```bash
# Create distribution config file
cat > cloudfront-config.json <<EOF
{
    "CallerReference": "$(date +%s)",
    "Comment": "Data Roles Guide",
    "Enabled": true,
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-data-roles",
                "DomainName": "data-roles.sproodlebuzz.com.s3.us-east-1.amazonaws.com",
                "S3OriginConfig": {
                    "OriginAccessIdentity": ""
                }
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-data-roles",
        "ViewerProtocolPolicy": "redirect-to-https",
        "AllowedMethods": {
            "Quantity": 2,
            "Items": ["GET", "HEAD"]
        },
        "MinTTL": 0,
        "DefaultTTL": 3600,
        "MaxTTL": 86400,
        "Compress": true
    },
    "Aliases": {
        "Quantity": 1,
        "Items": ["data-roles.sproodlebuzz.com"]
    },
    "ViewerCertificate": {
        "ACMCertificateArn": "arn:aws:acm:us-east-1:ACCOUNT_ID:certificate/CERT_ID",
        "SSLSupportMethod": "sni-only",
        "MinimumProtocolVersion": "TLSv1.2_2021"
    },
    "DefaultRootObject": "index.html"
}
EOF

# Create distribution
aws cloudfront create-distribution \
    --distribution-config file://cloudfront-config.json
```

---

## Step 8: Update DNS (Route 53 or Your DNS Provider)

### If using Route 53

1. Go to [Route 53 Console](https://console.aws.amazon.com/route53/)
2. Select your hosted zone: `sproodlebuzz.com`
3. Click **"Create record"**
4. Settings:
   - **Record name:** `data-roles`
   - **Record type:** `A - IPv4 address`
   - **Alias:** YES
   - **Route traffic to:** 
     - Select **"Alias to CloudFront distribution"**
     - Choose your distribution
   - **Routing policy:** Simple routing
5. Click **"Create records"**

### If using another DNS provider (Cloudflare, Namecheap, etc.)

1. Get your CloudFront distribution domain name (e.g., `d123abc.cloudfront.net`)
2. In your DNS provider, add:
   - **Type:** CNAME
   - **Name:** `data-roles`
   - **Value:** `d123abc.cloudfront.net`
   - **TTL:** 300 (5 minutes)

---

## Step 9: Test Your Site

Wait 5-10 minutes for DNS to propagate, then visit:

```
https://data-roles.sproodlebuzz.com
```

You should see your MkDocs site with:
- ✅ Valid SSL certificate (padlock icon)
- ✅ Fast loading (CloudFront CDN)
- ✅ All pages working

---

## Ongoing Maintenance

### Update Content

Every time you push to `main`, GitHub Actions will:
1. Build the site
2. Upload to S3
3. Invalidate CloudFront cache

Your site updates automatically! 🎉

### Manual Cache Invalidation

If you need to force a cache refresh:

```bash
aws cloudfront create-invalidation \
    --distribution-id E1234ABCDEF \
    --paths "/*"
```

### Monitor Costs

1. Go to [AWS Cost Explorer](https://console.aws.amazon.com/cost-management/home)
2. Filter by service: S3, CloudFront
3. Set up billing alerts if costs exceed $5/month

---

## Troubleshooting

### Site shows 403 Forbidden

**Cause:** Bucket policy not public or incorrect

**Fix:**
```bash
# Verify bucket policy
aws s3api get-bucket-policy --bucket data-roles.sproodlebuzz.com

# Reapply policy
aws s3api put-bucket-policy --bucket data-roles.sproodlebuzz.com --policy file://bucket-policy.json
```

### SSL certificate error

**Cause:** Certificate not validated or not in us-east-1

**Fix:**
1. Check certificate status in ACM (us-east-1)
2. Ensure DNS validation records are correct
3. Wait for validation (can take 30 mins)

### CloudFront showing old content

**Cause:** Cache not invalidated

**Fix:**
```bash
aws cloudfront create-invalidation \
    --distribution-id YOUR_DIST_ID \
    --paths "/*"
```

### DNS not resolving

**Cause:** DNS propagation takes time

**Fix:**
- Wait 30-60 minutes
- Check DNS with: `dig data-roles.sproodlebuzz.com`
- Verify CNAME/A record is correct

---

## Comparison: GitHub Pages vs AWS S3

| Feature | GitHub Pages | AWS S3 + CloudFront |
|---------|--------------|---------------------|
| **Cost** | Free | $2-13/month |
| **Setup** | Easy (1 click) | Moderate (30 mins) |
| **Custom Domain** | Yes | Yes |
| **SSL** | Free (automatic) | Free (ACM) |
| **CDN** | Yes (global) | Yes (faster, more locations) |
| **Build** | GitHub Actions | GitHub Actions |
| **Control** | Limited | Full control |
| **Analytics** | Limited | CloudWatch, custom |

**Recommendation:**

- **Start with GitHub Pages** - It's free, easy, and works great
- **Move to AWS later** if you need:
  - Advanced caching control
  - Better analytics
  - Custom Lambda@Edge functions
  - Integration with other AWS services

---

## Next Steps

Once deployed, consider:

1. **Set up Google Analytics** (update `mkdocs.yml`)
2. **Enable search console** (verify domain)
3. **Add CloudWatch alarms** for cost monitoring
4. **Set up automated backups** of S3 bucket
5. **Enable CloudFront access logs** for analytics

---

## Questions?

- 📧 [Email support](mailto:your.email@example.com)
- 💬 [GitHub Discussions](https://github.com/glsdown/data-roles-guide/discussions)
- 🐛 [Report Issues](https://github.com/glsdown/data-roles-guide/issues)