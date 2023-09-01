// ignore_for_file: use_build_context_synchronously
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:saving/features/saving/widgets/button_translate.dart';
import 'package:saving/utilities/dialogs/logout_dialog.dart';
import '../../../app_widgets/app_empty.dart';
import '../../../app_widgets/app_error.dart';
import '../../../app_widgets/app_loading.dart';
import '../../../app_widgets/theme_toggle_button.dart';
import '../../../repositories/user/models/auth_user.dart';
import '../../../router/router.dart';
import '../../auth/blocs/auth_cubit.dart';
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
            loading: () => const AppLoading(),
            loaded: (savings) => SavingsList(savings: savings),
            error: (errorMessage) => AppError(message: errorMessage),
            empty: () => AppEmpty(message: translate('no_targets')),
          );
        },
      ),
      // body: CustomScrollView(
      //   anchor: 0.0,
      //   slivers: [
      //     SliverAppBar(
      //       title: Text(user.name),
      //       actions: [
      //         const ThemeToggleButton(),
      //         const AddSavingButton(),
      //         IconButton(
      //           onPressed: () => _onSignOut(context),
      //           icon: const Icon(Icons.logout),
      //         ),
      //         // reset password
      //       ],
      //     ),
      //     // BlocBuilder<SavingCubit, SavingState>(
      //     //   builder: (context, state) {
      //     //     return state.when(
      //     //       loading: () => const AppLoading(),
      //     //       loaded: (savings) => SavingsList(savings: savings),
      //     //       error: (errorMessage) => AppError(message: errorMessage),
      //     //       empty: () => const AppEmpty(message: 'Нет целей'),
      //     //     );
      //     //   },
      //     // ),
      //   ],
      // ),
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
