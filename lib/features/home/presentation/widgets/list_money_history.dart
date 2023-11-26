import 'package:flutter/material.dart';
import 'package:perfin_app/features/home/domain/entities/money.dart';

class ListMoneyHistory extends StatelessWidget {
  final List<Money> money;
  const ListMoneyHistory({required this.money, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        money.length,
        (index) => moneyItem(money[index]),
      ),
    );
  }

  Widget moneyItem(Money money) {
    var isRising = money.isRising;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: isRising ? Colors.green.shade300 : Colors.red.shade300,
      ),
      child: Row(
        children: [
          !isRising
              ? const Icon(Icons.keyboard_double_arrow_down)
              : const Icon(Icons.keyboard_double_arrow_up),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  isRising ? const Text('+') : const Text('-'),
                  Text(
                    money.money.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('total Money ${money.totalMoney.toString()}'),
            ],
          )
        ],
      ),
    );
  }
}
