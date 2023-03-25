import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_morty_clean/core/errors/exceptions.dart';

import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/characters.dart';
import 'package:rick_morty_clean/features/rick_and_morty/domain/entities/result.dart';

abstract class RemoteDatasource {
  Future<Character> getAllCharacters();

  Future<List<Result>> getSingleCharacter(int id);
}

const baseUrl = "https://rickandmortyapi.com/api";

class RemoteDatasourceImpl implements RemoteDatasource {
  final http.Client client;

  RemoteDatasourceImpl({required this.client});

  @override
  Future<Character> getAllCharacters() async {
    final response = await client.get(
      Uri.parse('$baseUrl/character/'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final characterCharacters = Character.fromJson(decodedJson);
      /* final Character characterCharacters = decodedJson
          .map<Character>((jsonCharacter) => Character.fromJson(jsonCharacter)); */
      print("LENGT ***** => ${characterCharacters.results.length}");
      return characterCharacters;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Result>> getSingleCharacter(int id) {
    throw UnimplementedError();
  }
}
