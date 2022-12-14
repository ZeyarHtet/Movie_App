import 'package:flutter/material.dart';
import 'package:movie_app/Pages/another_screen.dart';

class MovieList extends StatefulWidget {
  List movieList;
  String title;
  MovieList({
    Key? key,
    required this.movieList,
    required this.title,
  }) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 245,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 125,
                  height: 125,
                  child: Card(
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnotherScreen(
                                  image: widget.movieList[index]["image"],
                                  movieid: widget.movieList[index]["id"],
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Image.network(
                              widget.movieList[index]["image"],
                              width: 150,
                              height: 140,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.movieList[index]["title"],
                            style: const TextStyle(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.movieList[index]["id"].toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
