import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saving/blocs/currency/currency_cubit.dart';

class CurrencySelectionModal extends StatelessWidget {
  const CurrencySelectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите валюту:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          CurrencyItem(currency: Currency.usd),
          CurrencyItem(currency: Currency.eur),
          CurrencyItem(currency: Currency.rub),
          CurrencyItem(currency: Currency.kgs),
        ],
      ),
    );
  }
}

class CurrencyItem extends StatelessWidget {
  final Currency currency;

  const CurrencyItem({
    super.key,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final currencyCubit = context.read<CurrencyCubit>();

    return BlocBuilder<CurrencyCubit, Currency>(
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.attach_money),
          title: Text(currency.name),
          trailing:
              state.name == currency.name ? const Icon(Icons.check) : null,
          onTap: () {
            currencyCubit.selectCurrency(currency);

            Navigator.pop(context);
          },
        );
      },
    );
  }
}
