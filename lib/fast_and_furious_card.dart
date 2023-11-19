import 'package:appfastandfurious/fast_and_furious_model.dart';
import 'fast_and_furious_detail_page.dart';
import 'package:flutter/material.dart';

class FastAndFuriousCharacterCard extends StatefulWidget {
  final FastAndFuriousCharacter character;

  const FastAndFuriousCharacterCard(this.character, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _FastAndFuriousCharacterCardState createState() => _FastAndFuriousCharacterCardState(character);
}

class _FastAndFuriousCharacterCardState extends State<FastAndFuriousCharacterCard> {
  FastAndFuriousCharacter character;
  String? renderUrl;

  _FastAndFuriousCharacterCardState(this.character);

  @override
  void initState() {
    super.initState();
    renderFastAndFuriousCharacterPic();
  }

  Widget get fastAndFuriousCharacterImage {
    var fastAndFuriousCharacterAvatar = Hero(
      tag: character,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(renderUrl ?? '')),
        ),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange, Colors.red],
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'IMAGE',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: fastAndFuriousCharacterAvatar,
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderFastAndFuriousCharacterPic() async {
    await character.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = character.imageUrl;
      });
    }
  }

  Widget get fastAndFuriousCharacterCard {
    return SizedBox(
      width: double.infinity,
      height: 115,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade300, Colors.green.shade300],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: fastAndFuriousCharacterImage,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        '${widget.character.fullname}',
                        style: const TextStyle(
                          color: Color(0xFF000600),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${widget.character.actorRealName}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.star, color: Colors.yellow, size: 18.0),
                          Text(': ${widget.character.rating}/10', style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showFastAndFuriousCharacterDetailPage() async {
    var updatedCharacter = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return FastAndFuriousCharacterDetailPage(character, character.rating.toDouble());
    }));

    if (updatedCharacter != null) {
      setState(() {
        character = updatedCharacter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showFastAndFuriousCharacterDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: fastAndFuriousCharacterCard,
      ),
    );
  }
}
