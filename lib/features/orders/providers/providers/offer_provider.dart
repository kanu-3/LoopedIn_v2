import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loopedin_v2/core/services/supabase_service.dart';
import 'package:loopedin_v2/features/orders/data/datasources/offer_remote_datasource.dart';
import 'package:loopedin_v2/features/orders/data/repository/offer_repository.dart';
import 'package:loopedin_v2/features/orders/providers/notifiers/offer_notifier.dart';
import 'package:loopedin_v2/features/orders/providers/states/offer_state.dart';

final offerDatasourceProvider =
Provider((ref) => OfferRemoteDatasource(SupabaseService.client));

final offerRepositoryProvider =
Provider((ref) => OfferRepository(ref.read(offerDatasourceProvider)));

final offerProvider =
StateNotifierProvider<OfferNotifier, OfferState>(
        (ref) => OfferNotifier(ref.read(offerRepositoryProvider)));