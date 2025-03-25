import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_countries/country.dart';
import 'package:world_countries/country_detail_page.dart';

class OrtakListe extends StatefulWidget {
  List<Ulke> _ulkeler = [];

  List<String> _favoriUlkeKodlari = [];

  OrtakListe(this._ulkeler, this._favoriUlkeKodlari);

  @override
  State<OrtakListe> createState() => _OrtakListeState();
}

class _OrtakListeState extends State<OrtakListe> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildListItem,
      itemCount: widget._ulkeler.length,
    );
  }

  Widget? _buildListItem(BuildContext context, int index) {
    Ulke ulke = widget._ulkeler[index];
    return Card(
      child: ListTile(
        title: Text(ulke.isim),
        subtitle: Text("Başkent: ${ulke.baskent} "),
        leading: CircleAvatar(backgroundImage: NetworkImage(ulke.bayrak)),
        trailing: IconButton(
          onPressed: () {
            _favoriTiklandi(ulke);
          },
          icon: Icon(
            widget._favoriUlkeKodlari.contains(ulke.ulkeKodu)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
        onTap: () {
          _ulkeTiklandi(context, ulke);
        },
      ),
    );
  }

  void _ulkeTiklandi(BuildContext context, Ulke ulke) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return CountryDetailPage(ulke);
      },
    );
    Navigator.push(context, sayfaYolu);
  }

  void _favoriTiklandi(Ulke ulke) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget._favoriUlkeKodlari.contains(ulke.ulkeKodu)) {
      widget._favoriUlkeKodlari.remove(ulke.ulkeKodu);
    } else {
      widget._favoriUlkeKodlari.add(ulke.ulkeKodu);
    }
    await prefs.setStringList("favoriler", widget._favoriUlkeKodlari);

    setState(() {});
  }
}
