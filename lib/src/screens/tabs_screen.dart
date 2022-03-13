import 'package:flutter/material.dart';
import 'package:news_app/src/screens/tab1_screen.dart';
import 'package:news_app/src/screens/tab2_screen.dart';
import 'package:provider/provider.dart';


class TabsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(

        body: _Paginas(),
        bottomNavigationBar: CustomNav(),
       ),
    );
  }
}

class CustomNav extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navProvider = Provider.of<_NavigationModel>(context);


    return BottomNavigationBar(

      onTap: (i) => navProvider.pageIndex = i ,
      currentIndex: navProvider.pageIndex,
      items: [

        BottomNavigationBarItem(icon: Icon(Icons.person_outlined),label: 'For you' ),
        BottomNavigationBarItem(icon: Icon(Icons.public ),label: 'Headlines' ),
        
      ],
      
    );
  }
}



class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navProvider = Provider.of<_NavigationModel>(context);

    return PageView(

      controller: navProvider.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [

        Tab1Screen(),
    
        Tab2Screen()
      ],

    );
  }
}



class _NavigationModel extends ChangeNotifier {
  //Manjeador de estado para el bottom navigation bar


  //Controlador de paginas del pageview
  PageController _pageController = PageController();
  PageController get pageController => _pageController;


  //Indice del BottomNavBar
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex ( int data ){
    _pageIndex = data;

    _pageController.animateToPage(
      data, 
      duration: Duration(milliseconds: 250), 
      curve: Curves.easeOut
    );

    notifyListeners();
  }



  

}