#!/bin/bash

# Quick setup script for Data Roles Guide
# This creates the full directory structure and placeholder files

set -e  # Exit on error

echo "🚀 Setting up Data Roles Guide..."
echo ""

# Create main directories
echo "📁 Creating directory structure..."

mkdir -p docs/{getting-started,fundamentals,roles/{infrastructure,data-pipeline,analysis,production,support,strategic},hands-on,scenarios,career-paths,reference}
mkdir -p docs/assets/{images,css,js}
mkdir -p .github/workflows
mkdir -p overrides

echo "✓ Directories created"
echo ""

# Create placeholder index files
echo "📝 Creating placeholder index files..."

# Getting Started
cat > docs/getting-started/index.md <<EOF
# Getting Started

Welcome to the Data Roles Guide!

This section will help you:

- Understand what this guide offers
- Determine if it's right for you
- Set up your development environment

[Continue to Introduction →](introduction.md)
EOF

cat > docs/getting-started/introduction.md <<EOF
# Introduction

Content coming soon...

[Next: Who This Is For →](who-this-is-for.md)
EOF

cat > docs/getting-started/who-this-is-for.md <<EOF
# Who This Is For

Content coming soon...

[Next: Setup Guide →](setup.md)
EOF

cat > docs/getting-started/setup.md <<EOF
# Setup Guide

Content coming soon...

[Next: What is Data? →](../fundamentals/what-is-data.md)
EOF

# Fundamentals
cat > docs/fundamentals/index.md <<EOF
# Fundamentals

Learn the basics of data in tech.

- [What is Data?](what-is-data.md)
- [The Data Lifecycle](data-lifecycle.md)
- [Modern Data Stack](modern-data-stack.md)
- [The Project](the-project.md)
EOF

cat > docs/fundamentals/data-lifecycle.md <<EOF
# The Data Lifecycle

Content coming soon...
EOF

cat > docs/fundamentals/modern-data-stack.md <<EOF
# Modern Data Stack

Content coming soon...
EOF

cat > docs/fundamentals/the-project.md <<EOF
# The Project: BookStore Analytics

Content coming soon...
EOF

# Roles
cat > docs/roles/index.md <<EOF
# The 20 Data Roles

Explore all 20 data career paths:

## Infrastructure & Platform
- [Backend Engineer](infrastructure/backend-engineer.md)
- [Database Administrator](infrastructure/database-administrator.md)
- [Platform Engineer](infrastructure/platform-engineer.md)
- [DevOps Engineer](infrastructure/devops-engineer.md)

## Data Pipeline
- [Data Engineer](data-pipeline/data-engineer.md)
- [Analytics Engineer](data-pipeline/analytics-engineer.md)
- [DataOps Engineer](data-pipeline/dataops-engineer.md)

## Analysis & Intelligence
- [Data Analyst](analysis/data-analyst.md)
- [BI Engineer](analysis/bi-engineer.md)
- [Data Scientist](analysis/data-scientist.md)
- [ML Scientist](analysis/ml-scientist.md)

## Production
- [ML Engineer](production/ml-engineer.md)
- [AI Engineer](production/ai-engineer.md)
- [MLOps Engineer](production/mlops-engineer.md)

## Support & Quality
- [QA Engineer](support/qa-engineer.md)
- [Data Governance](support/data-governance.md)
- [Frontend Engineer](support/frontend-engineer.md)

## Strategic
- [Data Architect](strategic/data-architect.md)
- [Data Product Manager](strategic/data-product-manager.md)
- [Engineering Manager](strategic/engineering-manager.md)
EOF

# Create placeholder role category index files
for category in infrastructure data-pipeline analysis production support strategic; do
    cat > docs/roles/$category/index.md <<EOF
# $(echo $category | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g') Roles

Content coming soon...
EOF
done

# Create placeholder role files (just a few examples)
cat > docs/roles/infrastructure/backend-engineer.md <<EOF
# Backend Engineer

Content coming soon...
EOF

cat > docs/roles/data-pipeline/analytics-engineer.md <<EOF
# Analytics Engineer

Content coming soon...
EOF

# Hands-On
cat > docs/hands-on/index.md <<EOF
# Hands-On Projects

Build real data projects:

1. [Environment Setup](01-setup-environment.md)
2. [Backend API](02-backend-api.md)
3. [Database Setup](03-database-setup.md)
4. [Data Pipeline](04-data-pipeline.md)
5. [dbt Transformation](05-dbt-transformation.md)
6. [SQL Analysis](06-sql-analysis.md)
7. [Dashboard](07-dashboard.md)
8. [ML Models](08-ml-models.md)
9. [Deployment](09-deployment.md)
10. [Monitoring](10-monitoring.md)
EOF

cat > docs/hands-on/project-overview.md <<EOF
# Project Overview: BookStore Analytics

Content coming soon...
EOF

for i in {01..10}; do
    touch docs/hands-on/$i-*.md
done

# Scenarios
cat > docs/scenarios/index.md <<EOF
# Real-World Scenarios

See how data roles collaborate:

- [End-to-End Project](end-to-end-project.md)
- [Day in the Life](day-in-the-life.md)
- [Team Collaboration](collaboration.md)
EOF

cat > docs/scenarios/end-to-end-project.md <<EOF
# End-to-End Project

Content coming soon...
EOF

cat > docs/scenarios/day-in-the-life.md <<EOF
# A Day in the Life

Content coming soon...
EOF

cat > docs/scenarios/collaboration.md <<EOF
# Team Collaboration

Content coming soon...
EOF

# Career Paths
cat > docs/career-paths/index.md <<EOF
# Career Paths

Find your path in data:

- [Self-Assessment](self-assessment.md)
- [Learning Roadmaps](learning-roadmaps.md)
- [Job Search Strategy](job-search.md)
- [Resources](resources.md)
EOF

cat > docs/career-paths/self-assessment.md <<EOF
# Self-Assessment

Content coming soon...
EOF

cat > docs/career-paths/learning-roadmaps.md <<EOF
# Learning Roadmaps

Content coming soon...
EOF

cat > docs/career-paths/job-search.md <<EOF
# Job Search Strategy

Content coming soon...
EOF

cat > docs/career-paths/resources.md <<EOF
# Resources

Content coming soon...
EOF

# Reference
cat > docs/reference/index.md <<EOF
# Reference

Quick reference materials:

- [Glossary](glossary.md)
- [Tools Guide](tools-guide.md)
- [Skills Matrix](skills-matrix.md)
- [FAQ](faq.md)
- [Tags](tags.md)
EOF

cat > docs/reference/glossary.md <<EOF
# Glossary

Content coming soon...
EOF

cat > docs/reference/tools-guide.md <<EOF
# Tools Guide

Content coming soon...
EOF

cat > docs/reference/skills-matrix.md <<EOF
# Skills Matrix

Content coming soon...
EOF

cat > docs/reference/faq.md <<EOF
# Frequently Asked Questions

Content coming soon...
EOF

cat > docs/reference/tags.md <<EOF
# Tags

Browse content by tags.
EOF

# Abbreviations file
mkdir -p docs/includes
cat > docs/includes/abbreviations.md <<EOF
*[API]: Application Programming Interface
*[AWS]: Amazon Web Services
*[BI]: Business Intelligence
*[CSV]: Comma-Separated Values
*[DAG]: Directed Acyclic Graph
*[dbt]: data build tool
*[ETL]: Extract, Transform, Load
*[ELT]: Extract, Load, Transform
*[GDPR]: General Data Protection Regulation
*[JSON]: JavaScript Object Notation
*[ML]: Machine Learning
*[OLAP]: Online Analytical Processing
*[OLTP]: Online Transaction Processing
*[SQL]: Structured Query Language
*[YAML]: YAML Ain't Markup Language
EOF

echo "✓ Placeholder files created"
echo ""

# Create custom CSS
echo "🎨 Creating custom stylesheets..."

cat > docs/stylesheets/extra.css <<EOF
/* Custom styles for Data Roles Guide */

:root {
  --md-primary-fg-color: #673ab7;
  --md-accent-fg-color: #9c27b0;
}

/* Card grid styling */
.grid.cards {
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
}

/* Role badges */
.role-badge {
  display: inline-block;
  padding: 0.25rem 0.75rem;
  border-radius: 1rem;
  font-size: 0.875rem;
  font-weight: 500;
  margin: 0.25rem;
}

.role-badge.infrastructure { background-color: #e3f2fd; color: #1565c0; }
.role-badge.pipeline { background-color: #fff9c4; color: #f57f17; }
.role-badge.analysis { background-color: #f3e5f5; color: #6a1b9a; }
.role-badge.production { background-color: #e8f5e9; color: #2e7d32; }
.role-badge.support { background-color: #fff3e0; color: #e65100; }
.role-badge.strategic { background-color: #fce4ec; color: #c2185b; }

/* Mermaid diagrams */
.mermaid {
  text-align: center;
  margin: 2rem 0;
}
EOF

cat > docs/javascripts/extra.js <<EOF
// Custom JavaScript for Data Roles Guide

// Add any custom interactive features here
console.log('Data Roles Guide loaded');

// Example: Track page views (replace with your analytics)
document.addEventListener('DOMContentLoaded', function() {
  // Your custom JS here
});
EOF

cat > docs/javascripts/tablesort.js <<EOF
// Initialize table sorting
document.addEventListener('DOMContentLoaded', function() {
  var tables = document.querySelectorAll("article table:not([class])")
  tables.forEach(function(table) {
    new Tablesort(table)
  })
});
EOF

echo "✓ Custom styles created"
echo ""

# Create LICENSE
echo "📄 Creating LICENSE..."

cat > LICENSE <<EOF
MIT License

Copyright (c) 2024 Gemma Down

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

echo "✓ LICENSE created"
echo ""

# Create .gitignore
echo "🚫 Creating .gitignore..."

cat > .gitignore <<EOF
# MkDocs
site/
.cache/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Environment
.env
.env.local

# Logs
*.log

# OS
Thumbs.db
EOF

echo "✓ .gitignore created"
echo ""

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. pip install -r requirements.txt"
echo "  2. mkdocs serve"
echo "  3. Visit http://localhost:8000"
echo ""
echo "Start editing content in the docs/ directory!"
echo ""
echo "Happy building! 🚀"