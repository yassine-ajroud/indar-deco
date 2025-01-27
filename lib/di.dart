import 'package:get_it/get_it.dart';
import 'package:indar_deco/data/data_Sources/remote_data_source/promotion_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/cart_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/category_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/notification_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/rating_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/reclamations_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/review_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/sales_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/sub_category_remote_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/wishlist_remote_data_source.dart';
import 'package:indar_deco/data/repositories/authentication_repository_impl.dart';
import 'package:indar_deco/data/repositories/cart_repository_impl.dart';
import 'package:indar_deco/data/repositories/category_reopsitory_impl.dart';
import 'package:indar_deco/data/repositories/notification_repository_impl.dart';
import 'package:indar_deco/data/repositories/product_3d_repository_impl.dart';
import 'package:indar_deco/data/repositories/product_repository_impl.dart';
import 'package:indar_deco/data/repositories/promotion_repository_impl.dart';
import 'package:indar_deco/data/repositories/rating_repository_impl.dart';
import 'package:indar_deco/data/repositories/reclamations_repository_impl.dart';
import 'package:indar_deco/data/repositories/review_repository_impl.dart';
import 'package:indar_deco/data/repositories/sales_repository_impl.dart';
import 'package:indar_deco/data/repositories/sub_category_repository_impl.dart';
import 'package:indar_deco/data/repositories/supplier_repository_impl.dart';
import 'package:indar_deco/data/repositories/wishlist_repository_impl.dart';
import 'package:indar_deco/domain/repositories/category_repository.dart';
import 'package:indar_deco/domain/repositories/notifications_repository.dart';
import 'package:indar_deco/domain/repositories/product3d_repository.dart';
import 'package:indar_deco/domain/repositories/product_repository.dart';
import 'package:indar_deco/domain/repositories/promotion_repository.dart';
import 'package:indar_deco/domain/repositories/rating_repository.dart';
import 'package:indar_deco/domain/repositories/reclamation_repository.dart';
import 'package:indar_deco/domain/repositories/review_repository.dart';
import 'package:indar_deco/domain/repositories/sales_repository.dart';
import 'package:indar_deco/domain/repositories/sub_category_repository.dart';
import 'package:indar_deco/domain/repositories/supplier_repository.dart';
import 'package:indar_deco/domain/repositories/wishlist_repository.dart';
import 'package:indar_deco/domain/usecases/authentication_usecases/forget_password_usecase.dart';
import 'package:indar_deco/domain/usecases/authentication_usecases/get_recovery_email_usecase.dart';
import 'package:indar_deco/domain/usecases/authentication_usecases/reset_password_usecase.dart';
import 'package:indar_deco/domain/usecases/authentication_usecases/verify_otp_usecase.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/delete_notification_usecase.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/get_notification_by_id_usecase.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/get_notifications_by_user.dart';
import 'package:indar_deco/domain/usecases/notification_usecases/update_notification_usecase.dart';

import 'package:indar_deco/domain/usecases/promotion_usecases/get_all_promotions_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/add_rating_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/delete_rating_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/get_ratings_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/get_single_rating_usecase.dart';
import 'package:indar_deco/domain/usecases/rating_usecases/update_rating_usecase.dart';
import 'package:indar_deco/domain/usecases/supplier_usecases/get_all_suppliers_usecase.dart';
import 'package:indar_deco/domain/usecases/supplier_usecases/get_supplier_by_ud_usecase.dart';

import 'data/data_sources/remote_data_source/product_3d_remote_data_source.dart';
import 'data/data_sources/remote_data_source/supplier_remote_data_source.dart';
import 'domain/repositories/authentication_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/usecases/authentication_usecases/auto_login_usecase.dart';
import 'domain/usecases/authentication_usecases/create_account_usecase.dart';
import 'domain/usecases/authentication_usecases/facebook_login_usecase.dart';
import 'domain/usecases/authentication_usecases/get_user_usecase.dart';
import 'domain/usecases/authentication_usecases/google_login_usecase.dart';
import 'domain/usecases/authentication_usecases/login_usecase.dart';
import 'domain/usecases/authentication_usecases/logout_usecase.dart';
import 'domain/usecases/authentication_usecases/update_profil_usecase.dart';
import 'domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'domain/usecases/cart_usecases/delete_cart_usecase.dart';
import 'domain/usecases/cart_usecases/get_cart_usecase.dart';
import 'domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'domain/usecases/category_usecases/get_categories_usecase.dart';
import 'domain/usecases/product_3d_usecases/get_all_3d_products_usecase.dart';
import 'domain/usecases/product_usecases/get_all_products_usecase.dart';
import 'domain/usecases/product_usecases/get_products_by_category_usecase.dart';
import 'domain/usecases/product_usecases/get_sorted_products_usecase.dart';
import 'domain/usecases/reclamation_usecases/add_reclamation_usecase.dart';
import 'domain/usecases/reclamation_usecases/get_all_reclamations_usecase.dart';
import 'domain/usecases/reclamation_usecases/get_single_reclamation.dart';
import 'domain/usecases/review_usecases/add_review_image_usecase.dart';
import 'domain/usecases/review_usecases/add_review_usecase.dart';
import 'domain/usecases/review_usecases/get_all_reviews_usecase.dart';
import 'domain/usecases/review_usecases/remove_review.dart';
import 'domain/usecases/review_usecases/update_review_usecase.dart';
import 'domain/usecases/sales_usecases/add_sale_usecase.dart';
import 'domain/usecases/sales_usecases/delete_sale_usecase.dart';
import 'domain/usecases/sales_usecases/get_all_sales_usecase.dart';
import 'domain/usecases/sales_usecases/get_single_sale_usecase.dart';
import 'domain/usecases/sales_usecases/update_sale_usecase.dart';
import 'domain/usecases/sub_category_usecases/get_all_sub_categories_usecase.dart';
import 'domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/delete_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authRemoteDataSource: sl(), authLocalDataSource: sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton<WishListRepository>(
      () => WishListRepositoryImpl(sl()));
  sl.registerLazySingleton<PromotionRepository>(
      () => PromotionRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImp(sl()));
  sl.registerLazySingleton<SubCategoryRepository>(
      () => SubCategoryRepositoryImpl(sl()));
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl()));
  sl.registerLazySingleton<SupplierRepository>(
      () => SupplierRepositoryImpl(sl()));
  sl.registerLazySingleton<Product3DRepository>(
      () => Product3DRepositoryImpl(sl()));
  sl.registerLazySingleton<RatingRepository>(() => RatingRepositoryImpl(sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
  sl.registerLazySingleton<SalesRepository>(() => SalesRepositoryImpl(sl()));
  sl.registerLazySingleton<ReclamationRepository>(
      () => ReclamationsRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(sl()));

  /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl());
  sl.registerLazySingleton<WishListRemoteDataSource>(
      () => WishListRemoteDataSourceImpl());
  sl.registerLazySingleton<PromotionRemoteDataSource>(
      () => PromotionRemoteDataSourceImpl());
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl());
  sl.registerLazySingleton<SubCategoryRemoteDataSource>(
      () => SubCategoryRemoteDataSourceImpl());
  sl.registerLazySingleton<SupplierRemoteDataSource>(
      () => SupplierRemoteDataSourceImpl());
  sl.registerLazySingleton<Product3DRemoteDataSource>(
      () => Product3DRemoteDataSourceImpl());
  sl.registerLazySingleton<RatingRemoteDataSource>(
      () => RatingRemoteDataSourceImpl());
  sl.registerLazySingleton<ReviewRemoteDataSource>(
      () => ReviewRemoteDataSourceImpl());
  sl.registerLazySingleton<SalesRemoteDataSource>(
      () => SalesRemoteDataSourceImp());
  sl.registerLazySingleton<ReclamtionsRemoteDataSource>(
      () => ReclamationRemoteDataSourceImpl());
  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => OTPVerificationUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfilUsecase(sl()));
  sl.registerLazySingleton(() => GetUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUsecase(sl()));
  sl.registerLazySingleton(() => FacebookLoginUsecase(sl()));
  sl.registerLazySingleton(() => AutoLoginUsecase(sl()));
  sl.registerLazySingleton(() => GetRecoveryEmailUsecase(sl()));

  //cart//
  sl.registerLazySingleton(() => CreateCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(sl()));
  sl.registerLazySingleton(() => GetCartUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCartUsecase(sl()));

  // //wishlist//
  sl.registerLazySingleton(() => CreateWishListUsecase(sl()));
  sl.registerLazySingleton(() => UpdateWishListUsecase(sl()));
  sl.registerLazySingleton(() => GetWishListUsecase(sl()));
  sl.registerLazySingleton(() => DeleteWishListUsecase(sl()));

  //promotion//
  sl.registerLazySingleton(() => GetAllPromotionsUsecase(sl()));

  //products//
  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetSortedProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsByCategoryUsecase(sl()));

  //products 3D//
  sl.registerLazySingleton(() => GetAll3DProductsUseCase(sl()));

  //categories//
  sl.registerLazySingleton(() => GetAllCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSubCategoriesUsecase(sl()));

  //supplier//
  sl.registerLazySingleton(() => GetSupplierByIdUsecase(sl()));
  sl.registerLazySingleton(() => GetSuppliersUsecase(sl()));

  //rating//
  sl.registerLazySingleton(() => AddRatingUsecase(sl()));
  sl.registerLazySingleton(() => GetRatingsUsecase(sl()));
  sl.registerLazySingleton(() => GetSingleRatingUsecase(sl()));
  sl.registerLazySingleton(() => UpdateRatingUsecase(sl()));
  sl.registerLazySingleton(() => DeleteRatingUsecase(sl()));

  //review//
  sl.registerLazySingleton(() => GetAllReviewsUsecase(sl()));
  sl.registerLazySingleton(() => AddReviewUsecase(sl()));
  sl.registerLazySingleton(() => UpdateReviewUsecase(sl()));
  sl.registerLazySingleton(() => RemoveReviewUsecase(sl()));
  sl.registerLazySingleton(() => AddReviewImageUsecase(sl()));

  //sales usecases//
  sl.registerLazySingleton(() => AddSaleUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSalesUsecase(sl()));
  sl.registerLazySingleton(() => GetSingleSalesUsecase(sl()));
  sl.registerLazySingleton(() => UpdateSaleUsecase(sl()));
  sl.registerLazySingleton(() => DeleteSaleUsecase(sl()));

  //reclamations usecases//
  sl.registerLazySingleton(() => AddReclamationsUsecase(sl()));
  sl.registerLazySingleton(() => GetAllReclamationsUsecase(sl()));
  sl.registerLazySingleton(() => GetSingleReclamationUsecase(sl()));

  
  // //notifications//
  sl.registerLazySingleton(() => UpdateNotificationUsecase(sl()));
  sl.registerLazySingleton(() => GetNotificationByIDUsecase(sl()));
  sl.registerLazySingleton(() => GetNotificationByUserUsecase(sl()));
  sl.registerLazySingleton(() => DeleteNotificationUsecase(sl()));
}
