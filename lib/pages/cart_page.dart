import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/app_widgets/app_empty.dart';
import 'package:saving/app_widgets/app_error.dart';
import 'package:saving/app_widgets/app_loading.dart';
import 'package:saving/models/saving/saving.dart';
import 'package:saving/repositories/cart/cart_repository.dart';
import 'package:saving/widgets/savings_list.dart';

class CartPage extends StatefulWidget {
  final String userId;

  const CartPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final dio = Dio();
  final firestore = FirebaseFirestore.instance;

  late final cartRepository = CartRepository(
    dio: dio,
    firestore: firestore,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: FutureBuilder<List<Saving>>(
        future: cartRepository.getCartsList(userId: widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
          } else if (snapshot.hasError) {
            return AppError(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final List<Saving> cartList = snapshot.data ?? [];
            print('leng${cartList.length}');
            return SavingsList(savings: cartList);
          } else {
            return AppEmpty(message: translate('no_targets'));
          }
        },
      ),
    );
  }
}
