import 'package:flutter/material.dart';
import 'package:memes/src/models/api_response.dart';

class MemesSearch extends SearchDelegate {
  final List<Meme> memes;

  List<Meme> _filter = [];

  MemesSearch(this.memes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query = '', icon: const Icon(Icons.close_outlined))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, Meme());
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: this._filter.length,
      itemBuilder: (BuildContext context, int index) {
        final meme = this._filter[index];
        return ListTile(
          title: Text(meme.name!),
          subtitle: Text(meme.url!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    this._filter = this
        .memes
        .where((meme) =>
            meme.name!.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: this._filter.length,
      itemBuilder: (BuildContext context, int index) {
        final meme = this._filter[index];
        return ListTile(
          title: Text(meme.name!),
          subtitle: Text(meme.url!),
        );
      },
    );
  }
}
