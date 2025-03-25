import 'package:flutter/material.dart';
import 'package:world_countries/country.dart';

class CountryDetailPage extends StatelessWidget {
  final Ulke _ulke;
  CountryDetailPage(this._ulke);
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        _ulke.isim,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.blueGrey,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: double.infinity, height: 32),
        _buildBayrak(context),
        SizedBox(height: 24),
        _buildUlkeIsmiText(),
        SizedBox(height: 24),
        _buildTumDetaylar(),
      ],
    );
  }

  Widget _buildTumDetaylar() {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Column(
        children: [
          _buildUlkeDetayRow("Ülke İsmi: ", _ulke.isim),
          _buildUlkeDetayRow("Başkent: ", _ulke.baskent),
          _buildUlkeDetayRow("Bölge: ", _ulke.bolge),
          _buildUlkeDetayRow("Nüfus: ", _ulke.nufus.toString()),
          _buildUlkeDetayRow("Dil: ", _ulke.dil),
        ],
      ),
    );
  }

  Widget _buildBayrak(BuildContext context) {
    return Image.network(
      _ulke.bayrak,
      width: MediaQuery.sizeOf(context).width / 2,
    );
  }

  Widget _buildUlkeIsmiText() {
    return Text(
      _ulke.isim,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildUlkeDetayRow(String baslik, String detay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            baslik,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(flex: 3, child: Text(detay, style: TextStyle(fontSize: 24))),
      ],
    );
  }
}
