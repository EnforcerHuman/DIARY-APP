import 'package:diary_app/config/routes/app_routes.dart';
import 'package:diary_app/config/routes/routes_name.dart';
import 'package:diary_app/core/constants/navigator_key.dart';
import 'package:diary_app/core/service_locator/service_locator.dart';
import 'package:diary_app/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:diary_app/features/settings/presentation/bloc/settings_user_profile/setting_user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootWidgetPage extends StatelessWidget {
  const RootWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthenticationBloc>()
            ..add(
              CheckUserLoggedInEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SettingUserProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Alegreya Sans SC'),
        initialRoute: AppRouteName.wrapperPage,
        routes: AppRoutes.routes,
      ),
    );
  }
}
