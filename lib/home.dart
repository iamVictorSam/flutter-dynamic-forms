import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _formCount = 0;
  final List<Map<String, dynamic>> _values = [];
  String? _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text('Name of Programming Languages',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 22)),
              const SizedBox(height: 20),
              ...List.generate(_formCount, (index) => form(index)),
              buttonRow(),
              const SizedBox(height: 10),
              Visibility(visible: _values.isNotEmpty, child: Text(_data!)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Padding form(int key) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          decoration: InputDecoration(hintText: 'Form ${key + 1}'),
          onChanged: (val) => _onUpdate(key, val),
        ),
      );

  Row buttonRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: _formCount > 0,
            child: IconButton(
                onPressed: () {
                  if (_values.isNotEmpty) {
                    _values.removeAt(_values.length - 1);
                  }
                  setState(() {
                    _data = _values.toString();
                    _formCount--;
                  });
                },
                icon: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.remove,
                  ),
                )),
          ),
          IconButton(
              onPressed: () {
                setState(() => _formCount++);
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.add,
                ),
              )),
        ],
      );

  void _onUpdate(int key, String val) {
    void addData() {
      Map<String, dynamic> json = {'id': key, 'value': val};
      _values.add(json);
      setState(() {
        _data = _values.toString();
      });
    }

    if (_values.isEmpty) {
      addData();
    } else {
      for (var map in _values) {
        if (map["id"] == key) {
          _values[key]['value'] = val;
          setState(() {
            _data = _values.toString();
          });
          break;
        }
      }

      for (var map in _values) {
        for (var map in _values) {
          if (map["id"] == key) {
            return;
          }
        }
        addData();
      }
    }
  }
}
