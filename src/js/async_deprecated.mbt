///| @alert deprecated "use Promise directly instead"
pub typealias AsyncOp = () -> Promise

///|
extern "js" fn async_wrap_ffi(
  op : AsyncOp,
  on_ok : (Value) -> Unit,
  on_err : (Value) -> Unit
) -> Unit = "(op, on_ok, on_err) => op().then((t) => on_ok(t), (e) => on_err(e))"

///| @alert deprecated "use Promise::wait instead"
pub async fn async_wrap(op : AsyncOp) -> Value! {
  suspend!!(fn(k, ke) { async_wrap_ffi(op, k, fn(e) { ke(Error_(e)) }) })
}

///| @alert deprecated "use Promise::new instead"
pub fn async_unwrap[T](op : async () -> T!) -> Promise {
  Promise::new_ffi(fn() { Value::cast_from(op!!()) })
}
