import 'package:appfastandfurious/fast_and_furious_card.dart';
import 'package:flutter/material.dart';
import 'fast_and_furious_model.dart';

class FastAndFuriousCharacterList extends StatelessWidget {
  final List<FastAndFuriousCharacter> characters;
  const FastAndFuriousCharacterList(this.characters, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: characters.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return FastAndFuriousCharacterCard(characters[int]);
      },
    );
  }
}
