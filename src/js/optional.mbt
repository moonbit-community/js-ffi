///|
extern type Optional[_]

///|
pub fn[T] Optional::is_undefined(self : Optional[T]) -> Bool {
  self |> Value::cast_from |> Value::is_undefined
}

///|
pub fn[T] Optional::get_exn(self : Optional[T]) -> T = "%identity"

///|
pub fn[T] Optional::to_option(self : Optional[T]) -> T? {
  if Value::cast_from(self).is_undefined() {
    None
  } else {
    Some(self.get_exn())
  }
}

///|
pub fn[T] Optional::undefined() -> Optional[T] {
  Value::undefined().cast()
}

///|
pub fn[T] Optional::from_option(value : T?) -> Optional[T] {
  match value {
    Some(v) => Value::cast_from(v).cast()
    None => Optional::undefined()
  }
}
