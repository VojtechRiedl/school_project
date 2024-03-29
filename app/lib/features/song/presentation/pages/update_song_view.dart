import 'package:band_app/core/constants/palette.dart';
import 'package:band_app/features/home/presentation/widgets/default_app_bar.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_bloc.dart';
import 'package:band_app/features/login/presentation/bloc/authorization/authorization_state.dart';
import 'package:band_app/features/song/presentation/bloc/song_update/song_update_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/song_update/song_update_event.dart';
import 'package:band_app/features/song/presentation/bloc/song_update/song_update_state.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_bloc.dart';
import 'package:band_app/features/song/presentation/bloc/songs/songs_event.dart';
import 'package:band_app/features/song/presentation/widgets/song_input.dart';
import 'package:band_app/features/song/presentation/widgets/upload_button.dart';
import 'package:band_app/injection_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateSongView extends StatefulWidget{
  final int id;

  const UpdateSongView({super.key, required this.id});

  @override
  State<UpdateSongView> createState() => _UpdateSongViewState();
}

class _UpdateSongViewState extends State<UpdateSongView> {

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
    return BlocProvider<SongUpdateBloc>(
      create: (_) => sl<SongUpdateBloc>()..add(LoadSong(widget.id)),
      child:  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MainAppBar(

          title: Text('Písničky'),
        ),
        body:_buildBody(),
      ),
    );
  }

  _buildBody(){
    return BlocConsumer<SongUpdateBloc, SongUpdateState>(
      listener: (context, state) {
        if(state is UploadError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(state.message),
              )
          );
        }else if(state is SongUpdateError){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(state.message),
              )
          );
        }else if(state is SongUpdated){
          context.read<SongsBloc>().add(ActualizeSong(state.song));
          context.pop(context);
        }else if(state is SongLoaded){
          _titleController.text = state.song.title;
          _youtubeLinkController.text = state.song.youtubeUrl ?? "";
          _textController.text = state.song.text ?? "";
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SongInput(multiLine: false, label: "Název písničky", controller: _titleController, errorText: state is TitleError ? state.message : null),
                  SongInput(multiLine: false, label: "Odkaz na youtube", controller: _youtubeLinkController),
                  SongInput(multiLine: true, label: "Text písničky",  controller: _textController),
                  UploadButton(label: "Video",loaded: state.videoFileResult != null, onPressed: () async {
                    context.read<SongUpdateBloc>().add(LoadVideo(await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['mp4']
                    )));
                  }),
                  const SizedBox(height: 10,),
                  UploadButton(label: "Písnička",loaded: state.songFileResult != null, onPressed: () async {
                    context.read<SongUpdateBloc>().add(LoadSound(await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['mp3']
                    )));
                  }),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  AuthorizationBloc bloc = context.read<AuthorizationBloc>();
                  if(bloc.state is AuthorizationAuthenticateSuccess){
                    context.read<SongUpdateBloc>().add(UpdateSong(
                        _titleController.text,
                        _youtubeLinkController.text,
                        _textController.text,
                        widget.id,
                    ));
                  }
                },
                child: Text("Upravit", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        );
      },

    );
  }
}