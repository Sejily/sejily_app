# 🩺 Sejily – AI & Web3 Medical Records App

Sejily is a mobile-first platform that gives patients **full control over their medical records**.  
It combines **AI** for structuring messy health documents with **Web3 decentralized storage**, ensuring privacy, ownership, and accessibility across hospitals and borders.

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

## 🏗️ Tech Stack

- **Mobile App:** Flutter
- **Backend:** FastAPI (Python)
- **AI & NLP:** OCR + NLP models for structuring & summarization
- **Database:** PostgreSQL + pgvector for semantic search
- **Storage:** IPFS / Filecoin (decentralized)
- **Deployment:** Docker + Azure Cloud

---

## 🥇 Why Sejily?

Unlike hospital EHRs (locked), fitness apps (not medical), or blockchain startups (too technical), **Sejily**:  
✅ Combines **AI + Web3** in one platform.  
✅ Empowers patients with full ownership of their health data.  
✅ Makes records **usable, searchable, and secure**.

---

## 🛠️ Installation

To clone and run the Flutter app locally:

```bash
# Clone the repository
git clone https://github.com/ieee-victoris-4-0/sejily_app.git
cd Wavlo

# Get Flutter packages
flutter pub get

# Run the app
flutter run

