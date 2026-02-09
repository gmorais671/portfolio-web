# 🎨 Portfolio Web - Frontend

Modern and minimalist personal portfolio frontend built with Flutter Web, featuring a dark theme with red accents, smooth scrolling, and full API integration.

## 🛠 Technologies

- **Flutter Web**: Multi-platform UI framework.
- **Dart**: Programming language.
- **Google Fonts**: Inter & Poppins typography.
- **HTTP**: Asynchronous communication with the FastAPI backend.
- **Shared Preferences**: Local session persistence for authentication tokens.

## ✨ Features

- **Single Page Application (SPA)**: Smooth navigation between sections.
- **Responsive Design**: Optimized for different screen sizes.
- **Lead Capture System**: Integrated form for user registration and login.
- **Automated CV Request**: One-click button to receive the resume via email (authenticated).
- **Corinthians-Inspired Theme**: Minimalist dark mode with a bold red accent color.

---

## ▶️ Prerequisites

- **Flutter SDK**: 3.12.0 or higher.
- **Google Chrome**: Or any modern web browser.
- **Backend API**: Ensure the `portfolio-api` is running.

---

## 🧭 How to run locally

1. **Clone the repository:**
   ```bash
   git clone https://github.com/gmorais671/portfolio-web.git
   cd portfolio-web

2. **Install dependencies:**
   ```bash
   flutter pub get
   
3. **Check for connected devices:**
   ```bash
   flutter devices

4. **Run the app:**
   ```bash
   flutter run

5. **Build the APK:**
   ```bash
   flutter build apk --release
