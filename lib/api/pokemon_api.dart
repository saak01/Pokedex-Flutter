import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokemons.dart';

class PokemonApiProvider {
  List<PokemonFromList> pokemonsList = [];

  Future<List<PokemonFromList>> fetchPokemons() async {
    var url =
        Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=100');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> pokemonList = responseData['results'];

      List<Future<PokemonFromList>> fetches = [];
      for (final pokemon in pokemonList) {
        fetches.add(fetchPokemon(pokemon['url']));
      }

      List<PokemonFromList> pokemonDetailsList = await Future.wait(fetches);
      pokemonsList = pokemonDetailsList;
      return pokemonsList;
    } else {
      throw Exception(
          'Erro na requisição. Código de status: ${response.statusCode}');
    }
  }

  Future<PokemonFromList> fetchPokemon(String urlPokemon) async {
    var url = Uri.parse(urlPokemon);
    var response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);
    final PokemonFromList pokemonDetail = PokemonFromList(
        name: data['name'],
        types: data['types'],
        urlSprit: data['sprites']['front_default'],
        urlDetails: urlPokemon);
    return pokemonDetail;
  }

  Future<PokemonModel> fetchPokemonDetails(String urlPokemon) async {
    var url = Uri.parse(urlPokemon);
    var response = await http.get(url);
    final Map<String, dynamic> data = json.decode(response.body);
    final PokemonModel pokemonDetail = PokemonModel(
        name: data['name'],
        types: data['types'],
        urlSprit: data['sprites']['front_default'],
        hp: data['stats'][0]['base_stat'],
        attack: data['stats'][1]['base_stat'],
        defense: data['stats'][2]['base_stat'],
        specialAttack: data['stats'][3]['base_stat'],
        specialDefense: data['stats'][4]['base_stat'],
        speed: data['stats'][5]['base_stat']);
    return pokemonDetail;
  }
}
