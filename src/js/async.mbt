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
pub fn Promise::dont_wait(self : Promise) -> Unit {
  self |> ignore
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

///|
extern "js" fn with_resolvers_ffi() -> Array[Value] =
  #|() => {
  #|  const {promise, resolve, reject} = Promise.withResolvers();
  #|  return [promise, resolve, reject]
  #|}

// ///|
// fn with_resolvers() -> (Promise, () -> Unit, () -> Unit) {
//   let results = with_resolvers_ffi()
//   (results[0].cast(), results[1].cast(), results[2].cast())
// }

///|
pub fn with_resolvers_[T]() -> (async () -> T!, Ref[(T) -> Unit]) {
  let v_ref : Ref[T?] = @ref.new(None)
  let k_ref : Ref[(T) -> Unit] = @ref.new(fn(t) { v_ref.val = Some(t) })
  let op = async fn!() {
    suspend!!(fn(k, _) {
      match v_ref.val {
        None => k_ref.val = fn(t) { k(t) }
        Some(t) => k(t)
      }
    })
  }
  (op, k_ref)
}

///|
pub extern "js" fn set_timeout(f : () -> Unit, n : Int) -> Unit =
  #|(f, n) => setTimeout(f, n)

///|
pub extern "js" fn debugger() -> Unit =
  #|() => { debugger; }

///|
extern "js" fn exit() -> Unit =
  #|() => process.exit(0)
