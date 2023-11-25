import 'package:flutter_bloc/flutter_bloc.dart';

enum Currency { usd, eur, rub, kgs }

class CurrencyCubit extends Cubit<Currency> {
  CurrencyCubit() : super(Currency.kgs);

  void selectCurrency(Currency currency) {
    emit(currency);
  }
}
