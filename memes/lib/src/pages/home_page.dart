import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memes/src/blocs/memes/memes_bloc_bloc.dart';
import 'package:memes/src/searchs/meme_search.dart';

class HomePage extends StatelessWidget {
  static final String routename = 'home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MemesBlocBloc>(context);

    bloc.add(GetmemesEvent());

    return BlocBuilder<MemesBlocBloc, MemesState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: ListTile(
              onTap: () => showSearch(
                  context: context, delegate: MemesSearch(state.memes!)),
              title: const Text(
                'Buscar',
                style: TextStyle(color: Colors.white),
              )),
        ),
        body: state.memes?.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.memes!.length,
                itemBuilder: (BuildContext context, int index) {
                  final meme = state.memes![index];
                  return ListTile(
                    title: Text(meme.name!),
                    subtitle: Text(meme.url!),
                  );
                },
              ),
      );
    });
  }
}
