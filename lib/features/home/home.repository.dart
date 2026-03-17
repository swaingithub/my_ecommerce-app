import 'package:fluxy/fluxy.dart';
import 'home.controller.dart';

class HomeRepository extends FluxRepository<List<Product>> {
  @override
  Future<List<Product>> fetchRemote() async {
    // Simulating a real network REST API call with a 2-second delay
    await Future.delayed(const Duration(seconds: 2));
    
    // In production, this would be: 
    // final response = await Fluxy.http.get('/api/v1/products');
    // return (response.data as List).map((json) => Product.fromJson(json)).toList();

    return [
      Product(
        id: '1', name: 'Premium Leather Bag', price: 120.0, imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500&q=80', category: 'Fashion',
        rating: 4.8, reviews: 142, description: 'Handcrafted premium leather bag featuring an elegant quilted chevron design with striking gold-tone hardware. The perfect accessory for elevated evening wear or a sophisticated daily carry piece. Made with 100% full-grain Italian leather.'
      ),
      Product(
        id: '2', name: 'Wireless Headphones', price: 299.99, imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80', category: 'Electronics',
        rating: 4.9, reviews: 310, description: 'Experience pure sonic isolation with industry-leading Active Noise Cancelling (ANC). Boasts a 30-hour battery life on a single charge and ultra-plush memory foam ear cups for all-day comfort. Tuned by acoustic engineers for an immersive listening profile.'
      ),
      Product(
        id: '3', name: 'Smart Watch', price: 199.50, imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&q=80', category: 'Electronics',
        rating: 4.5, reviews: 89, description: 'A sleek, minimalist smartwatch designed to integrate seamlessly into your daily life. Track your heart rate, blood oxygen levels, sleep cycles, and daily activity. Features an always-on crisp OLED display and IP68 water resistance.'
      ),
      Product(
        id: '4', name: 'Minimalist Desk Lamp', price: 89.0, imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&q=80', category: 'Home',
        rating: 4.6, reviews: 204, description: 'The ultimate reading companion. This modern steel desk lamp features adjustable color temperatures (from warm yellow to bright daylight) and smooth, stepless dimming control. Its sleek matte finish and geometric precision make it a statement piece.'
      ),
      Product(
        id: '5', name: 'Mechanical Keyboard', price: 159.0, imageUrl: 'https://images.unsplash.com/photo-1595225476474-87563907a212?w=500&q=80', category: 'Electronics',
        rating: 4.7, reviews: 450, description: 'Elevate your typing experience with hot-swappable linear mechanical switches. Boasts per-key RGB backlighting encased in a heavy-duty aerospace-grade aluminum chassis. The double-shot PBT keycaps guarantee lifetime durability without shine.'
      ),
      Product(
        id: '6', name: 'Ceramic Coffee Mug', price: 24.0, imageUrl: 'https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=500&q=80', category: 'Home',
        rating: 4.9, reviews: 52, description: 'Start your mornings beautifully. This artisanal, handmade ceramic mug is kiln-fired and coated with a unique speckled matte glaze. Thick walls retain heat longer while the ergonomic handle provides a perfectly balanced grip.'
      ),
    ];
  }

  @override
  Future<List<Product>> fetchLocal() async {
    // In production, check local storage (e.g., Hive or SQLite) first for offline support
    return [];
  }
  
  @override
  Future<void> saveLocal(List<Product> data) async {
    // In production, cache the new items for faster load times later
  }
}
