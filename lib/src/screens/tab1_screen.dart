import 'package:flutter/material.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';
import '../widgets/loading_view.dart';


class Tab1Screen extends StatefulWidget {

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    bool isLoading = newsService.isLoading;

    return Scaffold(
      body: isLoading ? LoadingView() : NewsList(news: newsService.headlines)
   );
  }



  //Hacer que la posicion del scroll se mantenga al regresar a la pagina
  @override
  bool get wantKeepAlive => true;
}

