import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;


class NewsService extends ChangeNotifier {

  //Valores para llamar a la api
  final String _NEWS_URL = 'newsapi.org';
  final String _API_KEY = dotenv.env['API_KEY'] ?? '';


  //Lista de noticias
  List<Article> headlines = [];

  List<Categroy> categories = [
    Categroy(icon: FontAwesomeIcons.building, name: 'business'),
    Categroy(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Categroy(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Categroy(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Categroy(icon: FontAwesomeIcons.vials, name: 'science'),
    Categroy(icon: FontAwesomeIcons.footballBall, name: 'sports'),
    Categroy(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  bool isLoading = true;


  //Getter y setter para categoria seleccionada
  String _selectedCategory = 'business';
  String get selectedCategory => _selectedCategory;
  List<Article> get selectedCategoryItems => newsByCategorie[_selectedCategory]!;

  set selectedCategory (String value ) {
    _selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  //Mapa de noticas por categoria
  Map<String,List<Article>> newsByCategorie = {};


  //Constructor
  NewsService () {

    getTopHeadlines();

    //Inicializar el mapa de categorias 
    categories.forEach((element) {

      newsByCategorie[element.name] =  [];
    });

  }


  getTopHeadlines () async {

    isLoading = true;
    notifyListeners();


    //Definir url junto con los parametros de busqueda
    final url = Uri.https( _NEWS_URL, '/v2/everything', {
      'domains' : 'wsj.com', 'apiKey' : _API_KEY,
    });

    //Llamar y parsear el request

    final response = await http.get(url);
    final newsResponse = NewsResponse.fromJson(response.body);


    //Llenar la lista con los articulos del response
    headlines.addAll( newsResponse.articles );
    isLoading = false;
    notifyListeners();

  }

  getArticlesByCategory ( String category ) async {


    if (newsByCategorie[category]!.length > 0 ){
      return newsByCategorie[category];
    }
 

    isLoading = true;
    notifyListeners();


    //Definir url junto con los parametros de busqueda
    final url = Uri.https( _NEWS_URL, '/v2/top-headlines', {
      'category' : category, 'apiKey' : _API_KEY,
    });

    //Llamar y parsear el request

    final response = await http.get(url);
    final newsResponse = NewsResponse.fromJson(response.body);

    //Llenar el arreglo en el mapa de categorias con las noticias correspondientes 
    newsByCategorie[category]!.addAll( newsResponse.articles );
    isLoading = false;
    notifyListeners();


  }


}