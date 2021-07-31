class NikeShoes {
  final String? model;
  final double? oldPrice;
  final double? currentPrice;
  final List<String>? images;
  final int? modelNumber;
  final int? color;

  NikeShoes(
      {this.model,
      this.oldPrice,
      this.currentPrice,
      this.images,
      this.modelNumber,
      this.color});
}

final shoes = <NikeShoes>[
  NikeShoes(
      model: 'AIR MAX 90 EZ BLACK',
      currentPrice: 149.0,
      oldPrice: 230.0,
      images: [
        'assets/shoes/nike3.png',
        'assets/shoes/nike1.png',
        'assets/shoes/nike2.png',
        'assets/shoes/nike4.png'
      ],
      modelNumber: 90,
      color: 0xFFF6F6F6),
  NikeShoes(
      model: 'AIR MAX 90 270',
      currentPrice: 249.0,
      oldPrice: 210.0,
      images: [
        'assets/shoes/nike1.png',
        'assets/shoes/nike2.png',
        'assets/shoes/nike3.png',
        'assets/shoes/nike4.png',
      ],
      modelNumber: 24,
      color: 0xFFFCF5EB),
  NikeShoes(
      model: 'AIR MAX 90 GOLD',
      currentPrice: 349.0,
      oldPrice: 290.0,
      images: [
        'assets/shoes/nike3.png',
        'assets/shoes/nike1.png',
        'assets/shoes/nike2.png',
        'assets/shoes/nike4.png',
      ],
      modelNumber: 14,
      color: 0xFFFEF7ED),
  NikeShoes(
      model: 'AIR MAX PREMIUM',
      currentPrice: 349.0,
      oldPrice: 290.0,
      images: [
        'assets/shoes/nike4.png',
        'assets/shoes/nike2.png',
        'assets/shoes/nike3.png',
        'assets/shoes/nike1.png',
      ],
      modelNumber: 14,
      color: 0xFFFEEFEF)
];
