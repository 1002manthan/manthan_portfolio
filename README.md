<div align="center">

<br/>

# ✦ &nbsp; MANTHAN SUTHAR &nbsp; ✦
### — Personal Portfolio Website —

<br/>

[![Live Demo](https://img.shields.io/badge/🌐%20LIVE%20DEMO-Visit%20Portfolio-00ff88?style=for-the-badge&labelColor=0d0d0d)](https://1002manthan.github.io/manthan_portfolio/)
&nbsp;
[![GitHub Repo](https://img.shields.io/badge/📁%20SOURCE-View%20Code-4f8ef7?style=for-the-badge&labelColor=0d0d0d)](https://github.com/1002manthan/manthan_portfolio)

<br/>

![Status](https://img.shields.io/badge/STATUS-LIVE%20%26%20RUNNING-00ff88?style=flat-square&labelColor=111)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Flutter Web](https://img.shields.io/badge/Flutter%20Web-Enabled-54C5F8?style=flat-square&logo=flutter&logoColor=white)
![Hosted on GitHub Pages](https://img.shields.io/badge/Hosted%20on-GitHub%20Pages-181717?style=flat-square&logo=github)

<br/><br/>

---

</div>

## 🧠 About This Project

This is my **personal portfolio website**, built entirely with **Flutter Web** — because why settle for plain HTML/CSS when you can bring the full power of Flutter to the browser? 🚀

A pixel-perfect, smooth, and responsive portfolio that showcases my skills, projects, and journey as a developer — all compiled from a single Dart codebase and deployed live on GitHub Pages.

> *Built with Flutter. Runs everywhere. Looks stunning.*

<br/>

---

## ✨ Features

- 🦋 **Built with Flutter Web** — a real app experience in the browser
- 🎨 **Smooth animations** — Flutter's powerful animation engine at work
- ⚡ **Fast & performant** — optimized Flutter web build
- 🌐 **Deployed on GitHub Pages** — free, fast, always online
- 🎯 **Single codebase** — could run on Android, iOS, Web & Desktop

<br/>

---

## 📸 Preview

<div align="center">

> 🔗 **[Click here to view the live portfolio →](https://1002manthan.github.io/manthan_portfolio/)**

</div>

<br/>

---

## 🗂️ Project Structure

```
manthan_portfolio/
│
├── lib/
│   ├── main.dart               # App entry point
│   ├── screens/                # Individual page screens (Home, About, Projects, Contact)
│   ├── widgets/                # Reusable UI components
│   └── utils/                  # Constants, theme, helpers
│
├── web/
│   ├── index.html              # Flutter web shell
│   ├── manifest.json           # PWA manifest
│   └── favicon.png             # Site favicon
│
├── assets/
│   ├── images/                 # Profile photo, project screenshots
│   └── fonts/                  # Custom fonts (if any)
│
├── pubspec.yaml                # Flutter dependencies & assets config
└── README.md                   # You're reading this right now 😄
```

> ⚠️ Update this structure to match your actual file layout!

<br/>

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| 🦋 Framework | Flutter (Web) |
| 💙 Language | Dart |
| 🎨 UI | Flutter Widgets & Custom Painters |
| 🚀 Deployment | GitHub Pages |
| 🔧 Build | `flutter build web` |

<br/>

---

## 🚀 Getting Started

Want to run this locally or contribute? Here's how:

### Prerequisites

Make sure you have Flutter installed with web support enabled:

```bash
flutter --version        # Should be Flutter 3.x+
flutter config --enable-web
flutter doctor           # All green? You're good to go!
```

### Clone & Run

```bash
# Clone the repository
git clone https://github.com/1002manthan/manthan_portfolio.git
cd manthan_portfolio

# Get dependencies
flutter pub get

# Run on web (Chrome)
flutter run -d chrome
```

### Build for Production

```bash
flutter build web --release
```
The output will be in the `build/web/` folder — ready to deploy!

<br/>

---

## 🌍 Deployment on GitHub Pages

This portfolio is deployed using **GitHub Pages** from the `build/web/` output.

### Steps to deploy:

**Option 1 — Manual deploy**
```bash
# Build the web app
flutter build web --release --base-href "/manthan_portfolio/"

# Copy build/web contents into your gh-pages branch or docs/ folder
# Then push to GitHub and enable Pages in repo settings
```

**Option 2 — GitHub Actions (Auto Deploy)**

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy Flutter Web to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'

      - run: flutter pub get
      - run: flutter build web --release --base-href "/manthan_portfolio/"

      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

> 💡 With this workflow, every push to `main` auto-deploys your portfolio!

<br/>

---

## 📦 Dependencies

```yaml
# pubspec.yaml — key packages (update as per your actual deps)
dependencies:
  flutter:
    sdk: flutter
  url_launcher: ^6.0.0       # Open links
  google_fonts: ^6.0.0       # Beautiful fonts
  animate_do: ^3.0.0         # Smooth animations
  flutter_svg: ^2.0.0        # SVG support
```

> ⚠️ Replace with your actual `pubspec.yaml` dependencies!

<br/>

---

## 📬 Connect With Me

<div align="center">

I'm always open to exciting opportunities, collaborations, or just a good conversation!

<br/>

[![GitHub](https://img.shields.io/badge/GitHub-1002manthan-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/1002manthan)
[![Portfolio](https://img.shields.io/badge/Portfolio-Live%20Site-00ff88?style=for-the-badge&logo=googlechrome&logoColor=white)](https://1002manthan.github.io/manthan_portfolio/)

<br/>

> 💡 *Add your LinkedIn, email, or Twitter badge here!*

</div>

<br/>

---

## 📄 License

```
MIT License — feel free to use this as inspiration.
Just don't copy it and call it your own. Give credit where it's due. 🤝
```

<br/>

---

<div align="center">

Built with **💙 Flutter**, **☕ coffee**, and a whole lot of **❤️**

⭐ **If you like what you see, drop a star on the repo!** ⭐

<br/>

*© 2025 Manthan Suthar. All rights reserved.*

</div>
