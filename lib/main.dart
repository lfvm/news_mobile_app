import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/src/screens/tabs_screen.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';
import 'src/theme/custom_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(create: (_) => NewsService()),

      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Breaking News',
        home: TabsScreen(),
        theme: customAppTheme,
      
      ),
    );
  }
}