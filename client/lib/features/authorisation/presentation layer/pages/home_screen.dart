import 'package:client/features/authorisation/presentation%20layer/bloc/disable_account_bloc/disable_account_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../domain layer/entities/user.dart';

class HomrScreen extends StatelessWidget {
  const HomrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
        if (state is SignUpLoading) {
          const LoadingWidget();
        } else if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignUpBloc>(context).add(SignUpButtonPressed(
                      user: User.create(
                          firstName: "dhia",
                          lastName: "bouamiea",
                          email: "nidhalbmz12546535@gmail.com",
                          password: "nidhal123456",
                          passwordConfirm: "nidhal123456")));
                },
                child: const Text("Button"),
              ),
            ),
            if (state is DisableAccountLoading) ...[
              Positioned.fill(
                child: Container(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ),
              ),
            ],
          ],
        );
      }),
    );
  }
}
