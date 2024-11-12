import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectionAndFetchMovies();
  }

  Future<void> _checkConnectionAndFetchMovies() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
        isLoading = false;
      });
    } else {
      await _fetchMovies();
    }
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
          title: Center(child: HeadText('MoviesRating')),
          backgroundColor: AppColors.Grey,
          elevation: 0,
        ),
        backgroundColor: AppColors.Grey,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : isConnected
                ? const MainHome()
                : const Center(
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
      ),
    );
  }
}
