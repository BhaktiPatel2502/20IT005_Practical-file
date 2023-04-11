import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model1.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Welcome1> welcome1=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Home',style: TextStyle(
            color: Colors.black,
          ),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black,),
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
                  return GridView.builder(
                    itemCount: welcome1.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,

                    ),
                      itemBuilder: (context,index){

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 4,

                            child: Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => home(),));
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 400,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      child: Image.network(
                                        '${welcome1[index].photoUrl}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('${welcome1[index].title}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                                //Text('${welcome[index].title}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),

                              ],

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
              }
          ),
    );
  }


  Future<List<Welcome1>> getData() async{
    final response = await http.get(Uri.parse('https://api.npoint.io/df93d91499110888f29f'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for (Map<String,dynamic> index in data){
        welcome1.add(Welcome1.fromJson(index));
      }
      return welcome1;
    }
    else{
      return welcome1;
    }
  }
}


