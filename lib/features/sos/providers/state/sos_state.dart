import 'package:loopedin_v2/core/constants/app_enums.dart';
import 'package:loopedin_v2/features/sos/data/models/sos_model.dart';

class SosState {
  final bool isLoading;
  final bool isCreating;
  final List<SosModel> feed;
  final List<SosModel> mySos;

  final Map<String, SosResponseStatus> myResponses;

  const SosState({
    required this.isLoading,
    required this.isCreating,
    required this.feed,
    required this.mySos,
    required this.myResponses,
  });

  factory SosState.initial() {
    return const SosState(
      isLoading: false,
      isCreating: false,
      feed: [],
      mySos: [],
      myResponses: {},
    );
  }

  SosState copyWith({
    bool? isLoading,
    bool? isCreating,
    List<SosModel>? feed,
    List<SosModel>? mySos,
    Map<String, SosResponseStatus>? myResponses,
  }) {
    return SosState(
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      feed: feed ?? this.feed,
      mySos: mySos ?? this.mySos,
      myResponses: myResponses ?? this.myResponses,
    );
  }
}