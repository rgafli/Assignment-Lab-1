import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "Name of Country: No Data Available";
  String capital = "Capital City of Country: No Data Available";
  String currency = "Currency of Country: No Data Available";
  Uri image1 = Uri.parse(
      'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
  TextEditingController nameCountry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text(
          "INFORMATION OF COUNTRY",
        ),
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Search Country",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Name of Country",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              controller: nameCountry,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                onPressed();
              },
              child: const Text("Search the country")),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            width: 350,
            decoration: BoxDecoration(border: Border.all()),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    width: 60,
                    image: NetworkImage('$image1'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 14)),
                      Text(capital, style: const TextStyle(fontSize: 14)),
                      Text(currency, style: const TextStyle(fontSize: 14))
                    ],
                  )
                ],
              ),
            ]),
          )
        ]),
      ),
    ));
  }

  Future<void> onPressed() async {
    String cntryName = nameCountry.text;
    var apiid = "hF7gO7hnRHogTh3O5V236Q==3s8hKllDvsKx751r";
    Uri url =
        Uri.parse('https://api.api-ninjas.com/v1/country?name=$cntryName');
    var response = await http.get(url, headers: {'X-Api-Key': apiid});
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      if (parsedJson.toString() == '[]') {
        setState(() {
          name = "Name of Country: No Data Avaiable";
          capital = "Capital City of Country: No Data Available";
          currency = "Currency of Country: No Data Avaialable";
          image1 = Uri.parse(
              'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
        });
      } else {
        setState(() {
          var cap = parsedJson[0]['capital'];
          var curr = parsedJson[0]['currency']['name'];
          var iso = parsedJson[0]['iso2'];
          name = "Name of Country: $cntryName";
          capital = "Capital City of Country: $cap";
          currency = "Currency of Country: $curr";
          image1 = Uri.parse('https://flagsapi.com/$iso/flat/64.png');
        });
      }
    } else {
      setState(() {
        name = "Name of Country: No Data Avaiable";
        capital = "Capital City of Country: No Data Available";
        currency = "Currency of Country: No Data Avaialable";
        image1 = Uri.parse(
            'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
      });
    }
  }
}
