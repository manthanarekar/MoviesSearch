import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nicc/const/movies_data.dart';

class PopularMoviesGetData {
  static var responseData;
  static List<MoviesData> popularMovies = [];

  Future<void> fetchNowPlayingMovies() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1');

    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGU2MTg4ODI1ODEzNmIwMzY4YjE0MDRlODRiNjFmOCIsIm5iZiI6MTczMTM4NjU2My44MjQyNjUyLCJzdWIiOiI2NzMyZGEwOTIyNjU1MDQwMWQ4NjUxMDciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.5YNeItYJC7bPPSemmpcby1nAAvQOt1fP6nCDMhJNliA',
      },
    );

    if (response.statusCode == 200) {
      responseData = jsonDecode(response.body);

      if (popularMovies.isEmpty) {
        for (var data in responseData['results']) {
          popularMovies.add(MoviesData(
            genres: data['genre_ids'] != '' ? data['genre_ids'] : '',
            img: data['poster_path'] != '' ? data['poster_path'] : '',
            name: data['original_title'] != ''
                ? data['original_title']
                : data['original_title'],
            rating: data['vote_average'] != '' ? data['vote_average'] : '',
          ));
        }
      }
    } else {
      print('Not Geting Output.. PopularMoviesAPi ${response.statusCode}');
    }
  }
}
