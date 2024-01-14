import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_scaffold.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song/songs_event.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_event.dart';
import 'package:band_app/features/song/presentation/bloc/song_create/song_create_state.dart';
import 'package:band_app/features/song/presentation/widgets/song_input.dart';
import 'package:band_app/features/song/presentation/widgets/submit_button.dart';
import 'package:band_app/features/song/presentation/widgets/upload_button.dart';
import 'package:band_app/injection_container.dart';
import 'package:file_picker/file_picker.dart';
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
    return BlocProvider<SongCreateBloc>(
      create: (_) => sl<SongCreateBloc>(),
      child: DefaultScaffold(
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
      ),
    );
  }

  _buildBody(){
    return BlocConsumer<SongCreateBloc, SongCreateState>(
      listener: (context, state) {
        if(state is UploadError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              )
          );
        }else if(state is SongCreateError){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              )
          );
        }else if(state is SongCreated){
          context.read<SongsBloc>().add(AddSong(state.song));
          context.pop(context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SongInput(multiLine: false, label: "Název písničky", controller: _titleController, errorText: state is TitleError ? state.message : null),
                    SongInput(multiLine: false, label: "Odkaz na youtube", controller: _youtubeLinkController),
                    SongInput(multiLine: true, label: "Text písničky",  controller: _textController),
                  ],
                ),
                Column(
                  children: [
                    UploadButton(label: "Video",loaded: state.videoFileResult != null, onPressed: () async {
                      context.read<SongCreateBloc>().add(LoadVideo(await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['mp4']
                      )));
                    }),
                    UploadButton(label: "Písnička",loaded: state.songFileResult != null, onPressed: () async {
                      context.read<SongCreateBloc>().add(LoadSound(await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['mp3']
                      )));
                    }),
                    SubmitButton(label: "Uložit", onPressed: (){
                      context.read<SongCreateBloc>().add(CreateSong(
                          _titleController.text,
                          _youtubeLinkController.text,
                          _textController.text
                      ));
                    })
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}