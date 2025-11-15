# Understanding Data Roles in Tech

A hands-on guide to exploring 20 data career paths through practical projects.

🌐 **Live Site:** [data-roles.sproodlebuzz.com](https://data-roles.sproodlebuzz.com)

---

## About This Guide

This is an interactive, open-source guide to help people understand different data roles by actually **doing** the work. Instead of just reading about Data Engineers, Data Scientists, and ML Engineers—you'll build real projects that show you what each role does day-to-day.

### What You'll Build

A complete e-commerce analytics system called "BookStore Analytics":

- 📊 Data pipelines in Apache Airflow
- 🔄 Data transformations with dbt
- 📈 SQL analysis and insights
- 📉 Interactive dashboards in Looker Studio
- 🤖 ML models for recommendations
- 🚀 Production ML APIs
- 📡 Monitoring and quality systems

### The 20 Roles Covered

**Infrastructure:** Backend Engineer, Database Admin, Platform Engineer, DevOps Engineer

**Data Pipeline:** Data Engineer, Analytics Engineer, DataOps Engineer

**Analysis:** Data Analyst, BI Engineer, Data Scientist, ML Scientist

**Production:** ML Engineer, AI Engineer, MLOps Engineer

**Support:** QA Engineer, Data Governance, Frontend Engineer

**Strategic:** Data Architect, Data Product Manager, Engineering Manager

---

## Getting Started

### Prerequisites

- Python 3.8+
- Git
- A code editor (VS Code recommended)
- Curiosity about data!

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/glsdown/data-roles-guide.git
   cd data-roles-guide
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Serve locally**
   ```bash
   mkdocs serve
   ```
   
   Visit `http://localhost:8000` in your browser

4. **Build static site**
   ```bash
   mkdocs build
   ```
   
   Output will be in the `site/` directory

---

## Project Structure

```
data-roles-guide/
├── docs/                      # All content
│   ├── index.md              # Homepage
│   ├── getting-started/      # Introduction and setup
│   ├── fundamentals/         # Data concepts
│   ├── roles/                # 20 role deep dives
│   │   ├── infrastructure/
│   │   ├── data-pipeline/
│   │   ├── analysis/
│   │   ├── production/
│   │   ├── support/
│   │   └── strategic/
│   ├── hands-on/             # Practical projects
│   ├── scenarios/            # Real-world examples
│   ├── career-paths/         # Self-assessment and roadmaps
│   └── reference/            # Glossary, tools, FAQ
├── mkdocs.yml                # Site configuration
├── requirements.txt          # Python dependencies
└── README.md                 # This file
```

---

## Contributing

Contributions are welcome! Here's how you can help:

### Report Issues

Found a typo? Broken link? Outdated info?

[Open an issue](https://github.com/glsdown/data-roles-guide/issues/new)

### Suggest Improvements

Have ideas for new content or better explanations?

[Start a discussion](https://github.com/glsdown/data-roles-guide/discussions/new)

### Submit Changes

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-addition`)
3. Make your changes
4. Test locally (`mkdocs serve`)
5. Commit (`git commit -m 'Add amazing content'`)
6. Push (`git push origin feature/amazing-addition`)
7. Open a Pull Request

### Content Guidelines

- **Be practical:** Show code examples, not just theory
- **Be accurate:** Cite sources for claims
- **Be inclusive:** Use gender-neutral language
- **Be clear:** Explain technical terms
- **Be concise:** Respect readers' time

---

## Deployment

### GitHub Pages (Current)

Automatically deployed via GitHub Actions when you push to `main`.

The site is available at: `https://glsdown.github.io/data-roles-guide`

### Custom Domain (AWS S3 + CloudFront)

See [DEPLOYMENT.md](DEPLOYMENT.md) for instructions on deploying to `data-roles.sproodlebuzz.com` using AWS.

---

## Tech Stack

- **[MkDocs](https://www.mkdocs.org/)** - Static site generator
- **[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)** - Beautiful theme
- **[GitHub Pages](https://pages.github.com/)** - Free hosting
- **[GitHub Actions](https://github.com/features/actions)** - Auto-deployment

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### What This Means

- ✅ Use this content for learning
- ✅ Fork and modify for your own projects
- ✅ Share with others
- ✅ Use in commercial training (with attribution)

Please provide attribution by linking back to this repository.

---

## About the Author

**Gemma Down** has 12 years of experience working across the data stack:

- Data Analyst
- Data Scientist
- Analytics Engineer
- Data Engineer
- Full Stack Engineer

She has also recruited for data roles, giving her unique insight into what these positions really require.

- GitHub: [@glsdown](https://github.com/glsdown)
- LinkedIn: [Gemma Down](https://linkedin.com/in/gemmasayers)

---

## Acknowledgments

Thanks to:

- The data community for feedback and suggestions
- Open source contributors
- Everyone who's shared their experiences in data roles

---

## Support This Project

If you find this guide helpful:

- ⭐ **Star the repository** to help others discover it
- 🐛 **Report issues** to improve content
- 💬 **Share feedback** in discussions
- 🔗 **Share with others** who might benefit
- ☕ **[Buy me a coffee](https://ko-fi.com/yourusername)** (optional!)

---

## Related Projects

- [Sample Data Repository](https://github.com/glsdown/bookstore-analytics-data) - Datasets used in hands-on projects
- [Code Examples](https://github.com/glsdown/bookstore-analytics-code) - Full working code for all exercises

---

## Questions?

- 💬 [Open a discussion](https://github.com/glsdown/data-roles-guide/discussions)
- 🐛 [Report an issue](https://github.com/glsdown/data-roles-guide/issues)
- 📧 [Email me](mailto:your.email@example.com)

---

**Built with ❤️ by Gemma Down**

[Visit the Live Site →](https://data-roles.sproodlebuzz.com)