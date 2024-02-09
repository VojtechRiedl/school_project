import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';

class SongTest extends StatefulWidget {
  final int id;

  const SongTest({super.key, required this.id});

  @override
  State<SongTest> createState() => _SongTestState();
}

class _SongTestState extends State<SongTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.light,
      appBar: MainAppBar(

        title: Text('Song Test'),
      ),
      body:_buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){

    double value = 0.5;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Can you Feel My heart', style: TextStyle(fontSize: 24, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
            Text("Kosák", style: TextStyle(fontSize: 16, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Lorem ipsum dolor\nsit amet consectetur adipisicing elit.\nMaxime mollitia,\nmolestiae quas\nvel sint commodi repudiandae consequuntur\nvoluptatum laborum\nnumquam blanditiis\nharum quisquam eius sed odit \npes\npes\npes\npes\npes\npes\npes\npes\npes\npes\npes",
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Palette.darkTextColor, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Palette.dark),
                      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 40, 50)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                              ))),
                    ),
                      onPressed: (){
                        //TODO
                      },
                      child: Text("Zobrazit více", style: TextStyle(color: Palette.lightTextColor, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),

            Container(
              color: Colors.yellow,
              height: 200,
              child: Center(
                child: Text("Loading...")
              ),
            ),
            SizedBox(height: 20),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 50,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 60),
                thumbColor: Palette.dark,
                activeTrackColor: Palette.activeTrackColor,
                inactiveTrackColor: Palette.inactiveTrackColor,
                allowedInteraction: SliderInteraction.slideOnly
              ),
              child: Slider(
                value: value,
                min: 0,
                max: 1,
                onChanged: (double value) {
                  setState(() {
                    value = value;
                  });
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}