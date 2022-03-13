import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/custom_theme.dart';


class NewsList extends StatelessWidget {

  final List<Article> news;
  NewsList({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      itemCount: news.length,
      itemBuilder: (_, int i) {

        return NewsContainer( news: news[i], index: i,);

      },

    );

  }
}

class NewsContainer extends StatelessWidget {

  final Article news;
  final int index;
  NewsContainer({ required this.index, required this.news });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        _NewsHeader(news: news,index: index,),
        _NewsTitle(news: news),
        _NewsImage(news: news),
        _NewsBody(news: news),
        _NewsButtons(),

        SizedBox( height: 10,),
        Divider(),

      ],


    );
  }
}

class _NewsHeader extends StatelessWidget {
  final Article news;
  final int index;

  _NewsHeader({
    required this.news,
    required this.index  
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [

          Text(
            "${index + 1 }. ",
            style: TextStyle( color: customAppTheme.colorScheme.secondary ),
          ),

          Text(
            "${news.source.name}.",
          ),
        ]
      ),

    );
  }
}





class _NewsTitle extends StatelessWidget {
  final Article news;

  _NewsTitle({
    required this.news,
  });

  @override
  Widget build(BuildContext context) {

    final text = news.title != null ? news.title :'';
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(text!, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)

    );
  }
}




class _NewsImage extends StatelessWidget {
  final Article news;

  _NewsImage({
    required this.news,
  });

  @override
  Widget build(BuildContext context) {

    final String image = news.urlToImage ?? '';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: image == '' 
          ? Image.asset('assets/no-image.png')
          : FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(image),
          ),
      
        ),
      ),
    );
  }
}




class _NewsBody extends StatelessWidget {

  final Article news;

  _NewsBody({
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 16),

      child: Text(
        news.description != null ? news.description! : '',
        style: TextStyle(),
      ),


    );
  }
}



class _NewsButtons extends StatelessWidget {
  const _NewsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: customAppTheme.colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),  

          SizedBox( width: 16,),

          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          ),
        ],
      ),
      
    );
  }
}