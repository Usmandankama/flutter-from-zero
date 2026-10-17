import 'package:budget_tracker/widgets/summary_card.dart';
import 'package:flutter/material.dart';

// Stateful: the total changes while the app is running.
class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _total = 0;
  int _count = 0;

  void _addSpending(int amount) {
    // setState tells Flutter "something changed, build the screen again".
    setState(() {
      _total += amount;
      _count += 1;
    });

    // _total += amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget App')),
      body: Center(
        child: Summarycard(total: _total, count: _count),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSpending(10); // Example: Add $10 to the total
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
