📦 Merchant Product Management App (Flutter)

📌 Tech Stack
Flutter (latest stable)
Bloc / Cubit
Drift (SQLite)
Connectivity Plus
Clean Architecture
JSON Server (mock backend)

🏗️ Architecture

This project follows Clean Architecture principles:

presentation/
    ├── bloc/
    ├── pages/
    └── widgets/

domain/
    ├── entities/
    ├── repositories/
    └── usecases/

data/
    ├── datasource/
    │     ├── local (Drift)
    │     └── remote (API)
    ├── models/
    ├── mapper/
    └── services (Sync Engine)

🔄 Data Flow
Read Flow (Offline-first)
UI → Bloc → UseCase → Repository
        ↓
   Local DB (primary source)
        ↓
   Remote API (refresh)
Write Flow (Offline-first)
UI → Bloc → UseCase → Repository
        ↓
   Local DB (immediate write)
        ↓
   Sync Queue (pending operations)
        ↓
   SyncService (background execution)
        ↓
   Remote API

🧩 State Management
Bloc / Cubit used for presentation logic
Separation of concerns:
UI → Events only
Bloc → State handling
Repository → Data coordination

🗄️ Local Storage
Drift (SQLite abstraction)
Stores:
Products
Pending sync queue

🚀 How to Run
1. Install dependencies
`flutter pub get`
2. Run JSON server
`json-server --watch db.json --port 3000`
3. Run app
`flutter run`