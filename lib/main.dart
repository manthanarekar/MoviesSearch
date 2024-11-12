import 'package:flutter/material.dart';
import 'package:nicc/api/popular_movies.dart';
import 'package:nicc/colors/colors.dart';
import 'package:nicc/elements/main_home.dart';

void main() async {
  await PopularMoviesGetData().fetchNowPlayingMovies();
  runApp(Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    print(screenwidth);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.Grey,
        body: MainHome(),
      ),
    );
  }
}
