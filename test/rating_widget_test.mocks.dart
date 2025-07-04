// Mocks generated by Mockito 5.4.5 from annotations
// in junkfood/test/rating_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:junkfood/domain/model/dish_model.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DishModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockDishModel extends _i1.Mock implements _i2.DishModel {
  @override
  int get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  set id(int? _id) => super.noSuchMethod(
        Invocation.setter(
          #id,
          _id,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get title => (super.noSuchMethod(
        Invocation.getter(#title),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#title),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.getter(#title),
        ),
      ) as String);

  @override
  set title(String? _title) => super.noSuchMethod(
        Invocation.setter(
          #title,
          _title,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get description => (super.noSuchMethod(
        Invocation.getter(#description),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#description),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.getter(#description),
        ),
      ) as String);

  @override
  set description(String? _description) => super.noSuchMethod(
        Invocation.setter(
          #description,
          _description,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get calories => (super.noSuchMethod(
        Invocation.getter(#calories),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  set calories(int? _calories) => super.noSuchMethod(
        Invocation.setter(
          #calories,
          _calories,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get imageUrl => (super.noSuchMethod(
        Invocation.getter(#imageUrl),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#imageUrl),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.getter(#imageUrl),
        ),
      ) as String);

  @override
  set imageUrl(String? _imageUrl) => super.noSuchMethod(
        Invocation.setter(
          #imageUrl,
          _imageUrl,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get dishTypeId => (super.noSuchMethod(
        Invocation.getter(#dishTypeId),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  set dishTypeId(int? _dishTypeId) => super.noSuchMethod(
        Invocation.setter(
          #dishTypeId,
          _dishTypeId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get dishTypeName => (super.noSuchMethod(
        Invocation.getter(#dishTypeName),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#dishTypeName),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.getter(#dishTypeName),
        ),
      ) as String);

  @override
  set dishTypeName(String? _dishTypeName) => super.noSuchMethod(
        Invocation.setter(
          #dishTypeName,
          _dishTypeName,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<String> get allergens => (super.noSuchMethod(
        Invocation.getter(#allergens),
        returnValue: <String>[],
        returnValueForMissingStub: <String>[],
      ) as List<String>);

  @override
  set allergens(List<String>? _allergens) => super.noSuchMethod(
        Invocation.setter(
          #allergens,
          _allergens,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Map<String, dynamic> toJson() => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [],
        ),
        returnValue: <String, dynamic>{},
        returnValueForMissingStub: <String, dynamic>{},
      ) as Map<String, dynamic>);
}
