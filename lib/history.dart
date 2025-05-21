import 'package:flutter/material.dart';
import 'models.dart';

class HistoryScreen extends StatelessWidget {
  final List<TributeHistory> history;

  const HistoryScreen({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('📜 Tribute History')),
      body:
          history.isEmpty
              ? Center(child: Text('No history yet.'))
              : ListView.builder(
                itemCount: history.length,
                itemBuilder: (_, index) {
                  final record = history[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(record.fullName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Message: ${record.message}'),
                          Text(
                            'Items: ${record.items.map((e) => e.name).join(', ')}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
