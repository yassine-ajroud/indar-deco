import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/review_remote_data_source.dart';
import 'package:indar_deco/data/models/review_model.dart';
import 'package:indar_deco/domain/entities/review.dart';
import 'package:indar_deco/domain/repositories/review_repository.dart';
import '../../core/errors/exceptions/exceptions.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource reviewRemoteDataSource;

  ReviewRepositoryImpl(this.reviewRemoteDataSource);


  @override
  Future<Either<Failure, Review>> addReview(Review review) async{
     try {
      final reviewModel=ReviewModel(userID: review.userID, productID: review.productID, comment: review.comment, image: review.image, id: review.id);
     final res= await reviewRemoteDataSource.addReview(reviewModel);
      return  Right(res);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getAllReviews(String prodId) async{
        try {
      final reviewModels = await reviewRemoteDataSource.getAllReviews(prodId);
      final reviews = reviewModels
          .map((e) => Review(id: e.id, userID: e.userID, productID: e.productID,date:e.date, comment: e.comment, image: e.image,))
          .toList();
      return right(reviews);
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeReview(String prodId) async{
      try {
      await reviewRemoteDataSource.removeReview(prodId);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateReview(Review review) async{
      try {
      ReviewModel reviewModel=ReviewModel(userID: review.userID, productID: review.productID, comment: review.comment, image: review.image, id: review.id);
      await reviewRemoteDataSource.updateReview(reviewModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addReviewImage({required String reviewId, required File file}) async{
       try {
      await reviewRemoteDataSource.addReviewImage(reviewId,file);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
