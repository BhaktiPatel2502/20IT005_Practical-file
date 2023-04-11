import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'model1.dart';

class descryption extends StatefulWidget {
  const descryption({Key? key}) : super(key: key);

  @override
  State<descryption> createState() => _descryptionState();
}

class _descryptionState extends State<descryption> {
  List<Welcome1> welcome1 = [];
  // late String photosArray = "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');

            } else {
              return Column(
                children: [
                  CarouselSlider.builder(
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '${welcome1[index].photosArray[0]}'),
                            fit: BoxFit.fitHeight,
                          ),
                          //color: Colors.red,
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 0.3,
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 2000),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 200,
                    ),
                    itemCount: 10,
                  ),
                  ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                            color: Colors.black,
                            height: 100,
                            width: 100,
                            child: Text(
                              "${welcome1[index].title}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ));
                      })
                ],
              );

            }
          },
        ),
      ),
    );
  }

  Future<List<Welcome1>> getData() async {
    final response =
        await http.get(Uri.parse('https://api.npoint.io/df93d91499110888f29f'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        welcome1.add(Welcome1.fromJson(index));
      }
      return welcome1;
    } else {
      return welcome1;
    }
  }
}
