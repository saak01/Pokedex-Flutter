import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemons.dart';
import 'package:pokedex/widget/pokemons_type_container.dart';

import '../api/pokemon_api.dart';
import '../providers/pokemon_api_provider.dart';
import '../screens/pokemon_detail.dart';

class PokemonsList extends StatefulWidget {
  const PokemonsList({super.key, required this.pokemonsList});
  final List<PokemonFromList> pokemonsList;

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  Future<PokemonModel> fetchPokemon(String url) async {
    final PokemonApiProvider pokemonApiProvider =
        getIt.get<PokemonApiProvider>();
    final PokemonModel pokemon =
        await pokemonApiProvider.fetchPokemonDetails(url);
    return pokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: widget.pokemonsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 20),
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              var pokemon =
                  await fetchPokemon(widget.pokemonsList[index].urlDetails);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => PokemonDetail(pokemon: pokemon)),
              );
            },
            child: Card(
              color: Colors.white,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 8),
                    child: Text(
                      '${widget.pokemonsList[index].name[0].toUpperCase()}${widget.pokemonsList[index].name.substring(1).toLowerCase()}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 125,
                      width: 90,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/background-list-pokemons.png'),
                        ),
                      ),
                      child: Image.network(
                        widget.pokemonsList[index].urlSprit,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 10,
                    child: PokemonTypeContainer(
                        types: widget.pokemonsList[index].types),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
