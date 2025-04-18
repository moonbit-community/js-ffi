///|
extern type Nullable[_]

///|
pub fn Nullable::is_null[T](self : Nullable[T]) -> Bool {
  Value::is_null(Value::cast_from(self))
}

///|
#deprecated("get_exn is not null-safety. Use `unwrap` or `unsafe_get` instead.")
pub fn Nullable::get_exn[T](self : Nullable[T]) -> T = "%identity"

///| Get the underlying value without checking for null.
/// 
/// This is unsafe and should only be used when you are sure that the value is not null.
/// It's recommended to use `unwrap` instead.
pub fn Nullable::unsafe_get[T](self : Nullable[T]) -> T = "%identity"

///| Get the underlying value with checking for null.
/// 
/// If the value is null, it will abort the program.
pub fn Nullable::unwrap[T](self : Nullable[T]) -> T {
  if self.is_null() {
    abort("unwrap on null")
  }
  self.unsafe_get()
}

///| Convert a Nullable value to an Option.
pub fn Nullable::to_option[T](self : Nullable[T]) -> T? {
  guard not(Value::cast_from(self).is_null()) else { None }
  Some(self.unsafe_get())
}

///|
pub fn Nullable::null[T]() -> Nullable[T] {
  Value::null().cast()
}

///|
pub fn Nullable::from_option[T](value : T?) -> Nullable[T] {
  value.map(Value::cast_from).or_else(Value::null).cast()
}
