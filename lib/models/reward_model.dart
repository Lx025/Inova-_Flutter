class Reward {
  final String id;
  final String name;
  final String description;
  final int cost; // Custo em pontos/XP (RF08)
  final String imageUrl;

  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.imageUrl,
  });
}