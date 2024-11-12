import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nicc/api/Search_movie_dat.dart';
import 'package:nicc/api/popular_movies.dart';
import 'package:nicc/colors/colors.dart';
import 'package:nicc/const/movies_data.dart';
import 'package:nicc/widget/rating_container.dart';
import 'package:nicc/widget/text_fields.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  TextEditingController MyController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    MyController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () async {
      await SearchQuery().fetchMovieData(MyController.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    MyController.removeListener(_onSearchChanged);
    MyController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadText('Home'),
          const SizedBox(height: 15),
          TextField(
            controller: MyController,
            decoration: InputDecoration(
              labelText: 'Search',
              labelStyle: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: AppColors.Blue2, fontWeight: FontWeight.w500),
              ),
              suffixIcon: const Icon(Icons.search_rounded, size: 25),
              suffixIconColor: AppColors.Blue2,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(
                  color: AppColors.Blue2,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(
                  color: AppColors.Blue2,
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: MyController.text.isEmpty
                    ? PopularMoviesGetData.popularMovies.length
                    : SearchQuery.SearchQureyData.length,
                itemBuilder: (context, index) {
                  List<MoviesData> ShowMovies = MyController.text.isEmpty
                      ? PopularMoviesGetData.popularMovies
                      : SearchQuery.SearchQureyData;

                  if (index >= ShowMovies.length) {
                    return const SizedBox();
                  }

                  try {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: DesingCard(index, ShowMovies),
                    );
                  } catch (e) {
                    print('Error occurred while building the list item: $e');
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack DesingCard(int index, List<MoviesData> ShowMovies) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: AppColors.White,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 170),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 30,
                                width: 210,
                                child: TitleText(ShowMovies[index].name)),
                          ],
                        ),
                        GenresText(ShowMovies[index].genres),
                        const SizedBox(height: 10),
                        RatingContainer(
                            ShowMovies[index].rating > 7
                                ? AppColors.Green
                                : AppColors.Blue,
                            ShowMovies[index].rating),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, bottom: 10),
          height: 180,
          width: 140,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w200/${ShowMovies[index].img}'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
