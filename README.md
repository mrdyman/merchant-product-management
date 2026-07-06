📦 Merchant Product Management App (Flutter)
📌 Tech Stack
Flutter (latest stable)
Bloc / Cubit
Drift (SQLite)
Connectivity Plus
Clean Architecture
JSON Server (mock backend)

Overview

A production-style Flutter application for managing merchant products with full offline-first support, local persistence, and automatic background synchronization when connectivity is restored.

The system is designed with Clean Architecture, scalable state management, and a robust sync engine to simulate real-world distributed mobile data challenges.

🧠 Key Features
📦 Product Management
Product list with pagination
Product detail view
Create product
Update product

🌐 Offline-First Support
App works fully offline
All writes are stored locally first
UI remains responsive without network

🔄 Background Sync Engine
Automatic sync when connectivity is restored
Retry mechanism for failed operations
Queue-based sync system

⚠️ Conflict Awareness
Designed to handle HTTP 409 Conflict
Strategy for resolving stale updates

📊 UX Enhancements
Offline indicator
Sync status indicator
Pending operations counter

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
   
🧠 Offline Strategy
Principle

"Local database is the source of truth"

Behavior
All writes (create/update) are saved locally first
Each mutation is stored in a pending operations queue
Sync is performed automatically when device reconnects
UI never depends on network availability

🔄 Sync Engine Design
Components
SyncService
PendingOperationDao
NetworkInfo
ConnectivityService
Workflow
1. Detect network reconnection
2. Load pending operations from local DB
3. Execute sequentially
4. On success → remove from queue
5. On failure → increment retry count
6. After N retries → drop or mark failed

⚠️ Conflict Handling Strategy (HTTP 409)

When server detects outdated data:

Approach:
Compare updatedAt timestamp
If conflict occurs:
Fetch latest server version
Merge strategy:
server wins OR
last-write-wins (default)
Notify UI if manual resolution is needed

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
Ensures offline persistence

🌐 Network Layer
Remote API mocked via JSON Server
Endpoints:
GET /products?_page
GET /products/{id}
POST /products
PUT /products/{id}

🔁 Sync Guarantees
✔ At-least-once delivery
✔ Retry with backoff
✔ Sequential execution
✔ Crash-safe queue (persisted in DB)

📊 UX States
Offline Mode
Offline banner visible
Writes still allowed
Sync queued
Syncing Mode
Sync icon shown
Pending operations counter updates

🧪 Trade-offs
1. JSON payload in queue
✔ simple
❌ not strongly typed
✔ acceptable for MVP
2. Sequential sync (no parallelism)
✔ avoids race conditions
❌ slower for large queues
3. Last-write-wins conflict strategy
✔ simple to implement
❌ may overwrite concurrent edits

🚀 How to Run
1. Install dependencies
`flutter pub get`
2. Run JSON server
`json-server --watch db.json --port 3000`
3. Run app
`flutter run`
