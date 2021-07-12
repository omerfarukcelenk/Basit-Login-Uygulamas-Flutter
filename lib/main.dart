import 'package:flutter/material.dart';
import 'package:login_uygulamasi/AnaSayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

    String spKullaniciAdi = sp.getString("kullaniciAdi") ?? "Kullanıcı Adı Yok";
    String  spSifre = sp.getString("sifre") ?? "Şifre Yok";
    if(spKullaniciAdi == "admin" && spSifre == "123"){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool gecisIzni = snapshot.data!;
            return gecisIzni ? AnaSayfa() : LoginEkrani();
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {

  @override
  _LoginEkraniState createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {


  final snacbar = SnackBar(content: Text("GİRİŞ HATALI"));
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if(ka == "admin" && s == "123"){
      var sp = await SharedPreferences.getInstance();

      sp.setString("kullaniciAdi", ka);
      sp.setString("sifre", s);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AnaSayfa()));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GİRİŞ HATALI")));
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextField(
                controller: tfKullaniciAdi,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                ),
              ),

              TextField(
                obscureText: true,
                controller: tfSifre,
                decoration: InputDecoration(
                  hintText: "Şifre",
                ),
              ),

              ElevatedButton(onPressed: (){
                girisKontrol();
              }, child: Text("Giriş Yap"))
            ],
          ),
        ),
      ),

    );
  }
}
