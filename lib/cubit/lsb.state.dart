import 'dart:typed_data';
import 'package:flutter/material.dart';

sealed class LsbState {}
final class EmbedLoading extends LsbState {}
class LsbInitial extends LsbState {}

class EmbedSuccess extends LsbState {
  final Uint8List bytes;  
  final Image image;
  EmbedSuccess({required this.bytes}): image = Image.memory(bytes, fit: BoxFit.cover);
}

final class EmbedFailure extends LsbState {
  final String message;

  EmbedFailure({required this.message});
}

final class ExtractLoading extends LsbState {}

class ExtractSuccess extends LsbState {
  final String message;
  ExtractSuccess({required this.message});
}

final class ExtractFailure extends LsbState {
  final String message;

  ExtractFailure({required this.message});
}

final class SaveMessageLoading extends LsbState {}

class SaveMessageSuccess extends LsbState {}

final class SaveMessageFailure extends LsbState {
  final String message;

  SaveMessageFailure({required this.message});
}
