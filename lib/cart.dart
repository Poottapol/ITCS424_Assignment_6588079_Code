import 'package:flutter/material.dart';
import '../models.dart';
import 'history.dart';

class CartScreen extends StatefulWidget {
  final List<TributeItem> cart;
  final List<TributeHistory> history;

  CartScreen({required this.cart, required this.history});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int total = widget.cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: Text('🧺 Your Cart')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ...widget.cart.asMap().entries.map((entry) {
              final item = entry.value;
              return Card(
                child: ListTile(
                  leading: Image.asset(item.image, width: 50),
                  title: Text(item.name),
                  subtitle: Text('${item.price} Baht'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed:
                        () => setState(() => widget.cart.removeAt(entry.key)),
                  ),
                ),
              );
            }).toList(),
            Divider(),
            Text('Total: $total Baht', style: TextStyle(fontSize: 18)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInput('First Name', _fnameController),
                  _buildInput('Last Name', _lnameController),
                  _buildInput('Message', _msgController),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Submit Tribute'),
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  void _submit() {
    final firstName = _fnameController.text.trim();
    final lastName = _lnameController.text.trim();
    final message = _msgController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || message.isEmpty) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('⚠️ Missing Information'),
              content: Text('Please fill in all the fields before confirming.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    final fullName = '$firstName $lastName';

    widget.history.add(
      TributeHistory(
        fullName: fullName,
        message: message,
        items: List.from(widget.cart),
        timestamp: DateTime.now(),
      ),
    );

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('✅ Tribute Confirmed'),
            content: Text('Thank you, $fullName!\nYour message: $message'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, []);
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }
}
