import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:mood/app/bloc/app_bloc.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';
import 'package:mood/ui/page/base_tab_container.dart';
import 'package:mood/ui/page/login/firebase/login_page.dart';
import 'package:mood/ui/page/login/moodapi/api_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(MoodApp(authenticationRepository: authenticationRepository));
}

class MoodApp extends StatelessWidget {
  const MoodApp({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: MoodAppView(auth: _authenticationRepository),
      ),
    );
  }
}

class MoodAppView extends StatelessWidget {
  const MoodAppView({Key? key, required this.auth}) : super(key: key);

  final AuthenticationRepository auth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: (AppStatus state, List<Page<dynamic>> pages) {
          print('Appt state: ${state}');
          switch (state) {
            case AppStatus.authenticated:
              // return [MaterialPage<void>(child: BaseTabContainer(auth: auth))];
              return [const MaterialPage<void>(child: APIPage())];
            case AppStatus.unauthenticated:
              return [const MaterialPage<void>(child: LoginPage())];
            default:
              return [const MaterialPage<void>(child: LoginPage())];
          }
        },
      ),
    );
  }
}
