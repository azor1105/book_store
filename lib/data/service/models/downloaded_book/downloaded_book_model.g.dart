// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedBookModelAdapter extends TypeAdapter<DownloadedBookModel> {
  @override
  final int typeId = 0;

  @override
  DownloadedBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedBookModel(
      authorId: fields[0] as String,
      authorName: fields[10] as String,
      bookName: fields[4] as String,
      bookPath: fields[12] as String,
      bookUrl: fields[5] as String,
      categoryId: fields[6] as String,
      categoryName: fields[11] as String,
      description: fields[1] as String,
      id: fields[7] as String,
      image: fields[2] as String,
      language: fields[3] as String,
      pagesCount: fields[8] as int,
      publishedDate: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedBookModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.authorId)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.language)
      ..writeByte(4)
      ..write(obj.bookName)
      ..writeByte(5)
      ..write(obj.bookUrl)
      ..writeByte(6)
      ..write(obj.categoryId)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.pagesCount)
      ..writeByte(9)
      ..write(obj.publishedDate)
      ..writeByte(10)
      ..write(obj.authorName)
      ..writeByte(11)
      ..write(obj.categoryName)
      ..writeByte(12)
      ..write(obj.bookPath);
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
