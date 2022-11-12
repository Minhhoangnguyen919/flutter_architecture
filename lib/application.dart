import 'package:develop_app_hoangnm/core/data/share_preference/spref_user_model.dart';
import 'package:develop_app_hoangnm/view_models/application_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/l10n/strings.dart';
import 'core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'core/utils/log_utils.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  //TODO kWidgetGroupId
  final String kWidgetGroupId = "";
  final ApplicationViewModel _applicationViewModel = ApplicationViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inItSPrefUser();
    });
  }

  Future<void> inItSPrefUser() async {
    await SPrefUserModel().onInit();
  }

  void _onBuildCompleted(Duration timestamp) {
    LogUtils.d("onBuildCompleted");
  }

  @override
  Widget build(BuildContext context) {
    return _buildApplication();
  }

  Widget _buildApplication() {
    return ChangeNotifierProvider<ApplicationViewModel>(
      create: (_) => _applicationViewModel,
      child: MaterialApp(
        onGenerateTitle: (context) => "Name project",
        theme: ThemeData(
          unselectedWidgetColor: Colors.white,
        ),
        localizationsDelegates: const [
          _MyLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ja', 'JP'),
        ],
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (deviceLocale != null) {
              if (supportedLocale.languageCode == deviceLocale.languageCode) {
                if (supportedLocale.countryCode == deviceLocale.countryCode ||
                    supportedLocale.scriptCode == deviceLocale.scriptCode) {
                  return Locale(supportedLocale.languageCode,
                      supportedLocale.countryCode);
                }
              }
            }
          }
          // If the locale of the device is not supported set default English
          return const Locale('en');
        },
        initialRoute: TopScreenNavigatorRoutes().initialRoute(),
        onGenerateRoute: TopScreenNavigatorRoutes().routeBuilders,
      ),
    );
  }

  @override
  void dispose() {
    LogUtils.d("app killed ...");
    _applicationViewModel.destroySingletonObject();
    super.dispose();
  }
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Strings> old) => false;
}
