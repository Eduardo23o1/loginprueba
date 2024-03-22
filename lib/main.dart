import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loguinprueba/config/color_schemes.g.dart';
import 'package:loguinprueba/firebase_options.dart';
import 'package:loguinprueba/login_view.dart';

Future main() async {
  await setupApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: lightColorScheme),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}

Future setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await _precachedImages();
}

/*Future _precachedImages() async {
  var images = ["logo.svg", "carpa.svg", "carpa2.svg", "cliente.svg"];
  for (String image in images) {
    final SvgAssetLoader loader = SvgAssetLoader("assets/images/$image");
    await svg.cache
        .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
  }
}*/
