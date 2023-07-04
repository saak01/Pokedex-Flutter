import 'package:flutter/material.dart';

class PokemonTypeContainer extends StatefulWidget {
  final List types;
  const PokemonTypeContainer({super.key, required this.types});

  @override
  State<PokemonTypeContainer> createState() => _PokemonTypeContainerState();
}

class _PokemonTypeContainerState extends State<PokemonTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (final type in widget.types)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 65,
              decoration: BoxDecoration(
                  color: const Color(0xffefefef),
                  borderRadius: BorderRadius.circular(48)),
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  type['type']['name'],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
