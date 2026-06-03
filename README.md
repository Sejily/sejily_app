# 🩺 Sejily – AI & Web3 Medical Records App

Sejily is a mobile-first platform that gives patients **full control over their medical records**.  
It combines **AI** for structuring messy health documents with **Web3 decentralized storage**, ensuring privacy, ownership, and accessibility across hospitals and borders.

<img width="1280" height="722" alt="image_2026-06-03_07-01-43" src="https://github.com/user-attachments/assets/491813b0-9a3c-47e7-a8b4-d1d0d2468514" />

---

## ✨ Features

- 🤖 **AI-Powered Data Processing**  
  Extracts and organizes unstructured medical files (PDFs, scans, lab results) into clear, FHIR-compliant health profiles.

- 🔐 **Decentralized & Secure Storage**  
  Records are encrypted and stored on IPFS/Filecoin, with access managed through patient-owned private keys.

- 🧑‍⚕️ **Patient-Centered Access**  
  Patients decide who can see their data, with instant permission granting or revoking.

- 🌍 **Interoperability**  
  Supports sharing across hospitals and borders, aligned with international healthcare standards.

---
## 📱 Application Showcase

### 1️⃣ Secure Multi-Role Authentication

<p align="center">
  <img alt="Multi-User Auth" src="https://github.com/user-attachments/assets/d23f7816-7cdb-43c4-9095-f8c58a538d46" width="900">
</p>

Sejily provides a secure onboarding experience for both patients and healthcare providers. Users can create accounts, select their role, verify their identity through OTP verification, and recover access using password reset workflows.

#### Features
- Login & Registration
- Role Selection
- OTP Verification
- Password Reset
- Secure Authentication Flow

---

### 2️⃣ Comprehensive Patient Registration

<p align="center">
  <img alt="Patient Registeration" src="https://github.com/user-attachments/assets/8ff24a95-2ebd-4bba-8e1c-fdc4dc97ee16" width="900">
</p>

Patients complete a detailed profile during registration to ensure accurate identification and emergency preparedness. The platform securely stores personal information, identity verification documents, and emergency contact details.

#### Information Collected
- Address
- Date of Birth
- Phone Number
- Gender
- Nationality
- National ID
- National ID Image
- Personal Photo
- Emergency Contact Information
- Relationship Mapping

---

### 3️⃣ Professional Doctor Registration

<p align="center">
  <img alt="Doctor Registeration" src="https://github.com/user-attachments/assets/37f484e9-96a8-4bf7-8ec0-b398f29ff17f" width="900">
</p>

Healthcare providers undergo an enhanced verification process to establish trust and authenticity within the platform. Professional and institutional information is collected to validate medical credentials.

#### Information Collected
- Address
- Date of Birth
- Phone Number
- Gender
- Nationality
- National ID
- National ID Image
- Personal Photo
- Hospital Name
- City
- Medical Specialization
- Medical Assurance Number
- Medical Syndicate Card

---

### 4️⃣ AI-Powered OCR & Medical Record Summarization

<p align="center">
  <img alt="AI OCR Summarization" src="https://github.com/user-attachments/assets/024b2f4c-e6c8-4678-affe-9cc23f93e13e" width="900">
</p>

Patients can upload prescriptions, laboratory reports, radiology scans, and medical examinations. Sejily leverages Artificial Intelligence to extract, analyze, clean, and structure medical information automatically.

#### AI Capabilities
- OCR Text Extraction
- Medical Document Analysis
- NLP-Based Processing
- Automated Summarization
- Data Cleaning & Structuring
- Medical Information Classification

---

### 5️⃣ Decentralized Medical Records

<p align="center">
  <img alt="Decentralized Medical Records" src="https://github.com/user-attachments/assets/c3f3ad9b-9c3a-4e72-969b-ad5ab38160f6"  width="900">
</p>

Medical documents are transformed into structured and searchable digital health records that can be accessed by patients and authorized healthcare providers. This enables better continuity of care and more efficient medical decision-making.

#### Features
- Organized Health Records
- Doctor & Patient Access
- Structured Medical History
- Searchable Medical Information
- Long-Term Health Tracking

---

## 🧠 About the AI Model

The AI model in Sejily:
- Uses **OCR** to extract information from uploaded reports.
- Applies **summarization and NLP** to clean and structure data.
- Generates a unified, searchable medical profile aligned with global healthcare standards.
- Powers **semantic search** to quickly retrieve relevant records.

---

## 🧠 How It Works

1. 📤 Patient uploads health documents via the app.
2. 🧠 AI extracts, cleans, and structures the data into a unified medical profile.
3. 🔐 Data is stored securely on decentralized networks.
4. 🔑 Patient manages access permissions using private keys.
5. 🏥 Doctors can retrieve standardized records only when authorized.

---

## 👩‍⚕️ Target Users

- Patients needing portable, organized health records.
- Doctors & hospitals requiring fast access to accurate data.
- Travelers or chronic patients with multiple healthcare providers.
- Insurance companies seeking secure interoperability.

---

## ⚙️ Tech Stack & Architecture

| Area | Description |
|---|---|
| 🧱 **State Management** | **Riverpod** for predictable and testable UI state across authentication, profile, file upload, and AI flows |
| 🔄 **Architecture** | **Feature-first layered architecture** with clear separation between presentation, data, and shared core modules |
| 🔗 **Networking & API Layer** | **Dio** with **Retrofit** for typed HTTP clients, request interception, and structured API integration |
| ⚠️ **Error Handling** | Centralized **API result and error handling** using a `Result`-style approach to keep success and failure flows explicit |
| 🔐 **Secure Storage** | **flutter_secure_storage** for sensitive values such as tokens and authenticated session data |
| 🗃️ **Local Data Storage** | **Hive** and **Hive Flutter** for lightweight persistence of user preferences, onboarding state, and cached app data |
| 🧭 **Routing** | **go_router** for declarative navigation and route organization |
| 🌍 **Localization** | Built-in Flutter localization support for a bilingual experience with **English** and **Arabic** |
| 🧩 **Code Generation** | **Freezed**, **json_serializable**, and **build_runner** for immutable models and type-safe serialization |
| 🎨 **UI Toolkit** | Custom reusable widgets, SVG support, skeleton loaders, and asset-driven UI components |

### Architecture Overview

Sejily is organized around reusable features and shared core utilities:

- **Presentation layer** handles screens, widgets, and state notifiers.
- **Data layer** manages API services, DTOs/models, and repository implementations.
- **Core layer** contains shared networking, storage, routing, constants, helpers, and UI primitives.

This structure keeps the codebase scalable as new healthcare, AI, and profile features are added.

## 📂 Folder Structure
<pre>
.
└── 📁lib/
      ├── 🔧core/
      │   ├── constants/
      │   ├── enums/
      │   ├── helpers/
      │   ├── newtorking/
      │   ├── routes/
      │   ├── services/
      │   ├── utils/
      │   └── widgets/
      ├── 📦features/
      │   ├── ai/
      │   │   ├── data/
      │   │   │   ├── models/
      │   │   │   └── repository/
      │   │   └── presentation/
      │   │       ├── manager/
      │   │       └── pages/
      │   ├── authentication/
      │   │   ├── data/
      │   │   │   ├── models/
      │   │   │   └── repository/
      │   │   └── presentation/
      │   │       ├── manager/
      │   │       │   └── providers/
      │   │       ├── view/
      │   │       └── widgets/
      │   ├── home_user/
      │   │   ├── emergency/
      │   │   │   ├── data/
      │   │   │   │   └── models/
      │   │   │   └── pressntation/
      │   │   │       ├── manager/
      │   │   │       │   └── providers/
      │   │   │       └── view/
      │   │   ├── file_upload/
      │   │   │   ├── data/
      │   │   │   │   └── models/
      │   │   │   └── presentation/
      │   │   │       ├── manager/
      │   │   │       │   └── providers/
      │   │   │       ├── view/
      │   │   │       └── widgets/
      │   │   └── profile/
      │   │       ├── data/
      │   │       │   └── models/
      │   │       └── presention/
      │   │           ├── manager/
      │   │           │   └── providers/
      │   │           ├── navigation/
      │   │           ├── view/
      │   │           └── widgets/
      │   └── onboarding/
      │       └── presentation/
      └── 📄 main.dart
</pre>
