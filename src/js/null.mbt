///|
extern type Nullable[_]

///|
pub fn[T] Nullable::is_null(self : Nullable[T]) -> Bool {
  Value::is_null(Value::cast_from(self))
}

///|
pub fn[T] Nullable::get_exn(self : Nullable[T]) -> T = "%identity"

///|
pub fn[T] Nullable::to_option(self : Nullable[T]) -> T? {
  guard not(Value::cast_from(self).is_null()) else { None }
  Some(self.get_exn())
}

///|
pub fn[T] Nullable::null() -> Nullable[T] {
  Value::null().cast()
}

///|
pub fn[T] Nullable::from_option(value : T?) -> Nullable[T] {
  value.map(Value::cast_from).or_else(Value::null).cast()
}
