class Offers {
  final String title;
  final double price;
  final String description;
  late final int quantity;
  final Map<String,dynamic>company;

  Offers(
      {required this.company, required this.description,required this.title, required this.price, required this.quantity});

  factory Offers.data(Map<String, dynamic> response) {
    return Offers(
      company: response['company'],
      description: response['description'],
      title: response['title'],
      price: response['price'],
      quantity: response['quantity'],
    );
  }
}