import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';
import '../widgets/loading_view.dart';
import '../widgets/news_list.dart';



class Tab2Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    bool isLoading = newsService.isLoading;

    return SafeArea(
      child: Scaffold(
    
    
        body: Column(
          children: [
    
            _CategoryMenu(),
            isLoading ? Expanded(child: LoadingView()) : Expanded(child: NewsList(news: newsService.selectedCategoryItems) )
    
          ],
        ),      
      ),
    );
  }
}

class _CategoryMenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Container(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: newsService.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          
          final name = newsService.categories[index].name;

          return Container(
            width: 110,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
          
                  _CategoryButton(categroy: newsService.categories[index] ),
                  SizedBox(height: 5,),
                  Text( '${name[0].toUpperCase()}${name.substring(1)}' )
          
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Categroy categroy;

  _CategoryButton({Key? key, required this.categroy});



  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){


        newsService.selectedCategory = categroy.name;

      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
    
        child: Icon( 
          categroy.icon, 
          color: newsService.selectedCategory == categroy.name 
            ? Colors.red
            : Colors.black
        ),
    
      ),
    );
  }
}
