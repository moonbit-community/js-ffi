///| Performs a checked cast from a `Value` to a `Self?` type.
/// 
/// This trait abstracts a function that ensures the cast is valid and returns `null` if the cast fails.
/// It is useful for safely handling dynamic types in MoonBit.
pub(open) trait Cast {
  into(Value) -> Self?
  from(Self) -> Value
}

// NOTE: Do we need a default implementation for the `from` method in `Cast` trait?
// 
// If the type `Self` can be cast from a `Value`, then it must can be cast back to a `Value` safely,
// only when the `Self` type is a abstract type that represents a JavaScript type.
//
// ```
// impl Cast with from(self) { Value::cast_from(self) }
// ```
//
// But if some one implements the `Cast` trait for a type that not an abstract type, 
// then the default implementation is not type-safe.

///|
pub impl Cast for String with into(value) { value.cast() }

///|
pub impl Cast for String with from(value) { Value::cast_from(value) }

///|
pub impl Cast for Int with into(value) { value.cast() }

///|
pub impl Cast for Int with from(value) { Value::cast_from(value) }

///|
pub impl Cast for Double with into(value) { value.cast() }

///|
pub impl Cast for Double with from(value) { Value::cast_from(value) }

///|
pub impl Cast for Bool with into(value) { value.cast() }

///|
pub impl Cast for Bool with from(value) { Value::cast_from(value) }

///|
pub impl[A] Cast for Array[A] with into(value) { value.cast() }

///|
pub impl[A] Cast for Array[A] with from(value) { Value::cast_from(value) }
