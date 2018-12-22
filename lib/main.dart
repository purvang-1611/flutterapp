import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.red
    ),
    home: HomePhoto('Home'),
  ));
}

class HomePhoto extends StatefulWidget {

  final String title;

  HomePhoto(this.title);

  @override
  HomePhotoState createState() {
    return new HomePhotoState();
  }
}

class HomePhotoState extends State<HomePhoto> {

  Future<String> getData() async {
    var url = 'https://api.unsplash.com/photos/random/?client_id=8f57b670419dceb997d8440dd5b2aa3907bd9f8f720740b452722d23218b6e2f';
    String ret;
    var res = http.get(url).then((data) {
      if (data.statusCode == 200) {
        ret = json.decode(data.body)['urls']['full'];
      }
      return ret;
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}'),
          centerTitle: true,
        ),
        body: FutureBuilder<String>(future: getData(),builder: (context,snapshot){
          if(snapshot.hasData) {
            return Image.network(snapshot.data,fit: BoxFit.cover,);
          }
          else{
            return Center(child: CircularProgressIndicator());
          }

        }),
        floatingActionButton:
        FloatingActionButton(child: Icon(Icons.add), onPressed: () {
          setState(() {});
        }),

      );
    }
  }