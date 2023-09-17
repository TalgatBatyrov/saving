import 'package:flutter_bloc/flutter_bloc.dart';

enum Currency { USD, EUR, RUB, KGS }

class CurrencyCubit extends Cubit<Currency> {
  CurrencyCubit() : super(Currency.KGS);

  void selectCurrency(Currency currency) {
    emit(currency);
  }
}
