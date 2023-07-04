class PokemonModel {
  const PokemonModel(
      {required this.name,
      required this.types,
      required this.urlSprit,
      required this.hp,
      required this.attack,
      required this.defense,
      required this.specialAttack,
      required this.specialDefense,
      required this.speed});

  final String name;
  final List<dynamic> types;
  final String urlSprit;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
}

class PokemonFromList {
  const PokemonFromList(
      {required this.name,
      required this.types,
      required this.urlSprit,
      required this.urlDetails});

  final String name;
  final List<dynamic> types;
  final String urlSprit;
  final String urlDetails;
}
