import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ko Ko Kyaw Flutter",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1
        ),
      ),
      home: const WordGenerator(),
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
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext randomWordStateContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chit Lar'),
        leading: const Icon(Icons.add),
        actions: [
          IconButton(onPressed: _clickMenu, icon: const Icon(Icons.menu))
        ],
      ),
      body: _names(randomWordStateContext),
    );
  }

  void _clickMenu() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final title = _saved.map((e) => ListTile(
            title: Text(e.asPascalCase),
          ));

      final divided = title.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: title,
            ).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('This is second page'),
        ),
        body: ListView(children: divided),
      );
    }));
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
    final isAdySaved = _saved.contains(name);
    return ListTile(
      title: Text(
        name.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        isAdySaved ? Icons.favorite : Icons.favorite_border,
        color: isAdySaved ? Colors.red : null,
        semanticLabel: isAdySaved ? 'Remove from list' : 'Save to list',
      ),
      leading: const Icon(Icons.start),
      onTap: () {
        setState(() {
          if (isAdySaved) {
            _saved.remove(name);
          } else {
            _saved.add(name);
          }
        });
      },
    );
  }
}
