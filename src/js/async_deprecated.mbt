///| @alert deprecated "use Promise::wait instead"
pub async fn async_wrap(op : AsyncOp) -> Value! {
  suspend!!(fn(k, ke) { async_wrap_ffi(op, k, fn(e) { ke(Error_(e)) }) })
}

///| @alert deprecated "use Promise::new instead"
pub fn async_unwrap[T](op : async () -> T!) -> Promise {
  Promise::new_ffi(fn() { Value::cast_from(op!!()) })
}
