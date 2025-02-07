///|
type Nullable[_]

///|
pub fn Nullable::is_null[T](self : Nullable[T]) -> Bool {
  Value::is_null(Value::cast_from(self))
}

///|
pub fn Nullable::get_exn[T](self : Nullable[T]) -> T = "%identity"

///|
pub fn Nullable::to_option[T](self : Nullable[T]) -> T? {
  guard not(Value::cast_from(self).is_null()) else { None }
  Some(self.get_exn())
}

///|
pub fn Nullable::null[T]() -> Nullable[T] {
  Value::null().cast()
}

///|
pub fn Nullable::from_option[T](value : T?) -> Nullable[T] {
  value.map(Value::cast_from).or_else(Value::null).cast()
}
