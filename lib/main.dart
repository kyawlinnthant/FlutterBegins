import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Ko Ko Kyaw Flutter",
      home: WordGenerator(),
    );
  }
}

class WordGenerator extends StatefulWidget {
  const WordGenerator({Key? key}) : super(key: key);

  @override
  _RandomWordState createState() {
    return _RandomWordState();
  }
}

class _RandomWordState extends State<WordGenerator> {
  final _list = <WordPair>[];

  @override
  Widget build(BuildContext randomWordStateContext) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chit Lar')),
      body: _names(randomWordStateContext),
    );
  }

  Widget _names(BuildContext listContext) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (listContext, dataIndex) {
        if (dataIndex.isOdd) return const Divider();
        final index = dataIndex ~/ 2;
        if (index >= _list.length) {
          _list.addAll(generateWordPairs().take(10));
        }
        return _nameRow(_list[index]);
      },
    );
  }

  Widget _nameRow(WordPair name) {
    return ListTile(
      title: Text(name.asPascalCase),
    );
  }
}
