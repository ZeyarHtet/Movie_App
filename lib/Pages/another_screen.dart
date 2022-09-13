import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class AnotherScreen extends StatefulWidget {
  String image;
  int movieid;
  AnotherScreen({super.key, required this.image, required this.movieid});

  @override
  State<AnotherScreen> createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {
  List artistList = [];
  @override
  void initState() {
    getartist();
    super.initState();
  }

  getartist() async {
    print(">>>>>>> movieid ${widget.movieid}");

    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/${widget.movieid}/credits?api_key=050c28541f900007285c3020069bfd62'),
    );

    if (response.statusCode == 200) {
      var movieResponse = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        artistList = movieResponse["cast"];
        print(movieResponse);
      });
    } else {
      print("something wrong....");
      print(response.statusCode);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          "What do you watch?",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.network(
              widget.image,
              width: 250,
              height: 250,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.movieid.toString(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: artistList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(
                        //     "https://image.tmdb.org/t/p/w200${artistList[index]["profile_path"]}",
                        //   ),
                        // ),

                        CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w200${artistList[index]["profile_path"]}",
                            height: 70,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),

                            // errorWidget: (context, url, error) => Icon(Icons.person),
                            errorWidget: (context, url, error) => const Image(
                                image: AssetImage("images/person.png"))),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artistList[index]["original_name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Column(
                              children: [
                                Text(
                                  artistList[index]["character"],
                                  style: const TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
