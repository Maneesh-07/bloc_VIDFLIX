// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesVideoAdapter extends TypeAdapter<FavoritesVideo> {
  @override
  final int typeId = 0;

  @override
  FavoritesVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritesVideo(
      video: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoritesVideo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.video);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListAdapter extends TypeAdapter<PlayList> {
  @override
  final int typeId = 1;

  @override
  PlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayList(
      playlistName: fields[0] as String,
      videosList: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.videosList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LastPlayedAdapter extends TypeAdapter<LastPlayed> {
  @override
  final int typeId = 2;

  @override
  LastPlayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastPlayed(
      video: fields[0] as String,
      position: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LastPlayed obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.video)
      ..writeByte(1)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastPlayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoHistoryAdapter extends TypeAdapter<VideoHistory> {
  @override
  final int typeId = 3;

  @override
  VideoHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoHistory(
      video: fields[0] as String,
      position: fields[1] as int,
      duration: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VideoHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.video)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
