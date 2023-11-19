import 'package:flutter/material.dart';
import 'fast_and_furious_model.dart';
import 'dart:async';

class FastAndFuriousCharacterDetailPage extends StatefulWidget {
  final FastAndFuriousCharacter character;
  final double initialRating;

  const FastAndFuriousCharacterDetailPage(this.character, this.initialRating, {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _FastAndFuriousCharacterDetailPageState createState() => _FastAndFuriousCharacterDetailPageState(initialRating);
}

class _FastAndFuriousCharacterDetailPageState
    extends State<FastAndFuriousCharacterDetailPage> {
  final double fastAndFuriousLogoSize = 160.0;
  double _sliderValue;

  _FastAndFuriousCharacterDetailPageState(this._sliderValue);

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: Colors.red,
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  '${_sliderValue.toInt()}',
                  style: const TextStyle(color: Colors.black, fontSize: 25.0),
                ),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.character.rating = _sliderValue.toInt();
      });
      Navigator.of(context).pop(widget.character);
    }
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!'),
          content: const Text("Come on! They're good!"),
          actions: <Widget>[
            TextButton(
              child: const Text('Try Again'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      // ignore: sort_child_properties_last
      child: const Text('Submit'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
      ),
    );
  }

  Widget get fastAndFuriousLogoImage {
    return Hero(
      tag: widget.character,
      child: Container(
        height: fastAndFuriousLogoSize,
        width: fastAndFuriousLogoSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
            BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
            BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.character.imageLogoUrl ?? ""),
          ),
        ),
      ),
    );
  }

  Widget get fastAndFuriousCenterCharacterImage {
    return widget.character.imageUrl != null
        ? Image.network(
            widget.character.imageUrl!,
            height: 400.0,
            width: 500.0,
            fit: BoxFit.cover,
          )
        : Container();
  }

  Widget get fastAndFuriousCarImage {
    return widget.character.imageCarUrl != null
        ? Image.network(
            widget.character.imageCarUrl!,
            height: 400.0,
            width: 500.0,
            fit: BoxFit.cover,
          )
        : Container();
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Colors.black,
        ),
        Text('${widget.character.rating}/10', style: const TextStyle(color: Colors.black, fontSize: 30.0)),
      ],
    );
  }

  Widget get fastAndFuriousCharacterProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 204, 128),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          fastAndFuriousLogoImage,
          const SizedBox(height: 16.0),
          Text(
            '${widget.character.fullname}',
            style: const TextStyle(color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Date of Birth: ${widget.character.birth}',
            style: const TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          Text(
            'Gender: ${widget.character.gender}',
            style: const TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            '${widget.character.description}',
            style: const TextStyle(color: Colors.black, fontSize: 15.0),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 8.0),
          fastAndFuriousCenterCharacterImage,
          const SizedBox(height: 16.0),
          Text(
            '${widget.character.descriptionCar}',
            style: const TextStyle(color: Colors.black, fontSize: 15.0),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 8.0),
          fastAndFuriousCarImage,
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 204, 128),
      appBar: AppBar(
        title: Text(
          'Meet ${widget.character.fullname}',
          style: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[fastAndFuriousCharacterProfile, addYourRating],
      ),
    );
  }
}
