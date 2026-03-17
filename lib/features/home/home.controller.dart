import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  Product({required this.id, required this.name, required this.price, required this.imageUrl, required this.category});
}

class HomeController extends FluxController {
  final products = flux<List<Product>>([
    Product(id: '1', name: 'Premium Leather Bag', price: 120.0, imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500&q=80', category: 'Fashion'),
    Product(id: '2', name: 'Wireless Headphones', price: 299.99, imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80', category: 'Electronics'),
    Product(id: '3', name: 'Smart Watch', price: 199.50, imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80', category: 'Electronics'),
    Product(id: '4', name: 'Minimalist Desk Lamp', price: 89.0, imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&q=80', category: 'Home'),
  ]);

  final cart = flux<List<Product>>([]);
  final wishlist = flux<List<String>>([]);
  
  final searchQuery = flux<String>('');
  final selectedCategory = flux<String>('All');
  
  final categories = ['All', 'Fashion', 'Electronics', 'Home'];

  // User Profile State
  final userName = flux<String>('Sarah Jenkins');
  final userEmail = flux<String>('sarah.j@fluxyshop.com');
  final userAvatar = flux<String>('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&q=80');
  final ordersCount = flux<int>(12);
  final points = flux<int>(450);
  final isDarkMode = flux<bool>(false);
  final notificationsEnabled = flux<bool>(true);
  final language = flux<String>('English');

  final currentNavIndex = flux<int>(0);

  // Reactive Design Tokens
  Color get surface => isDarkMode.value ? const Color(0xFF1E1E1E) : Colors.white;
  Color get text => isDarkMode.value ? Colors.white : Colors.black87;
  Color get textMuted => isDarkMode.value ? Colors.grey.shade400 : Colors.black54;

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }

  void addToCart(Product p) {
    cart.value = [...cart.value, p];
  }

  void removeFromCart(Product p) {
    final newList = List<Product>.from(cart.value);
    final index = newList.indexWhere((item) => item.id == p.id);
    if (index != -1) {
      newList.removeAt(index);
      cart.value = newList;
    }
  }

  void toggleWishlist(Product p) {
    if (wishlist.value.contains(p.id)) {
      wishlist.value = wishlist.value.where((id) => id != p.id).toList();
    } else {
      wishlist.value = [...wishlist.value, p.id];
    }
  }

  late final cartTotal = fluxComputed(() => cart.value.fold(0.0, (sum, item) => sum + item.price));

  late final filteredProducts = fluxComputed(() {
    return products.value.where((p) {
      final matchesCategory = selectedCategory.value == 'All' || p.category == selectedCategory.value;
      final matchesSearch = p.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  });
}
