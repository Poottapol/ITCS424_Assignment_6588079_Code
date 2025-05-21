class TributeItem {
  final String name;
  final int price;
  final String image;

  TributeItem({required this.name, required this.price, required this.image});
}

class TributeHistory {
  final String fullName;
  final String message;
  final List<TributeItem> items;
  final DateTime timestamp;

  TributeHistory({
    required this.fullName,
    required this.message,
    required this.items,
    required this.timestamp,
  });
}
