///|
pub async fn suspend[T, E : Error](
  f : ((T) -> Unit, (E) -> Unit) -> Unit
) -> T!E = "%async.suspend"

///|
pub fn async_run(f : async () -> Unit) -> Unit = "%async.run"

///|
pub type Promise[_]

///|
pub typealias AsyncOp = () -> Promise[Value]

///|
extern "js" fn async_wrap_ffi(
  op : AsyncOp,
  on_ok : (Value) -> Unit,
  on_err : (Value) -> Unit
) -> Unit = "(op, on_ok, on_err) => op().then((t) => on_ok(t)).catch((e) => on_err(e))"

///|
pub async fn async_wrap(op : AsyncOp) -> Value! {
  suspend!!(fn(k, ke) { async_wrap_ffi(op, k, fn(e) { ke(Error_(e)) }) })
}

///|
extern "js" fn async_unwrap_ffi(op : async () -> Value!) -> Promise[Value] =
  #| (op) => new Promise((k, ke) => op(k, ke))

///|
pub fn async_unwrap[T](op : async () -> T!) -> Promise[Value] {
  async_unwrap_ffi(fn() { Value::cast_from(op!!()) })
}

///|
/// # Note
/// The return type is guaranteed to be a `Promise[Array[Value]]`, but we omit that detail for simplicity.
extern "js" fn Promise::all_ffi(ops : Array[Promise[Value]]) -> Promise[Value] = "(ops) => Promise.all(ops)"

///|
async fn async_all_raw!(ops : Array[async () -> Value!]) -> Array[Value] {
  async_wrap!!(fn() { Promise::all_ffi(ops.map(async_unwrap_ffi)) }).cast()
}

///|
pub async fn async_all![T](ops : Array[async () -> T!]) -> Array[T] {
  async_all_raw!!(ops.map(fn(op) { async fn!() { Value::cast_from(op!!()) } })).map(
    Value::cast,
  )
}

///|
pub fn async_test(op : async () -> Unit!) -> Unit {
  async_run(async fn() {
    try {
      op!!()
    } catch {
      e => {
        println("ERROR in `async_test`: \{e}")
        panic()
      }
    }
  })
}
