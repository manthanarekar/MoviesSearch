import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nicc/const/movies_data.dart';

class SearchQuery {
  static var SearchData;
  static List<MoviesData> SearchQureyData = [];

  Future<void> fetchMovieData(String Search) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$Search&include_adult=false&language=en-US&page=1');

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGU2MTg4ODI1ODEzNmIwMzY4YjE0MDRlODRiNjFmOCIsIm5iZiI6MTczMTM4NjU2My44MjQyNjUyLCJzdWIiOiI2NzMyZGEwOTIyNjU1MDQwMWQ4NjUxMDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.5YNeItYJC7bPPSemmpcby1nAAvQOt1fP6nCDMhJNliA',
      },
    );

    if (response.statusCode == 200) {
      SearchData = json.decode(response.body);
      SearchQureyData = [];
      for (var data in SearchData['results']) {
        SearchQureyData.add(MoviesData(
          genres: data['genre_ids'] != '' ? data['genre_ids'] : '',
          img: data['poster_path'] != '' ? data['poster_path'] : '',
          name: data['original_title'] != ''
              ? data['original_title']
              : data['original_title'],
          rating: data['vote_average'] != '' ? data['vote_average'] : '',
        ));
      }
    } else {
      print('Failed to load movie data: ${response.statusCode}');
    }
  }
}
