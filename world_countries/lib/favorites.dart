import 'package:flutter/material.dart';
import 'package:world_countries/common_list.dart';
import 'package:world_countries/country.dart';

class Favoriler extends StatefulWidget {
  @override
  final List<Ulke> _butunUlkeler;

  final List<String> _favoriUlkeKodlari;

  Favoriler(this._butunUlkeler, this._favoriUlkeKodlari);

  @override
  State<Favoriler> createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  List<Ulke> _favoriUlkeler = [];

  @override
  void initState() {
    super.initState();
    for (Ulke ulke in widget._butunUlkeler) {
      if (widget._favoriUlkeKodlari.contains(ulke.ulkeKodu)) {
        _favoriUlkeler.add(ulke);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Text(
        "Favorites",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return OrtakListe(_favoriUlkeler, widget._favoriUlkeKodlari);
  }
}
