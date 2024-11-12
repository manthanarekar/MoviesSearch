import 'package:flutter/material.dart';
import 'package:nicc/api/popular_movies.dart';
import 'package:nicc/colors/colors.dart';
import 'package:nicc/elements/main_home.dart';
import 'package:nicc/widget/text_fields.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      await PopularMoviesGetData().fetchNowPlayingMovies();
    } catch (e) {
      print("Error fetching movies: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.Grey,
            elevation: 0,
            title: Center(child: HeadText('MoviesRating'))),
        backgroundColor: AppColors.Grey,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : const MainHome(),
      ),
    );
  }
}
