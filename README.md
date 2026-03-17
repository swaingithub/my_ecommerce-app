# Fluxy E-Commerce Example

A production-ready e-commerce application demonstrating the power and simplicity of the **Fluxy** framework.

If you are a developer asking, *"Can I build a real app with this?"* – The answer is **Yes**. 

We built this e-commerce checkout flow to show exactly what a "full flow" looks like in Fluxy. This isn't just a static UI template; it goes deeper into real-world state management and application architecture.

## 🌟 What's Included (The Full Flow)

We explicitly include all the essential pieces of a modern e-commerce application:

### 1. Product List
Features a dynamic, responsive product grid complete with search filtering, categorical grouping, and wishlist toggling. Built with `FxGrid` and `fluxComputed` to performantly react to any filter changes.

### 2. Product Detail Page
A beautiful, immersive detail view utilizing Hero animations. Tapping any product navigates you into a detailed view where you can learn more about the item and its pricing before deciding to purchase. 

### 3. Add to Cart
Interactive, instantaneous cart additions from anywhere in the app — directly from the product list or the product detail page. The cart icon badge automatically reacts to `cart.value.length`.

### 4. Cart State Management
Driven entirely by `FluxController` primitives (like `flux<List<Product>>([])`), managing cart state in Fluxy is effortless. Additions, removals, and total price computations (`fluxComputed`) happen smoothly without complex boilerplates.

### 5. Checkout Flow
A mock checkout flow proving how to easily gather user personal info, shipping address, and payment method into a streamlined multi-step process.

---

## 🚀 Getting Started

1. Clone or download this project.
2. Ensure you have the latest stable [Flutter](https://docs.flutter.dev/) SDK securely installed.
3. Run `flutter pub get` to resolve the `fluxy` dependencies.
4. Run `flutter run` and dive right in!

## Code Structure Highlights

* **`lib/main.dart`**: Hooks into the global error pipeline, initializes stability policy (`strictMode: false`), and runs the app.
* **`lib/features/home/home.controller.dart`**: The single source of truth. Notice how state primitives like `cart`, `wishlist`, `searchQuery` sync the UI globally.
* **`lib/features/home/home.view.dart`**: The core layout showcasing bottom navigation, custom drawers, sidebars, and reactive shopping bag floating action buttons.
* **`lib/features/home/product_detail.view.dart`**: Detailed dynamic views mapping products with smooth `Hero` transitons and immediate Cart injections.
* **`lib/features/checkout/checkout.view.dart`**: A slick UI for the checkout phase.

Enjoy building real apps, really fast.
