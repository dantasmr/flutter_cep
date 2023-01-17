import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cepController = TextEditingController();
  String rua = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: cepController,
              decoration: InputDecoration(
                hintText: 'Insira o CEP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final response = await http.get(Uri.parse(
                    'https://viacep.com.br/ws/${cepController.text}/json/'));
                if (response.statusCode == 200) {
                  final data = json.decode(response.body);
                  setState(() {
                    rua = data['logradouro'];
                  });
                }
              },
              child: Text('Consultar'),
            ),
            SizedBox(height: 16.0),
            Text(rua),
          ],
        ),
      ),
    );
  }
}
