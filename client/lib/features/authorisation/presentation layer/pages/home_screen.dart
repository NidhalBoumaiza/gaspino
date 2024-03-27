import 'package:client/features/authorisation/presentation%20layer/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:client/features/authorisation/presentation%20layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../domain layer/entities/user.dart';
import '../bloc/sign_out_bloc/sign_out_bloc.dart';
import '../bloc/update_coordinate_bloc/update_coordinate_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<UpdateCoordinateBloc, UpdateCoordinateState>(
                  listener: (context, state) {
                    if (state is UpdateCoordinateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Success"),
                        ),
                      );
                    } else if (state is UpdateCoordinateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<UpdateCoordinateBloc>(context).add(
                          UpdateCoordinate(
                            location: Location([50.00, 50.0]),
                          ),
                        );
                      },
                      child: const Text("Update Coordinate Button"),
                    );
                  },
                ),
                BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SignInSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("SignIn Success"),
                        ),
                      );
                    } else if (state is SignInError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SignInBloc>(context).add(
                          SignInWithEmailAndPassword(
                            email: "nidhalbmz123@gmail.com",
                            password: "nidhal123456",
                          ),
                        );
                      },
                      child: const Text("SignIn Button"),
                    );
                  },
                ),
                BlocConsumer<SignOutBloc, SignOutState>(
                  listener: (context, state) {
                    if (state is SignOutSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("SignOut Success"),
                        ),
                      );
                    } else if (state is SignOutError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SignOutBloc>(context).add(
                          SignOutMyAccountEventPressed(),
                        );
                      },
                      child: const Text("SignOut Button"),
                    );
                  },
                ),
                BlocConsumer<UpdateUserPasswordBloc, UpdateUserPasswordState>(
                  listener: (context, state) {
                    if (state is UpdateUserPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("password changed Successfully"),
                        ),
                      );
                    } else if (state is UpdateUserPasswordError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<UpdateUserPasswordBloc>(context).add(
                          UpdateUserPasswordEventPasswordChanging(
                            oldPassword: '123456789',
                            newPassword: 'nidhal123456',
                            newPasswordConfirm: 'nidhal123456',
                          ),
                        );
                      },
                      child: const Text("Update user password Button"),
                    );
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<UpdateCoordinateBloc, UpdateCoordinateState>(
            builder: (context, state) {
              if (state is UpdateCoordinateLoading) {
                return Positioned.fill(
                  child: Container(
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoading) {
                return Positioned.fill(
                  child: Container(
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoading) {
                return Positioned.fill(
                  child: Container(
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
