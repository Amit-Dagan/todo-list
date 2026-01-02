# ToDo List (Flutter) — Remepy Challenge

A clean and simple ToDo app built with Flutter.  
The goal of this project is to implement a classic ToDo flow in a **professional, production-style** way, emphasizing **best practices**, **separation of concerns**, and **maintainable architecture**.

---

## Features (Requirements)
- View all tasks on the main screen
- Navigate to an “Add Task” screen and create new tasks
- Swipe to delete tasks
- Persistent storage using **SharedPreferences** (tasks survive app restart)

## Bonus
- Toggle task completion (done/undone) with a clear visual difference

---

## Architecture & Design Decisions

### Architectural Pattern
This project follows a **Clean Architecture inspired** layering (lightweight and pragmatic):

- **Presentation**: UI + Cubit (state management)
- **Domain**: Entities + Repository interfaces (business logic boundaries)
- **Data**: Repository implementation

### State Management
- **Cubit (flutter_bloc)** is used to keep UI reactive and logic outside widgets.
- UI only renders states; side effects (SnackBars/navigation) are handled via listeners when needed.

### Repository Pattern
- UI never talks directly to SharedPreferences.
- A `TaskRepository` interface lives in the Domain layer.
- A concrete implementation in Data handles serialization and persistence.
- This keeps storage replaceable (e.g., SQLite/Firebase later) without changing UI.
- I added a mock implementation to make the UI development easier for me

### Model vs Entity
- **Entity** represents the core domain structure (`TaskEntity`).
- **Model** represents the data/persistence format and handles `toMap/fromMap` conversion.
- Mapping ensures the Domain stays independent of storage details.

### Dependency Injection
- Uses **GetIt** as a service locator to provide repositories and keep constructors clean.
- This supports testability and clear dependency boundaries.

### What I didn’t do (and why)

- I did not introduce a Use Case layer to avoid over-engineering a small feature set.  
  The current logic is straightforward and fits naturally inside the Cubits.

- I did not abstract UUID generation behind a repository, as it is used in a single place.  
  Introducing an extra dependency for this would not meaningfully improve testability or maintainability.
