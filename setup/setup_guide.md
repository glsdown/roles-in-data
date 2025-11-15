# Complete Setup Guide

This guide walks you through setting up the Data Roles Guide from scratch.

---

## Quick Start (5 minutes)

```bash
# 1. Clone the repository
git clone https://github.com/glsdown/data-roles-guide.git
cd data-roles-guide

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run locally
mkdocs serve

# 4. Open in browser
# Visit http://localhost:8000
```

That's it! The site is now running locally.

---

## From Scratch (If starting a new project)

### 1. Initialize the Project

```bash
# Create project directory
mkdir data-roles-guide
cd data-roles-guide

# Initialize git
git init
git branch -M main

# Create README
echo "# Data Roles Guide" > README.md
```

### 2. Set Up Python Environment

=== "Using venv (Recommended)"
    ```bash
    # Create virtual environment
    python3 -m venv venv
    
    # Activate it
    # On macOS/Linux:
    source venv/bin/activate
    # On Windows:
    venv\Scripts\activate
    
    # Install MkDocs
    pip install mkdocs mkdocs-material
    ```

=== "Using conda"
    ```bash
    # Create environment
    conda create -n data-roles python=3.11
    
    # Activate it
    conda activate data-roles
    
    # Install MkDocs
    pip install mkdocs mkdocs-material
    ```

### 3. Create Project Structure

Run the setup script:

```bash
# Make it executable
chmod +x setup.sh

# Run it
./setup.sh
```

Or manually create the structure:

```bash
mkdir -p docs/{getting-started,fundamentals,roles,hands-on,scenarios,career-paths,reference}
touch docs/index.md
touch mkdocs.yml
touch requirements.txt
```

### 4. Create `mkdocs.yml`

Copy the configuration from the artifacts above, or create a minimal version:

```yaml
site_name: Understanding Data Roles in Tech
site_url: https://data-roles.sproodlebuzz.com

theme:
  name: material
  features:
    - navigation.instant
    - navigation.tabs
    - search.highlight
  
  palette:
    - scheme: default
      primary: deep purple
      accent: purple

nav:
  - Home: index.md
  - Getting Started: getting-started/
  - Fundamentals: fundamentals/
  - Roles: roles/
  - Hands-On: hands-on/
  - Career Paths: career-paths/
  - Reference: reference/
```

### 5. Create `requirements.txt`

```txt
mkdocs>=1.5.0
mkdocs-material>=9.5.0
mkdocs-git-revision-date-localized-plugin>=1.2.0
mkdocs-minify-plugin>=0.7.0
```

### 6. Install All Dependencies

```bash
pip install -r requirements.txt
```

---

## Local Development

### Serve the Site

```bash
# Start development server
mkdocs serve

# With custom port
mkdocs serve --dev-addr=0.0.0.0:3000

# With live reload
mkdocs serve --livereload
```

Visit `http://localhost:8000` in your browser. The site will auto-reload when you save changes!

### Build the Site

```bash
# Build static site
mkdocs build

# Output will be in site/ directory
ls site/
```

### Clean Build

```bash
# Remove site/ directory
rm -rf site/

# Rebuild
mkdocs build
```

---

## Deploy to GitHub Pages

### One-Time Setup

1. **Create GitHub repository**
   ```bash
   # Create repo on GitHub: data-roles-guide
   
   # Add remote
   git remote add origin https://github.com/glsdown/data-roles-guide.git
   ```

2. **Push your code**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push -u origin main
   ```

3. **Create GitHub Actions workflow**
   
   Create `.github/workflows/deploy.yml` (see artifact above)

4. **Enable GitHub Pages**
   
   - Go to repo Settings → Pages
   - Source: "Deploy from a branch"
   - Branch: `gh-pages`
   - Folder: `/ (root)`
   - Click Save

### Deploy

Every time you push to `main`, GitHub Actions will:

1. Build the site
2. Deploy to `gh-pages` branch
3. Publish to `https://glsdown.github.io/data-roles-guide`

### Manual Deploy

```bash
# Build and deploy
mkdocs gh-deploy

# With custom message
mkdocs gh-deploy --message "Update content"
```

---

## Deploy to AWS S3 (Custom Domain)

See [DEPLOYMENT.md](DEPLOYMENT.md) for complete AWS setup instructions.

### Quick Summary

1. **Build site**
   ```bash
   mkdocs build
   ```

2. **Upload to S3**
   ```bash
   aws s3 sync site/ s3://data-roles.sproodlebuzz.com/ --delete
   ```

3. **Invalidate CloudFront cache**
   ```bash
   aws cloudfront create-invalidation \
       --distribution-id YOUR_ID \
       --paths "/*"
   ```

---

## Project Structure

```
data-roles-guide/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions
├── docs/                        # All content
│   ├── index.md                # Homepage
│   ├── getting-started/
│   │   ├── index.md
│   │   ├── introduction.md
│   │   ├── who-this-is-for.md
│   │   └── setup.md
│   ├── fundamentals/
│   │   ├── index.md
│   │   ├── what-is-data.md
│   │   ├── data-lifecycle.md
│   │   ├── modern-data-stack.md
│   │   └── the-project.md
│   ├── roles/
│   │   ├── index.md
│   │   ├── infrastructure/
│   │   ├── data-pipeline/
│   │   ├── analysis/
│   │   ├── production/
│   │   ├── support/
│   │   └── strategic/
│   ├── hands-on/
│   │   ├── index.md
│   │   ├── project-overview.md
│   │   └── 01-setup-environment.md
│   ├── scenarios/
│   ├── career-paths/
│   ├── reference/
│   ├── assets/
│   │   ├── images/
│   │   └── css/
│   ├── stylesheets/
│   │   └── extra.css
│   ├── javascripts/
│   │   └── extra.js
│   └── includes/
│       └── abbreviations.md
├── mkdocs.yml                   # Configuration
├── requirements.txt             # Python dependencies
├── README.md                    # Project README
├── DEPLOYMENT.md                # AWS deployment guide
├── LICENSE                      # MIT License
├── .gitignore                   # Git ignore rules
└── setup.sh                     # Setup script
```

---

## Writing Content

### Markdown Basics

MkDocs uses Markdown with extensions. Here are the key features:

#### Headings

```markdown
# H1 Heading
## H2 Heading
### H3 Heading
```

#### Links

```markdown
[Link text](path/to/page.md)
[External link](https://example.com)
```

#### Images

```markdown
![Alt text](../assets/images/diagram.png)
```

#### Code Blocks

````markdown
```python
def hello():
    print("Hello, world!")
```
````

#### Admonitions (Callouts)

```markdown
!!! note "Optional Title"
    This is a note callout
    
!!! tip
    This is a tip

!!! warning
    This is a warning

!!! danger
    This is a danger alert
```

#### Tabs

```markdown
=== "Tab 1"
    Content for tab 1

=== "Tab 2"
    Content for tab 2
```

#### Tables

```markdown
| Column 1 | Column 2 |
|----------|----------|
| Value 1  | Value 2  |
```

#### Task Lists

```markdown
- [x] Completed task
- [ ] Incomplete task
```

### Advanced Features

#### Mermaid Diagrams

````markdown
```mermaid
graph LR
    A[Start] --> B[Process]
    B --> C[End]
```
````

#### Annotations

```markdown
Some text with an annotation (1)
{ .annotate }

1.  This is the annotation text
```

#### Footnotes

```markdown
Text with a footnote[^1]

[^1]: This is the footnote content
```

---

## Troubleshooting

### Port 8000 already in use

```bash
# Use different port
mkdocs serve --dev-addr=127.0.0.1:3000
```

### Changes not showing up

```bash
# Force rebuild
rm -rf site/
mkdocs serve
```

### Plugin not working

```bash
# Reinstall dependencies
pip install --upgrade -r requirements.txt
```

### GitHub Pages not updating

1. Check GitHub Actions status (Actions tab)
2. Verify `gh-pages` branch exists
3. Check Pages settings (Settings → Pages)
4. Wait 2-3 minutes for propagation

### AWS S3 shows 403 error

```bash
# Check bucket policy
aws s3api get-bucket-policy --bucket data-roles.sproodlebuzz.com

# Verify website configuration
aws s3api get-bucket-website --bucket data-roles.sproodlebuzz.com
```

---

## Tips & Best Practices

### Content Organisation

- ✅ One topic per page
- ✅ Use clear, descriptive filenames (`data-engineer.md` not `de.md`)
- ✅ Include index files in each directory
- ✅ Link related pages together
- ✅ Add "Next Steps" at the end of pages

### Writing Style

- ✅ Write in second person ("you")
- ✅ Use active voice
- ✅ Keep paragraphs short (3-4 sentences)
- ✅ Use lists and bullets
- ✅ Include code examples
- ✅ Add visual diagrams (Mermaid)

### Navigation

- ✅ Keep navigation shallow (max 3 levels)
- ✅ Group related content
- ✅ Use clear section names
- ✅ Add breadcrumbs for deep pages

### Performance

- ✅ Optimise images (use WebP, compress)
- ✅ Enable minification plugin
- ✅ Use CDN for external resources
- ✅ Keep page sizes reasonable

### SEO

- ✅ Use descriptive page titles
- ✅ Add meta descriptions
- ✅ Include alt text for images
- ✅ Use semantic HTML headings
- ✅ Create sitemap (automatic)

---

## Useful Commands

```bash
# Development
mkdocs serve                    # Start dev server
mkdocs serve --open             # Start and open browser
mkdocs serve --dirtyreload      # Fast reload (skip nav rebuild)

# Building
mkdocs build                    # Build site
mkdocs build --strict           # Build with warnings as errors
mkdocs build --clean            # Remove old files first

# Deployment
mkdocs gh-deploy                # Deploy to GitHub Pages
mkdocs gh-deploy --force        # Force deploy

# Validation
mkdocs build --strict           # Check for broken links
python -m mkdocs serve          # Explicit python invocation

# Cleanup
rm -rf site/                    # Remove build
rm -rf .cache/                  # Remove cache
```

---

## Resources

### Documentation

- [MkDocs Official Docs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [Markdown Guide](https://www.markdownguide.org/)

### Examples

- [Material for MkDocs Demo](https://squidfunk.github.io/mkdocs-material/reference/)
- [FastAPI Docs](https://fastapi.tiangolo.com/) (uses MkDocs)
- [dbt Docs](https://docs.getdbt.com/) (inspiration)

### Tools

- [Visual Studio Code](https://code.visualstudio.com/) - Recommended editor
- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) - VS Code extension
- [Mermaid Live Editor](https://mermaid.live/) - Preview diagrams

---

## Next Steps

Once your site is set up:

1. ✅ Write your first page
2. ✅ Customize the theme (colours, logo)
3. ✅ Add Google Analytics
4. ✅ Set up custom domain
5. ✅ Share with others!

---

## Questions?

- 💬 [GitHub Discussions](https://github.com/glsdown/data-roles-guide/discussions)
- 🐛 [Report an Issue](https://github.com/glsdown/data-roles-guide/issues)
- 📧 [Email](mailto:your.email@example.com)

Happy building! 🚀