import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:world_countries/ulke.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population";

  List<Ulke> _butunUlkeler = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ulkeleriInternettenCek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Text('World Countries', style: TextStyle(fontSize: 30)),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return _butunUlkeler.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemBuilder: _buildListItem,
          itemCount: _butunUlkeler.length,
        );
  }

  Widget? _buildListItem(BuildContext context, int index) {
    Ulke ulke = _butunUlkeler[index];
    return Card(
      child: ListTile(
        title: Text(ulke.isim),
        subtitle: Text("Başkent: ${ulke.baskent} "),
        leading: CircleAvatar(backgroundImage: NetworkImage(ulke.bayrak)),
        trailing: Icon(Icons.favorite_border, color: Colors.red),
      ),
    );
  }

  void _ulkeleriInternettenCek() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);

    for (int i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponse[i];

      Ulke ulke = Ulke.fromMap(ulkeMap);
      _butunUlkeler.add(ulke);
    }

    setState(() {});
  }
}
