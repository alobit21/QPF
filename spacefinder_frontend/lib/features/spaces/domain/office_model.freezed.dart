// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'office_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Office {

 String get id; String get name; String get description; String get address; String get city; double? get latitude; double? get longitude;@JsonKey(name: 'pricePerHour', fromJson: _priceFromJson) double? get pricePerHour; int? get size; int? get availableRooms; List<String>? get images; bool? get isActive; List<Amenity>? get amenities; List<Slot>? get slots;
/// Create a copy of Office
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfficeCopyWith<Office> get copyWith => _$OfficeCopyWithImpl<Office>(this as Office, _$identity);

  /// Serializes this Office to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Office&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.pricePerHour, pricePerHour) || other.pricePerHour == pricePerHour)&&(identical(other.size, size) || other.size == size)&&(identical(other.availableRooms, availableRooms) || other.availableRooms == availableRooms)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.amenities, amenities)&&const DeepCollectionEquality().equals(other.slots, slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,city,latitude,longitude,pricePerHour,size,availableRooms,const DeepCollectionEquality().hash(images),isActive,const DeepCollectionEquality().hash(amenities),const DeepCollectionEquality().hash(slots));

@override
String toString() {
  return 'Office(id: $id, name: $name, description: $description, address: $address, city: $city, latitude: $latitude, longitude: $longitude, pricePerHour: $pricePerHour, size: $size, availableRooms: $availableRooms, images: $images, isActive: $isActive, amenities: $amenities, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $OfficeCopyWith<$Res>  {
  factory $OfficeCopyWith(Office value, $Res Function(Office) _then) = _$OfficeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String address, String city, double? latitude, double? longitude,@JsonKey(name: 'pricePerHour', fromJson: _priceFromJson) double? pricePerHour, int? size, int? availableRooms, List<String>? images, bool? isActive, List<Amenity>? amenities, List<Slot>? slots
});




}
/// @nodoc
class _$OfficeCopyWithImpl<$Res>
    implements $OfficeCopyWith<$Res> {
  _$OfficeCopyWithImpl(this._self, this._then);

  final Office _self;
  final $Res Function(Office) _then;

/// Create a copy of Office
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? city = null,Object? latitude = freezed,Object? longitude = freezed,Object? pricePerHour = freezed,Object? size = freezed,Object? availableRooms = freezed,Object? images = freezed,Object? isActive = freezed,Object? amenities = freezed,Object? slots = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,pricePerHour: freezed == pricePerHour ? _self.pricePerHour : pricePerHour // ignore: cast_nullable_to_non_nullable
as double?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,availableRooms: freezed == availableRooms ? _self.availableRooms : availableRooms // ignore: cast_nullable_to_non_nullable
as int?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,amenities: freezed == amenities ? _self.amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<Amenity>?,slots: freezed == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<Slot>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Office].
extension OfficePatterns on Office {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Office value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Office() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Office value)  $default,){
final _that = this;
switch (_that) {
case _Office():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Office value)?  $default,){
final _that = this;
switch (_that) {
case _Office() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String address,  String city,  double? latitude,  double? longitude, @JsonKey(name: 'pricePerHour', fromJson: _priceFromJson)  double? pricePerHour,  int? size,  int? availableRooms,  List<String>? images,  bool? isActive,  List<Amenity>? amenities,  List<Slot>? slots)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Office() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.city,_that.latitude,_that.longitude,_that.pricePerHour,_that.size,_that.availableRooms,_that.images,_that.isActive,_that.amenities,_that.slots);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String address,  String city,  double? latitude,  double? longitude, @JsonKey(name: 'pricePerHour', fromJson: _priceFromJson)  double? pricePerHour,  int? size,  int? availableRooms,  List<String>? images,  bool? isActive,  List<Amenity>? amenities,  List<Slot>? slots)  $default,) {final _that = this;
switch (_that) {
case _Office():
return $default(_that.id,_that.name,_that.description,_that.address,_that.city,_that.latitude,_that.longitude,_that.pricePerHour,_that.size,_that.availableRooms,_that.images,_that.isActive,_that.amenities,_that.slots);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String address,  String city,  double? latitude,  double? longitude, @JsonKey(name: 'pricePerHour', fromJson: _priceFromJson)  double? pricePerHour,  int? size,  int? availableRooms,  List<String>? images,  bool? isActive,  List<Amenity>? amenities,  List<Slot>? slots)?  $default,) {final _that = this;
switch (_that) {
case _Office() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.city,_that.latitude,_that.longitude,_that.pricePerHour,_that.size,_that.availableRooms,_that.images,_that.isActive,_that.amenities,_that.slots);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Office implements Office {
  const _Office({required this.id, required this.name, required this.description, required this.address, required this.city, this.latitude, this.longitude, @JsonKey(name: 'pricePerHour', fromJson: _priceFromJson) this.pricePerHour, this.size, this.availableRooms, final  List<String>? images, this.isActive, final  List<Amenity>? amenities, final  List<Slot>? slots}): _images = images,_amenities = amenities,_slots = slots;
  factory _Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String address;
@override final  String city;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'pricePerHour', fromJson: _priceFromJson) final  double? pricePerHour;
@override final  int? size;
@override final  int? availableRooms;
 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? isActive;
 final  List<Amenity>? _amenities;
@override List<Amenity>? get amenities {
  final value = _amenities;
  if (value == null) return null;
  if (_amenities is EqualUnmodifiableListView) return _amenities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Slot>? _slots;
@override List<Slot>? get slots {
  final value = _slots;
  if (value == null) return null;
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Office
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfficeCopyWith<_Office> get copyWith => __$OfficeCopyWithImpl<_Office>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfficeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Office&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.pricePerHour, pricePerHour) || other.pricePerHour == pricePerHour)&&(identical(other.size, size) || other.size == size)&&(identical(other.availableRooms, availableRooms) || other.availableRooms == availableRooms)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._amenities, _amenities)&&const DeepCollectionEquality().equals(other._slots, _slots));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,city,latitude,longitude,pricePerHour,size,availableRooms,const DeepCollectionEquality().hash(_images),isActive,const DeepCollectionEquality().hash(_amenities),const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'Office(id: $id, name: $name, description: $description, address: $address, city: $city, latitude: $latitude, longitude: $longitude, pricePerHour: $pricePerHour, size: $size, availableRooms: $availableRooms, images: $images, isActive: $isActive, amenities: $amenities, slots: $slots)';
}


}

/// @nodoc
abstract mixin class _$OfficeCopyWith<$Res> implements $OfficeCopyWith<$Res> {
  factory _$OfficeCopyWith(_Office value, $Res Function(_Office) _then) = __$OfficeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String address, String city, double? latitude, double? longitude,@JsonKey(name: 'pricePerHour', fromJson: _priceFromJson) double? pricePerHour, int? size, int? availableRooms, List<String>? images, bool? isActive, List<Amenity>? amenities, List<Slot>? slots
});




}
/// @nodoc
class __$OfficeCopyWithImpl<$Res>
    implements _$OfficeCopyWith<$Res> {
  __$OfficeCopyWithImpl(this._self, this._then);

  final _Office _self;
  final $Res Function(_Office) _then;

/// Create a copy of Office
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? city = null,Object? latitude = freezed,Object? longitude = freezed,Object? pricePerHour = freezed,Object? size = freezed,Object? availableRooms = freezed,Object? images = freezed,Object? isActive = freezed,Object? amenities = freezed,Object? slots = freezed,}) {
  return _then(_Office(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,pricePerHour: freezed == pricePerHour ? _self.pricePerHour : pricePerHour // ignore: cast_nullable_to_non_nullable
as double?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,availableRooms: freezed == availableRooms ? _self.availableRooms : availableRooms // ignore: cast_nullable_to_non_nullable
as int?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,amenities: freezed == amenities ? _self._amenities : amenities // ignore: cast_nullable_to_non_nullable
as List<Amenity>?,slots: freezed == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<Slot>?,
  ));
}


}

// dart format on
