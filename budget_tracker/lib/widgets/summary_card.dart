import 'package:flutter/material.dart';

// Stateless: it only shows whatever total and count it is given.
class Summarycard extends StatelessWidget {
  const new({super.key, required this.total, required this.count});

  final int total;
  final int count;

  @override
  Widget build(BuildContext context) {
    // If there's nothing to divide by, the average is 0.
    final average = count == 0 ? 0 : total ~/ count;

    // Container: one box we can give a size, padding, colour and corners.
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Total',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '\$$total',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 16),
          // Row: children side by side. Expanded gives each one half.
          Row(
            children: [
              Expanded(
                child: _Stat(label: 'Income', value: '$count'),
              ),
              Expanded(
                child: _Stat(label: 'Expenses', value: '$average'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// The underscore makes _Stat private to this file.
class _Stat extends StatelessWidget {
  const new({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
