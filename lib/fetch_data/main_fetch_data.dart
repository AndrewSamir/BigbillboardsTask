import 'dart:convert';

import 'package:first_flutter_app/fetch_data/products.dart';
import 'package:first_flutter_app/fetch_data/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List<Product> list = List();

//  Response res;
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("http://pharaohsland.tours/tasawk/api/products");
    if (response.statusCode == 200) {
      var res = (json.decode(response.body));
      var rest = res["data"] as List;
      /*res = (json.decode(response.body) as List)
          .map((data) => new Response.fromJson(data))
          .toList();*/
      list = rest.map<Product>((json) => Product.fromJson(json)).toList();

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bigbillboards"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: _fetchData,
          ),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(list[index].title),
                trailing: new Image.network(
                  list[index].photo,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              );
            }));
  }
}
