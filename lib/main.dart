import 'dart:async';

import 'package:bawo/data/cache/user.cache.dart';
import 'package:bawo/data/remote/user_remote/user_remote.dart';
import 'package:bawo/ui/routes/routes.dart';
import 'package:bawo/ui/splash/splash.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'data/cache/user_cache_impl.dart';
import 'data/core/config.dart';
import 'data/remote/models/article/articles.dart';
import 'data/remote/user_remote/user_remote_impl.dart';
import 'data/repository/user_repository.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/viewmodel/event_view_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDb();
  await Hive.initFlutter();
  Config.appFlavor = Flavor.DEVELOPMENT;
  setupLocator();
  runZonedGuarded(() {
    runApp(ProviderScope(child: MyApp()));
  }, (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stears',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}

GetIt locator = GetIt.instance;

void setupLocator() {
  setupDio();
  locator.registerFactory<UserCache>(() => UserCacheImpl());
  locator.registerFactory<UserRemote>(() => UserRemoteImpl(locator<Dio>()));
  locator.registerFactory<UserRepository>(
          () => UserRepositoryImpl(locator<UserRemote>(), locator<UserCache>()));
  registerViewModels();
  setupNotification();
}

void setupDio() {
  locator.registerFactory(() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  });
}

void registerViewModels() {
  locator.registerFactory(() => EventViewModel());
}

void setupNotification() {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("22995461-4fd0-44ae-b4c1-b72d4852cbc1");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
}

Future<void> setupDb() async {
  Hive.registerAdapter<Article>(ArticleAdapter());
  Hive.registerAdapter<Author>(AuthorAdapter());
  }
