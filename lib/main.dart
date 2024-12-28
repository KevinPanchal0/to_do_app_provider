import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app_provider/view_model/to_do_view_model.dart';
import 'package:to_do_app_provider/views/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ToDoViewModel(),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange,
          scaffoldBackgroundColor: Colors.yellow[200],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.yellow,
          ),
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => HomePage(),
        },
      ),
    );
  }
}
