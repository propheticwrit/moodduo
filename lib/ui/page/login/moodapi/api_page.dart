import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';
import 'package:mood/ui/page/base_tab_container.dart';
import 'package:mood/ui/page/login/firebase/login_page.dart';
import 'package:mood/ui/page/login/moodapi/cubit/api_cubit.dart';

class APIPage extends StatelessWidget {
  const APIPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiCubit(
          authenticationRepository: context.read<AuthenticationRepository>()),
      child: const APIContainer(),
    );
  }
}

class APIContainer extends StatelessWidget {
  const APIContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ApiCubit>(context).logInWithMoodAPI();

    return BlocBuilder<ApiCubit, ApiState>(
      builder: (context, state) {
        if (state is APILoginInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is APILoginSuccessful) {
          return const BaseTabContainer();
        } else {
          context.read<AuthenticationRepository>().logOut();
          return const Center(child: LoginPage());
        }
      },
    );
  }
}
