import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';

class AuthActionButton extends StatelessWidget {
  final void Function() onSubmit;
  final String type;
  const AuthActionButton({
    super.key,
    required this.onSubmit,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    bool isSubmit = false;
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthLoading && isSubmit == true) {
        return const CircularProgressIndicator();
      }
      if (state is AuthFailed && isSubmit == true) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          error(context, state.errors[0]);
        });
      }
      if (state is AuthLoaded && isSubmit == true) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          success(context, "$type successfully");
          Navigator.pushReplacementNamed(
            context,
            ProductsScreen.routeName,
          );
        });
      }

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            onSubmit();
            isSubmit = true;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Text(
            type,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 20,
                ),
          ),
        ),
      );
    });
  }
}
