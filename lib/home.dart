import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _formCount = 0;
  List<Map<String, dynamic>>? _values;
  String? _result;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _formCount = 0;
    _values = [];
    _result = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          setState(() {
            _formCount++;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text('Name of Programming Languages',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontSize: 22)),
            ...List.generate(_formCount, (index) => _row(index)),
            const SizedBox(height: 10),
            Text(_result!),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _row(int key) {
    return Row(
      children: [
        Text('ID: $key'),
        const SizedBox(
          width: 30,
        ),
        Expanded(child: TextFormField(
          onChanged: (val) {
            _onUpdate(key, val);
          },
        )),
      ],
    );
  }

  _onUpdate(int key, String val) {
    void addJson() {
      Map<String, dynamic> json = {'id': key, 'value': val};
      _values!.add(json);
      setState(() {
        _result = _values.toString();
      });
    }

    if (_values!.isEmpty) {
      addJson();
    } else {
      for (var map in _values!) {
        if (map["id"] == key) {
          _values![key]['value'] = val;
          setState(() {
            _result = _values.toString();
          });
          break;
        }
      }

      for (var map in _values!) {
        for (var map in _values!) {
          if (map["id"] == key) {
            return;
          }
        }
        addJson();
      }
    }
  }
}
