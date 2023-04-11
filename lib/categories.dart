import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'model.dart';

class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  List<Welcome> welcome=[];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Categories',style: TextStyle(
            color: Colors.black,
          ),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: (){
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Report()));
            }
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: welcome.length,
                itemBuilder: (context,index){
                  return Container(
                    height: 250,
                    width: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 4,

                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => home(),));
                            },
                            child: Container(
                              height: 200,
                              width: 400,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Image.network(
                                  '${welcome[index].photoUrl}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('${welcome[index].name}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                        ],

                      ),

                    ),
                  );
                }
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),


    );
  }
  Future<List<Welcome>> getData() async{
    final response = await http.get(Uri.parse('https://api.npoint.io/0788666ac40252d2a9b4'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for (Map<String,dynamic> index in data){
        welcome.add(Welcome.fromJson(index));
      }
      return welcome;
    }
    else{
      return welcome;
    }
  }
}

