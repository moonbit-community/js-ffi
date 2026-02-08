///|
#external
pub type Iterator[T]

///|
#warnings("-unused_field")
priv struct IteratorResult {
  value : Value
  done : Bool
}

///|
fn[T] IteratorResult::cast(self : IteratorResult) -> T? {
  if self.done {
    None
  } else {
    Some(self.value.cast())
  }
}

///|
pub fn[T] Iterator::from_iter(iter : Iter[T]) -> Iterator[T] {
  Object::new()
  ..op_set("next", () => match iter.next() {
    Some(value) => { value: Value::cast_from(value), done: false }
    None => { value: Value::undefined(), done: true }
  })
  .to_value()
  .cast()
}

///|
pub fn[T] Iterator::iter(self : Iterator[T]) -> Iter[T] {
  Iter::new(() => self.next())
}

///|
pub fn[T] Iterator::next(self : Iterator[T]) -> T? {
  let result : IteratorResult = Value::cast_from(self).apply0_with_string(
    "next",
  )
  result.cast()
}

///|
pub fn[T, Next] Iterator::next_with(self : Iterator[T], value : Next) -> T? {
  let result : IteratorResult = Value::cast_from(self).apply_with_string(
    "next",
    [Value::cast_from(value)],
  )
  result.cast()
}

///|
pub fn[T] Iterator::can_stop(self : Iterator[T]) -> Bool {
  Value::cast_from(self).has("return")
}

///|
pub fn[T] Iterator::stop(self : Iterator[T]) -> Unit {
  Value::cast_from(self).apply0_with_string("return")
}

///|
pub fn[T] Iterator::stop_with(self : Iterator[T], value : T) -> T? {
  let result : IteratorResult = Value::cast_from(self).apply_with_string(
    "return",
    [Value::cast_from(value)],
  )
  result.cast()
}

///|
pub fn[T] Iterator::can_throw(self : Iterator[T]) -> Bool {
  Value::cast_from(self).has("throw")
}

///|
pub fn[T] Iterator::throw_(self : Iterator[T]) -> T? {
  let result : IteratorResult = Value::cast_from(self).apply0_with_string(
    "throw",
  )
  result.cast()
}

///|
pub fn[T, Err] Iterator::throw_with(self : Iterator[T], value : Err) -> T? {
  let result : IteratorResult = Value::cast_from(self).apply_with_string(
    "throw",
    [Value::cast_from(value)],
  )
  result.cast()
}

///|
#external
pub type Iterable[T]

///|
/// Test if a given object might be iterable.
/// This function only checks for the presence of the `Symbol.iterator` property and that it is a function.
/// The actual iteration protocol is not verified.
pub fn Iterable::might_be_iterable(obj : Value) -> Bool {
  obj.has_symbol(iterator) &&
  (obj.get_with_symbol(iterator) : Value).is_function()
}

///|
pub fn[T] Iterable::iterator(self : Iterable[T]) -> Iterator[T] {
  Value::cast_from(self).apply0_with_symbol(iterator)
}

///|
pub fn[T] Iterable::iter(self : Iterable[T]) -> Iter[T] {
  self.iterator().iter()
}

pub fn[T] Iterable::from_iter(iter : Iter[T]) -> Iterable[T] {
  Object::new()
  ..op_set(iterator, () => Iterator::from_iter(iter))
  .to_value()
  .cast()
}
