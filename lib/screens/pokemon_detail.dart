import 'package:flutter/material.dart';
import 'package:pokedex/widget/pokemon_detail.dart';
import '../model/pokemons.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PokemonDetailWidget(
          pokemon: widget.pokemon,
        ),
      ),
    );
  }
}
