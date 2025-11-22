// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amiibo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmiiboModelAdapter extends TypeAdapter<AmiiboModel> {
  @override
  final int typeId = 0;

  @override
  AmiiboModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AmiiboModel(
      amiiboSeries: fields[0] as String,
      character: fields[1] as String,
      gameSeries: fields[2] as String,
      head: fields[3] as String,
      image: fields[4] as String,
      name: fields[5] as String,
      release: fields[6] as ReleaseModel,
      tail: fields[7] as String,
      type: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AmiiboModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.amiiboSeries)
      ..writeByte(1)
      ..write(obj.character)
      ..writeByte(2)
      ..write(obj.gameSeries)
      ..writeByte(3)
      ..write(obj.head)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.release)
      ..writeByte(7)
      ..write(obj.tail)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmiiboModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReleaseModelAdapter extends TypeAdapter<ReleaseModel> {
  @override
  final int typeId = 1;

  @override
  ReleaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReleaseModel(
      au: fields[0] as String?,
      eu: fields[1] as String?,
      jp: fields[2] as String?,
      na: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReleaseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.au)
      ..writeByte(1)
      ..write(obj.eu)
      ..writeByte(2)
      ..write(obj.jp)
      ..writeByte(3)
      ..write(obj.na);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
