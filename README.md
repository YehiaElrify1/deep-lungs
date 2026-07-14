<div align="center">

# 🫁 Deep Lungs AI

### AI-Powered Pneumonia Detection from Chest X-Rays

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.x-009688?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.x-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)](https://tensorflow.org)

<p align="center">
  <strong>Deep Lungs</strong> is a full-stack medical AI application that detects <strong>Pneumonia</strong> from chest X-ray images with high precision using a deep learning model trained on the Xception architecture, exposed via a FastAPI backend and consumed by a cross-platform Flutter mobile application.
</p>

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [ML Model](#-ml-model)
- [Backend API](#-backend-api)
- [Getting Started](#-getting-started)
- [API Reference](#-api-reference)

---

## 🔍 Overview

**Deep Lungs** bridges the gap between advanced medical AI and real-world clinical accessibility. A doctor or technician can:

1. Open the mobile app
2. Capture or upload a chest X-ray image
3. Receive an instant AI-powered diagnosis — **PNEUMONIA** or **NORMAL** — along with a confidence percentage

The system is designed with a clean client-server architecture where the heavy ML inference runs entirely on the server, keeping the mobile app lightweight and fast.

---

## 🏗 Architecture

```
┌─────────────────────────────────────────────────────┐
│                   Flutter Mobile App                 │
│  VideoSplash → Onboarding → Detection Screen         │
│         ↕  HTTP Multipart POST /predict              │
├─────────────────────────────────────────────────────┤
│             ngrok Secure Tunnel                      │
│   (Public HTTPS endpoint → localhost:8000)           │
├─────────────────────────────────────────────────────┤
│           FastAPI Python Backend (uvicorn)           │
│     Receives image → Preprocesses → Inference        │
│         → Returns { prediction, confidence }         │
├─────────────────────────────────────────────────────┤
│       TensorFlow / Keras Deep Learning Model         │
│     Xception Architecture (299×299 input)            │
│     Binary Classification: PNEUMONIA / NORMAL        │
└─────────────────────────────────────────────────────┘
```

---

## ✨ Features

| Feature | Description |
|---|---|
| 🎬 **Video Splash Screen** | Cinematic intro video plays on launch before navigating to onboarding |
| 📖 **3-Page Onboarding** | Animated page-view explaining the app with animated dot indicators |
| 📷 **Dual Image Input** | Pick from gallery or capture directly using the device camera |
| 🧠 **AI Inference** | Xception-based CNN achieves ~96% accuracy on the chest X-ray dataset |
| 📊 **Confidence Score** | Every prediction includes a calibrated percentage confidence |
| 📋 **Result Bottom Sheet** | Results are presented in a polished modal with color-coded indicators |
| 📳 **Haptic Feedback** | Native device vibration on result delivery for tactile confirmation |
| 🎨 **Medical Design System** | Deep navy `#1E3A8A` + clinical blue palette with Google Poppins font |

---

## 🛠 Tech Stack

### Mobile Application (Flutter)

| Package | Version | Purpose |
|---|---|---|
| `flutter` | `3.x` | Cross-platform UI framework |
| `http` | `^1.6.0` | HTTP client for API communication |
| `image_picker` | `^1.2.2` | Camera & gallery image selection |
| `video_player` | `^2.10.1` | Splash screen video playback |
| `google_fonts` | `^6.2.1` | Poppins typography |
| `vibration` | `^3.1.8` | Native haptic feedback |

### Backend (Python)

| Package | Purpose |
|---|---|
| `FastAPI` | High-performance REST API framework |
| `TensorFlow / Keras` | Deep learning model loading & inference |
| `Pillow` | Image preprocessing |
| `uvicorn` | ASGI server |
| `ngrok` | Secure public tunnel for local dev server |

### ML Model

| Property | Value |
|---|---|
| Architecture | **Xception** (Transfer Learning) |
| Input Size | 299 × 299 × 3 (RGB) |
| Task | Binary Classification |
| Classes | `NORMAL` / `PNEUMONIA` |
| Accuracy | ~**96%** on test set |
| Model Formats | `.h5` & `.keras` |
| Dataset | Chest X-Ray (Pneumonia) — [Kaggle](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia) |

---

## 📁 Project Structure

```
deep_lungs/
├── lib/                              # Flutter application source
│   ├── main.dart                     # App entry point
│   ├── my_app.dart                   # MaterialApp setup & theme injection
│   └── app/
│       ├── core/
│       │   ├── constants/
│       │   │   └── api_constants.dart   # Base URL & endpoint definitions
│       │   ├── services/
│       │   │   └── api_service.dart     # Multipart HTTP upload service
│       │   └── theme/
│       │       └── app_theme.dart       # Global ThemeData (colors, fonts, buttons)
│       └── features/
│           ├── splash_screen/
│           │   └── screens/
│           │       └── video_splash_screen.dart  # Full-screen video intro
│           ├── onboarding/
│           │   ├── screens/
│           │   │   └── onboarding_screen.dart    # 3-step animated page view
│           │   └── widgets/
│           │       ├── header_widget.dart        # Screen header
│           │       ├── image_box_widget.dart     # X-ray preview area
│           │       ├── action_buttons_widget.dart # Camera / Gallery buttons
│           │       └── result_panel_widget.dart  # Diagnosis result card
│           └── detection/
│               └── screens/
│                   └── detection_screen.dart     # Main AI detection screen
│
├── pneumonia_model/                  # Python ML backend
│   ├── api.py                        # FastAPI application & /predict endpoint
│   ├── requirements.txt              # Python dependencies
│   ├── api_conn.txt                  # Server startup instructions
│   ├── X-Ray_Pneumonia_classification.h5     # Trained model (HDF5 format)
│   ├── X-Ray_Pneumonia_classification.keras  # Trained model (Keras format)
│   └── x-ray-pneumonia-96.ipynb     # Training notebook (96% accuracy)
│
├── assets/
│   ├── logo.png                      # App icon & adaptive icon source
│   └── splash_video.mp4              # Launch video for splash screen
│
├── pubspec.yaml                      # Flutter dependencies & asset config
└── analysis_options.yaml             # Dart linting rules
```

---

## 🧠 ML Model

The model is based on the **Xception** architecture with transfer learning, trained on the [Chest X-Ray (Pneumonia) dataset](https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia).

**Preprocessing Pipeline (per inference request):**

1. Convert image to **RGB** (handles grayscale X-rays)
2. Resize to **299 × 299** pixels (Xception's required input size)
3. Apply `xception.preprocess_input` (scales pixels to `[-1, 1]`)
4. Run inference — output is a single sigmoid unit:
   - `output > 0.5` → **PNEUMONIA**
   - `output ≤ 0.5` → **NORMAL**
5. Compute confidence from the raw sigmoid value

The training notebook `x-ray-pneumonia-96.ipynb` documents the full training process including data augmentation, callbacks, and evaluation metrics.

---

## 🌐 Backend API

The backend is a **FastAPI** application served with `uvicorn` and exposed to the internet via an **ngrok** tunnel.

### Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/` | Health check — returns a welcome message |
| `POST` | `/predict` | Upload a chest X-ray image for inference |

### `POST /predict`

**Request:** `multipart/form-data`

| Field | Type | Description |
|---|---|---|
| `file` | `UploadFile` | The chest X-ray image (JPEG / PNG) |

**Response (Success):**
```json
{
  "status": "success",
  "filename": "xray.jpg",
  "prediction": "PNEUMONIA",
  "confidence": "87.34%"
}
```

**Response (Error):**
```json
{
  "status": "error",
  "message": "..."
}
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.x`
- [Python 3.x](https://www.python.org/downloads/) with `conda` or `pip`
- [ngrok](https://ngrok.com/download) (free account for a static domain)

---

### 1. Run the Backend

#### a. Set up the Python environment

```bash
cd pneumonia_model

# Using conda (recommended)
conda create -n pneumonia_env python=3.10
conda activate pneumonia_env
pip install fastapi uvicorn pillow tensorflow numpy
```

#### b. Start the FastAPI server

```bash
# Inside pneumonia_model/ directory
uvicorn api:app --reload
```

The server starts at `http://localhost:8000`.

#### c. Expose publicly with ngrok

In a **separate terminal**, run:

```bash
ngrok http --domain=YOUR_NGROK_DOMAIN 8000
```

> Replace `YOUR_NGROK_DOMAIN` with your own free static ngrok domain.

---

### 2. Run the Flutter App

#### a. Update the API URL

Open `lib/app/core/constants/api_constants.dart` and update the base URL:

```dart
class ApiConstants {
  static const String baseUrl = 'https://YOUR_NGROK_DOMAIN';
  static const String predictEndpoint = '$baseUrl/predict';
}
```

#### b. Install dependencies & run

```bash
# From the project root
flutter pub get
flutter run
```

---

## 📖 API Reference

Once the server is running, explore the full interactive API docs at:

```
http://localhost:8000/docs    # Swagger UI
http://localhost:8000/redoc  # ReDoc
```

---

## 🙌 Credits & Acknowledgements

A huge shoutout to the person who made the AI core of this project possible:

| Contributor | Contribution |
|---|---|
| [**Youcef Bahgat**](https://github.com/Youcef-bahgat) | 🧠 Built and trained the Xception-based Pneumonia classification model, achieving ~96% accuracy on the chest X-ray dataset. |

> The deep learning model powering this entire application — `X-Ray_Pneumonia_classification.keras` — was designed, trained, and delivered by **[@Youcef-bahgat](https://github.com/Youcef-bahgat)**. Without his work on the ML side, this app would not exist. Go check out his GitHub! 🚀

---

<div align="center">

**Built with ❤️ using Flutter & TensorFlow**

> ⚠️ **Disclaimer:** This application is intended for **educational and research purposes only**. It is **not** a certified medical device and should not be used as a substitute for professional medical diagnosis.

</div>
