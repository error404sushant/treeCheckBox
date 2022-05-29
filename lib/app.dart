import 'package:exparement/home/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home':(context)=>const HomeScreen()
        //'/splash':(context)=>const RecommendedStoreScreen()
        //  '/splash':(context)=>BuyerInfoScreen()
        //'/splash':(context)=>BuyerProductCommentScreen()
        // '/splash':(context)=>BuyerOnBoardingDetailScreen()
      },initialRoute: "/home",

    );
  }
}
