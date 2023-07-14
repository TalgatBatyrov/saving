import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/app_widgets/app_empty.dart';
import 'package:flutter_my_app/features/saving/bloc/saving_state.dart';
import 'package:flutter_my_app/features/app_widgets/app_error.dart';

import '../../app_widgets/app_loading.dart';
import '../bloc/saving_cubit.dart';
import '../widgets/add_saving_button.dart';
import '../widgets/saving_tile.dart';

@RoutePage()
class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SavingPage')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SavingCubit, SavingState>(
              builder: (context, state) {
                if (state is SavingLoading) {
                  return const AppLoading();
                }
                if (state is SavingEmpty) {
                  return const AppEmpty();
                }
                if (state is SavingError) {
                  return AppError(message: state.message);
                }
                if (state is SavingLoaded) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },
                    itemCount: state.savings.length,
                    itemBuilder: (context, index) {
                      final saving = state.savings[index];
                      return SavingTile(saving: saving);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const AddSavingButton(),
    );
  }
}
