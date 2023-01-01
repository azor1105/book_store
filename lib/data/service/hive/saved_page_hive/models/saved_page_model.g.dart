// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_page_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedBookModelAdapter extends TypeAdapter<DownloadedBookModel> {
  @override
  final int typeId = 1;

  @override
  DownloadedBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedBookModel(
      bookId: fields[0] as String,
      page: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedBookModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.page);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
