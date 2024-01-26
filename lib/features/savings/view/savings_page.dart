// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/app/routes/routes.dart';
import 'package:saving/core/utils/dialogs/logout_dialog.dart';
import 'package:saving/features/auth/bloc/auth_cubit.dart';
import 'package:saving/features/auth/bloc/profile_cubit/profile_cubit.dart';
import 'package:saving/features/blocs/currency/currency_cubit.dart';
import 'package:saving/features/blocs/internet_connection/internet_connection_cubit.dart';
import 'package:saving/features/savings/bloc/saving_cubit.dart';
import 'package:saving/features/savings/widgets/add_saving_button.dart';
import 'package:saving/features/savings/widgets/button_translate.dart';
import 'package:saving/features/savings/widgets/currency_selection_modal.dart';
import 'package:saving/features/savings/widgets/savings_list.dart';

import '../../widgets/app_empty.dart';
import '../../widgets/app_error.dart';
import '../../widgets/app_loading.dart';
import '../../widgets/theme_toggle_button.dart';

@RoutePage()
class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectionCubit, InternetConnectionState>(
      listenWhen: (prev, _) => prev != const InternetConnectionState.initial(),
      listener: (context, state) {
        if (state == const InternetConnectionState.disconnected()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate('no_internet')),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state == const InternetConnectionState.connected()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(translate('internet_back')),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.when(
                loaded: (profile) => Text(profile.name),
                loading: () => const AppLoading(),
                error: (errorMessage) => AppError(
                  message: errorMessage.toString(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const CurrencySelectionModal(),
                );
              },
              icon: BlocBuilder<CurrencyCubit, Currency>(
                builder: (context, state) {
                  return Text(state.name);
                },
              ),
            ),
            const ThemeToggleButton(),
            const AddSavingButton(),
            IconButton(
              onPressed: () {
                ButtonTranslate().onActionSheetPress(context);
              },
              icon: const Icon(Icons.translate),
            ),
            IconButton(
              onPressed: () => _onSignOut(context),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<SavingCubit, SavingState>(
          builder: (context, state) {
            return state.when(
              refresh: () => const AppLoading(),
              loading: () => const AppLoading(),
              loaded: (savings) => SavingsList(savings: savings),
              error: (errorMessage) => AppError(message: errorMessage),
              empty: () => AppEmpty(message: translate('no_targets')),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onSignOut(BuildContext context) async {
    final isConfirmed = await showLogOutDialog(context);

    if (isConfirmed == true) {
      context.router.replace(const SignInRoute());
      context.read<AuthCubit>().logout();
    }
  }
}
