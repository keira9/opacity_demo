import 'package:flutter/material.dart';

// Demo: the Opacity widget used for a real-world "Sold out" state in a shop.
// Sold-out products are dimmed with Opacity; a control panel lets us change
// the three Opacity properties live: opacity, alwaysIncludeSemantics, child.

void main() => runApp(const OpacityDemoApp());

class OpacityDemoApp extends StatelessWidget {
  const OpacityDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opacity Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const ShopScreen(),
    );
  }
}

// Simple data holder for a product.
class Product {
  final String name;
  final String price;
  final IconData icon;
  final bool soldOut;

  const Product(this.name, this.price, this.icon, {this.soldOut = false});
}

// Which part of the card gets wrapped in Opacity (demonstrates `child`).
enum FadeTarget { wholeCard, imageOnly }

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // Property 1: opacity (0.0 = invisible, 1.0 = fully visible).
  double _opacity = 1.0;

  // Property 2: alwaysIncludeSemantics (default is false).
  bool _alwaysIncludeSemantics = false;

  // Property 3: child (what we wrap).
  FadeTarget _target = FadeTarget.wholeCard;

  final List<Product> _products = const [
    Product('Camera Strap', 'RWF 15,000', Icons.camera_alt),
    Product('Tripod Stand', 'RWF 40,000', Icons.photo_camera_back,
        soldOut: true),
    Product('Lens Cleaning Kit', 'RWF 8,000', Icons.lens_blur, soldOut: true),
    Product('Memory Card 64GB', 'RWF 20,000', Icons.sd_card),
  ];

  // Wraps [child] in Opacity ONLY if the product is sold out.
  Widget _fadeIfSoldOut(Product p, Widget child) {
    if (!p.soldOut) return child;
    return Opacity(
      opacity: _opacity,
      alwaysIncludeSemantics: _alwaysIncludeSemantics,
      child: child,
    );
  }

  Widget _buildProductCard(Product p) {
    final image = Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(p.icon, size: 36, color: Colors.teal.shade800),
    );

    final details = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            Text(p.price),
            if (p.soldOut)
              const Text('Sold out', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );

    // Whole card: Opacity wraps the Card (image + text fade together).
    if (_target == FadeTarget.wholeCard) {
      return _fadeIfSoldOut(
        p,
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [image, details]),
          ),
        ),
      );
    }

    // Image only: Opacity wraps just the image; text stays fully visible.
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: [_fadeIfSoldOut(p, image), details]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Gear Shop')),
      body: Column(
        children: [
          // Product list (the real-world use case).
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: _products.map(_buildProductCard).toList(),
            ),
          ),
          // Control panel (used live during the presentation).
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('opacity: ${_opacity.toStringAsFixed(2)}'),
                Slider(
                  value: _opacity,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (v) => setState(() => _opacity = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('alwaysIncludeSemantics'),
                  value: _alwaysIncludeSemantics,
                  onChanged: (v) =>
                      setState(() => _alwaysIncludeSemantics = v),
                ),
                const Text('child (what Opacity wraps):'),
                const SizedBox(height: 4),
                SegmentedButton<FadeTarget>(
                  segments: const [
                    ButtonSegment(
                        value: FadeTarget.wholeCard, label: Text('Whole card')),
                    ButtonSegment(
                        value: FadeTarget.imageOnly, label: Text('Image only')),
                  ],
                  selected: {_target},
                  onSelectionChanged: (s) =>
                      setState(() => _target = s.first),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}