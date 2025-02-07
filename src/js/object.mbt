///|
pub type Object Value

///|
pub extern "js" fn Object::new() -> Object = "() => new Object()"

///|
pub extern "js" fn Object::from_value(value : Value) -> Object = "#| (value) => new Object(value)"

///|
pub fn Object::extend_iter[K, V](self : Object, it : Iter[(K, V)]) -> Unit {
  for p in it {
    self[p.0] = p.1
  }
}

///|
pub fn Object::from_iter[K, V](it : Iter[(K, V)]) -> Object {
  Object::new()..extend_iter(it)
}

///|
pub fn Object::extend_iter2[K, V](self : Object, it : Iter2[K, V]) -> Unit {
  for k, v in it {
    self[k] = v
  }
}

///|
pub fn Object::from_iter2[K, V](it : Iter2[K, V]) -> Object {
  Object::new()..extend_iter2(it)
}

///|
pub fn Object::op_get[K, V](self : Object, key : K) -> V {
  self._.get_ffi(Value::cast_from(key)).cast()
}

///|
pub fn Object::op_set[K, V](self : Object, key : K, value : V) -> Unit {
  self._.set_ffi(Value::cast_from(key), Value::cast_from(value))
}
