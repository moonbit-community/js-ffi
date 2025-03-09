///|
pub async fn suspend[T, E : Error](
  f : ((T) -> Unit, (E) -> Unit) -> Unit
) -> T!E = "%async.suspend"

///|
pub fn async_run(f : async () -> Unit) -> Unit = "%async.run"

///|
pub extern type Promise

///|
pub typealias AsyncOp = () -> Promise

///|
extern "js" fn async_wrap_ffi(
  op : AsyncOp,
  on_ok : (Value) -> Unit,
  on_err : (Value) -> Unit
) -> Unit = "(op, on_ok, on_err) => op().then((t) => on_ok(t), (e) => on_err(e))"

///|
extern "js" fn Promise::wait_ffi(
  self : Promise,
  on_ok : (Value) -> Unit,
  on_err : (Value) -> Unit
) -> Unit =
  #| (self, on_ok, on_err) => self.then((t) => on_ok(t), (e) => on_err(e))

///|
pub async fn Promise::wait(self : Promise) -> Value! {
  suspend!!(fn(k, ke) { Promise::wait_ffi(self, k, fn(e) { ke(Error_(e)) }) })
}

///|
pub fn Promise::new[T](op : async () -> T!) -> Promise {
  Promise::new_ffi(fn() { Value::cast_from(op!!()) })
}

///|
pub fn spawn_detach[T, E : Error](op : async () -> T!E) -> Unit {
  async_run(fn() {
    try {
      op!!() |> ignore
    } catch {
      _ => ()
    }
  })
}

///|
extern "js" fn Promise::new_ffi(op : async () -> Value!) -> Promise =
  #| (op) => new Promise((k, ke) => op(k, ke))

///|
/// # Note
/// The return type is guaranteed to be a `Promise` of an `Array`, but we omit that detail for simplicity.
pub extern "js" fn Promise::all(promises : Array[Promise]) -> Promise = "(ps) => Promise.all(ps)"

///|
/// Wraps each given `async fn` in a `Promise` and waits for all of them to resolve.
pub async fn async_all![T](ops : Array[async () -> T!]) -> Array[T] {
  async_all_raw!!(ops.map(fn(op) { async fn!() { Value::cast_from(op!!()) } })).map(
    Value::cast,
  )
}

///|
async fn async_all_raw!(ops : Array[async () -> Value!]) -> Array[Value] {
  Promise::all(ops.map(Promise::new)).wait!!().cast()
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
