import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'home.repository.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviews;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.rating = 4.5,
    this.reviews = 100,
    this.description = 'Experience premium quality with this meticulously crafted product.',
  });
}

class Address {
  final String id;
  final String label;
  final String fullAddress;
  final bool isDefault;

  Address({required this.id, required this.label, required this.fullAddress, this.isDefault = false});
}

class PaymentCard {
  final String id;
  final String bank;
  final String last4;
  final String iconType;

  PaymentCard({required this.id, required this.bank, required this.last4, required this.iconType});
}

class HomeController extends FluxController {
  final HomeRepository _repository = HomeRepository();

  final products = flux<List<Product>>([]);
  final isLoadingProducts = flux<bool>(true);
  final isProcessingPayment = flux<bool>(false);
  final isDarkMode = flux<bool>(false);

  HomeController() {
    _initTheme();
    _loadProducts();
  }

  Future<void> _initTheme() async {
    final savedModeStr = await FluxyVault.read('isDark');
    isDarkMode.value = savedModeStr == 'true';
  }

  Future<void> toggleTheme(bool isDark) async {
    isDarkMode.value = isDark;
    Fx.setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    await FluxyVault.write('isDark', isDark.toString());
  }

  Future<void> _loadProducts() async {
    isLoadingProducts.value = true;
    try {
      // Simulate calling a real network REST API
      products.value = await _repository.fetchRemote(); 
    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

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
  final notificationsEnabled = flux<bool>(true);
  final language = flux<String>('English');

  final addresses = flux<List<Address>>([
    Address(id: '1', label: 'Home', fullAddress: '123 Fluxy Street, San Francisco, CA 94105', isDefault: true),
    Address(id: '2', label: 'Work', fullAddress: '456 Tech Avenue, San Jose, CA 95113'),
  ]);
  final selectedAddressId = flux<String>('1');

  final paymentCards = flux<List<PaymentCard>>([
    PaymentCard(id: '1', bank: 'Visa', last4: '4242', iconType: 'visa'),
    PaymentCard(id: '2', bank: 'MasterCard', last4: '5555', iconType: 'mastercard'),
  ]);
  final selectedPaymentId = flux<String>('1');

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

  // Access computed currently active selection
  late final selectedAddress = fluxComputed(() => addresses.value.firstWhere((a) => a.id == selectedAddressId.value, orElse: () => addresses.value.first));
  late final selectedPayment = fluxComputed(() => paymentCards.value.firstWhere((p) => p.id == selectedPaymentId.value, orElse: () => paymentCards.value.first));

  late final filteredProducts = fluxComputed(() {
    return products.value.where((p) {
      final matchesCategory = selectedCategory.value == 'All' || p.category == selectedCategory.value;
      final matchesSearch = p.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  });
}
