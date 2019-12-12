import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  // list of word pair
  final randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();
  final wordPair = WordPair.random();

  Widget _buildList() => ListView.builder(
   padding: const EdgeInsets.all(16.0),
   itemBuilder: (context, item) {
     if(item.isOdd) return Divider();
     final index = item ~/ 2;
     if(index >= randomWordPairs.length) {
       randomWordPairs.addAll(generateWordPairs().take(10));
     }
     return _buildRow(randomWordPairs[index], Icons.favorite);
   }
  );

  // Widget of row with Word
  Widget _buildRow(WordPair pair,IconData icon) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        // when tap on the icon
        onTap: () {
          setState(() {
            if(alreadySaved) {
              _savedWordPairs.remove(pair);
            } else {
              _savedWordPairs.add(pair);
            }
          });
        },
      );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
            return ListTile(
              title: Text(pair.asLowerCase,
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            );
          });

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Wordpairs'),
            ),
            body: ListView(
              children: divided,
            ),
          );
        }
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wordpair Generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildList()
    );
  }
}