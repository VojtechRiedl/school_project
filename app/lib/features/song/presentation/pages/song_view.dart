import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:flutter/material.dart';

class SongView extends StatelessWidget {
  final int id;

  const SongView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      index: 2,
      title: const Text(
        "Písničky",
        style: TextStyle(
          fontSize: 20,
          color: Palette.first,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 40.0),
        child: Card(
          color: Palette.fifth,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: const BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(
                          color: Palette.second,
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Název písničky",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Palette.second,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )),
                Expanded(flex: 2, child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Text(
                      "Text písničky \nssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                )),
                Expanded(flex: 2, child: Container(

                )),
              ],
            ),
          ),
        ));
  }
}
