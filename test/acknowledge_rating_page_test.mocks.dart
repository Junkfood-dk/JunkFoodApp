// Mocks generated by Mockito 5.4.4 from annotations
// in userapp/test/acknowledge_rating_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:supabase_flutter/supabase_flutter.dart' as _i2;
import 'package:junkfood/data/rating_repository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSupabaseClient_0 extends _i1.SmartFake
    implements _i2.SupabaseClient {
  _FakeSupabaseClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RatingRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRatingRepository extends _i1.Mock implements _i3.RatingRepository {
  @override
  _i2.SupabaseClient get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _FakeSupabaseClient_0(
          this,
          Invocation.getter(#database),
        ),
        returnValueForMissingStub: _FakeSupabaseClient_0(
          this,
          Invocation.getter(#database),
        ),
      ) as _i2.SupabaseClient);

  @override
  set database(_i2.SupabaseClient? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<int> postNewRating(
    int? rating,
    int? dish,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postNewRating,
          [
            rating,
            dish,
          ],
        ),
        returnValue: _i4.Future<int>.value(0),
        returnValueForMissingStub: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<int> updateRating(
    int? ratingId,
    int? rating,
    int? dish,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateRating,
          [
            ratingId,
            rating,
            dish,
          ],
        ),
        returnValue: _i4.Future<int>.value(0),
        returnValueForMissingStub: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}
