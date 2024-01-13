import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_event.dart';
import 'package:band_app/features/song/presentation/widgets/song_input.dart';
import 'package:band_app/features/song/presentation/widgets/submit_button.dart';
import 'package:band_app/features/song/presentation/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateSongView extends StatefulWidget{
  const CreateSongView({super.key});

  @override
  State<CreateSongView> createState() => _CreateSongViewState();
}

class _CreateSongViewState extends State<CreateSongView> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _youtubeLinkController.dispose();
    _textController.dispose();
    super.dispose();
  }

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
      body: _buildBody(),
    );
  }

  _buildBody(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SongInput(multiLine: false, label: "Název písničky", controller: _titleController),
          SongInput(multiLine: false, label: "Odkaz na youtube", controller: _youtubeLinkController),
          SongInput(multiLine: true, label: "Text písničky",  controller: _textController),
          UploadButton(label: "Video",onPressed: () {  },),
          UploadButton(label: "Písnička", onPressed: () {  },),
          SubmitButton(label: "Uložit", onPressed: (){
            context.read<SongsBloc>().add(CreateSong(
              _titleController.text,
              _youtubeLinkController.text,
              _textController.text,
            ));
            context.pop(context);
          })
        ],
      ),
    );
  }
}