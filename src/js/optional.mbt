///|
type Optional[_]

///|
pub fn Optional::is_undefined[T](self : Optional[T]) -> Bool {
  self |> Value::cast_from |> Value::is_undefined
}

///|
pub fn Optional::get_exn[T](self : Optional[T]) -> T = "%identity"

///|
pub fn Optional::to_option[T](self : Optional[T]) -> T? {
  if Value::cast_from(self).is_undefined() {
    None
  } else {
    Some(self.get_exn())
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
