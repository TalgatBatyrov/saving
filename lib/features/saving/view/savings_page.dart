// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_app/features/auth/blocs/auth_cubit.dart';
import 'package:flutter_my_app/repositories/user/models/auth_user.dart';
import '../../../app_widgets/app_empty.dart';
import '../../../app_widgets/app_error.dart';
import '../../../app_widgets/app_loading.dart';
import '../../../router/router.dart';
import '../blocs/saving_cubit.dart';
import '../widgets/add_saving_button.dart';
import '../widgets/savings_list.dart';

@RoutePage()
class SavingsPage extends StatelessWidget {
  final AuthUser user;
  const SavingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          const AddSavingButton(),
          IconButton(
            onPressed: () => _onSignOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<SavingCubit, SavingState>(
        builder: (context, state) {
          return state.when(
            loading: () => const AppLoading(),
            loaded: (savings) => SavingsList(savings: savings),
            error: (errorMessage) => AppError(message: errorMessage),
            empty: () => const AppEmpty(),
          );
        },
      ),
    );
  }

  Future<void> _onSignOut(BuildContext context) async {
    final isConfirmed = await _showSignOutDialog(context);

    if (isConfirmed == true) {
      context.router.replace(const SignInRoute());
      context.read<AuthCubit>().logout();
    }
  }

  Future<bool?> _showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выход'),
          content: const Text('Вы уверены, что хотите выйти?'),
          actions: [
            TextButton(
              onPressed: () {
                context.router.pop(false);
              },
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () {
                context.router.pop(true);
              },
              child: const Text('Да'),
            ),
          ],
        );
      },
    );
  }
}
