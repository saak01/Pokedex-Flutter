import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemons.dart';
import 'package:pokedex/widget/pokemons_list.dart';
import 'package:pokedex/api/pokemon_api.dart';
import 'package:pokedex/providers/pokemon_api_provider.dart';
import 'package:pokedex/widget/skeleton_card.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreen();
}

class _PokedexScreen extends State<PokedexScreen> {
  bool isLoading = true;
  bool error = false;

  List<PokemonFromList> pokemons = [];
  List<PokemonFromList> pokemonsBasedata = [];

  @override
  void initState() {
    fetchPokemons();
    super.initState();
  }

  Future<void> fetchPokemons() async {
    try {
      final PokemonApiProvider pokemonApiProvider =
          getIt.get<PokemonApiProvider>();
      final List<dynamic> fetchedPokemons =
          await pokemonApiProvider.fetchPokemons();
      setState(() {
        const kirby = PokemonFromList(
            name: 'Kirby',
            types: [
              {
                'type': {'name': 'No'}
              },
              {
                'type': {'name': 'Pokemon'}
              }
            ],
            urlSprit:
                'https://assets.stickpng.com/images/5aafaf817603fc558cffc0a1.png',
            urlDetails: '');
        pokemons = fetchedPokemons as List<PokemonFromList>;
        pokemons.add(kirby);
        pokemonsBasedata = pokemons;
        print(pokemonsBasedata);
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = PokemonsList(pokemonsList: pokemons);

    if (isLoading) {
      content = const SkeletonCard();
    } else if (error) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/error.png',
            width: 300,
          ),
        ),
      );
    } else if (pokemons.isEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/error.png',
            width: 300,
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('assets/images/logo.png',
                    alignment: Alignment.center),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff51535d).withOpacity(0.7),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      decoration: const InputDecoration(
                        hintText: 'Buscar Pokemon...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 15, left: 20),
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (item) {
                        if (item.isEmpty) {
                          setState(() {
                            pokemons = pokemonsBasedata;
                          });
                        } else {
                          setState(
                            () {
                              pokemons = pokemonsBasedata
                                  .where(
                                    (pokemon) =>
                                        pokemon.name.toLowerCase().contains(
                                              item.toLowerCase(),
                                            ),
                                  )
                                  .toList();
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              content
            ],
          ),
        ),
      ),
    );
  }
}
