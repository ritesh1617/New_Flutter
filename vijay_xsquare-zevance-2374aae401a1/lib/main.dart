import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grievance/provider/CompanyProvider.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/provider/ProfileProvider.dart';
import 'package:grievance/utils/my_http_overrides.dart';

import 'provider/AuthProvider.dart';
import 'provider/GrievanceProvider.dart';
import 'routes.dart';
import 'screen/splash.dart';
import 'theme/custom_theme.dart';
import 'theme/style.dart';
import 'utils/constants.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(
    const CustomTheme(
      initialThemeKey: AppThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
          ChangeNotifierProvider<GrievanceProvider>(create: (context) => GrievanceProvider()),
          ChangeNotifierProvider<ProfileProvider>(create: (context) => ProfileProvider()),
          ChangeNotifierProvider<CompanyProvider>(create: (context) => CompanyProvider()),
          ChangeNotifierProvider<PeopleProvider>(create: (context) => PeopleProvider()),
        ],
        child: MaterialApp(
          supportedLocales: const [
            Locale('en'),
          ],
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          title: 'Zevance',
          theme: CustomTheme.of(context),
          home: const Splash(),
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder = route(settings: settings)[settings.name]!;
            return MaterialPageRoute(builder: (ctx) => builder(ctx));
          },
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
        ),
      ),
    );
  }
}
