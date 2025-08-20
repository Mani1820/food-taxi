import 'package:flutter_riverpod/flutter_riverpod.dart';

final areaProvider = StateProvider<String>((ref) => '');
final streetProvider = StateProvider<String>((ref) => '');
final landmarkProvider = StateProvider<String>((ref) => '');
final cityProvider = StateProvider<String>((ref) => '');
final pincodeProvider = StateProvider<String>((ref) => '');