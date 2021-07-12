import 'package:flutter/material.dart';
import 'package:login_uygulamasi/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnaSayfa extends StatefulWidget {

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  late String spKullaniciAdi;
  late String spSifre;


  Future<void> oturumBilgisiOku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniciAdi = sp.getString("kullaniciAdi") ?? "Kullanıcı Adı Yok";
      spSifre = sp.getString("sifre") ?? "Şifre Yok";
    });

  }

  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();

    sp.remove("kullaniciAdi");
    sp.remove("sifre");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginEkrani()));

    }

    @override
    void initState() {
      super.initState();
      oturumBilgisiOku();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("AnaSayfa"),
          actions: [
            IconButton(onPressed: () {
              cikisYap();
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Kullanıcı Adı: $spKullaniciAdi",
                  style: TextStyle(fontSize: 30),),
                Text("Şifre: $spSifre", style: TextStyle(fontSize: 30),),
              ],
            ),
          ),
        ),

      );
    }
  }
