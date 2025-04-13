import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/domain/entities/promotion.dart';



import '../../core/errors/exceptions/exceptions.dart';
import '../../domain/repositories/promotion_repository.dart';
import '../data_Sources/remote_data_source/promotion_remote_data_source.dart';

class PromotionRepositoryImpl implements PromotionRepository {
  PromotionRemoteDataSource promotionRemoteDataSource;
  PromotionRepositoryImpl(
     this.promotionRemoteDataSource,
  );
  @override
  Future<Either<Failure, List<Promotion>>> getAllPromotions() async{
       try {
      final promotionModels = await promotionRemoteDataSource.getAllPromotions();
      final promotions = promotionModels
          .map((e) => Promotion(
              id: e.id,
              image: e.image,
              discount: e.discount,
              endDate: e.endDate,
              startDate: e.startDate,
              text: e.text,
              newPrice: e.newPrice,
              product: e.product
              ))
          .toList();
      return right(promotions);
    } on ServerException {
      return left(ServerFailure());
    } 
  }
}
