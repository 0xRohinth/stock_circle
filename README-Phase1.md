# Phase 1 – Project Setup & Basic Features

##  Objective

Set up the foundation of the **Offline Stock Management App** and implement the first core feature:

- A product list screen that displays all stored products.
    
- A FloatingActionButton (FAB) to add new products.
    
- A simple form for product input.
    

---

##  Tasks Completed

1. **Project Setup**
    
    - Created a new Flutter project.
        
    - Organized project structure:
        
        ```
        lib/
		  ├── models/
		  │     └── product.dart
		  ├── providers/
		  │     └── product_provider.dart
		  ├── screens/
		  │     ├── product_list_screen.dart
		  │     └── add_product_screen.dart
		  └── main.dart
		```
        
2. **Product Model**
    
    - Defined a `Product` class with fields like `id`, `name`, `quantity`, and `price`.
        
3. **State Management**
    
    - Used **Provider** for managing app-wide state.
        
    - Created `ProductProvider` to handle product list logic (add, fetch).
        
4. **UI Implementation**
    
    - **ProductListScreen**: Displays all products in a list.
        
    - **FloatingActionButton**: Opens `AddProductScreen`.
        
    - **AddProductScreen**: Simple form with input fields for product details.
        

---

##  Tech Stack

- **Frontend**: Flutter (Dart)
    
- **State Management**: Provider
    
- **Database (Future Phase)**: Sqflite (not yet implemented in Phase 1)
    

---

## Screens Implemented

- `ProductListScreen` → Shows product list.

  <img alt="image of ProductListScreen" src=image\Phase1-ProductListScreen.png />

- `AddProductScreen` → Form to add product.

  <img alt="image of AddProductScreen" src=image\Phase1-AddProductScreen.png />


---

##  Next Steps (Phase 2 Preview)

- Implement **SQLite database (sqflite)** for offline storage.
    
- Add CRUD operations (Edit, Delete, Update).
    
- Improve UI with validation & better styling.
