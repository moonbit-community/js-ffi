///|
extern type Optional[_]

///|
pub fn Optional::is_undefined[T](self : Optional[T]) -> Bool {
  self |> Value::cast_from |> Value::is_undefined
}

///| 
#deprecated("get_exn is not undefined-safety. Use `unwrap` or `to_option` instead.")
pub fn Optional::get_exn[T](self : Optional[T]) -> T = "%identity"

///| Get the underlying value without checking for undefined.
pub fn Optional::unsafe_get[T](self : Optional[T]) -> T = "%identity"

///| Get the underlying value with checking for undefined.
/// 
/// If the value is undefined, it will abort the program.
pub fn Optional::unwrap[T](self : Optional[T]) -> T {
  if self.is_undefined() {
    abort("unwrap on undefined")
  }
  self.unsafe_get()
}

///| Convert an Optional value to an Option.
pub fn Optional::to_option[T](self : Optional[T]) -> T? {
  if Value::cast_from(self).is_undefined() {
    None
  } else {
    Some(self.unsafe_get())
  }
}

///|
pub fn Optional::undefined[T]() -> Optional[T] {
  Value::undefined().cast()
}

///|
pub fn Optional::from_option[T](value : T?) -> Optional[T] {
  match value {
    Some(v) => Value::cast_from(v).cast()
    None => Optional::undefined()
  }
}
