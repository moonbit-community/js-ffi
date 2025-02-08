///|
pub type! Error_ Value

///|
extern "js" fn Error_::cause_ffi(self : Value) -> Value = "(self) => self.cause"

///|
pub fn Error_::cause(self : Error_) -> Value? {
  let Error_(inner) = self
  let cause = Error_::cause_ffi(inner)
  guard not(cause.is_undefined()) else { None }
  Some(cause.cast())
}

///|
pub impl Show for Error_ with output(self, logger) {
  logger.write_string("@js.Error: ")
  let Error_(inner) = self
  logger.write_object(inner)
  guard let Some(cause_inner) = self.cause() else { _ => return }
  logger.write_string("\n  caused by:\n")
  logger.write_object(cause_inner)
}

///|
extern "js" fn Error_::wrap_ffi(
  op : () -> Value,
  on_ok : (Value) -> Unit,
  on_error : (Value) -> Unit
) -> Unit =
  #| (op, on_ok, on_error) => { try { on_ok(op()); } catch (e) { on_error(e); } }

///|
pub fn Error_::wrap[T](
  op : () -> Value,
  map_ok~ : (Value) -> T = Value::cast
) -> T!Error_ {
  let mut res : Result[Value, Error_] = Ok(Value::undefined())
  Error_::wrap_ffi(op, fn(v) { res = Ok(v) }, fn(e) { res = Err(Error_(e)) })
  guard let Ok(v) = res else { Err(e) => raise e }
  map_ok(v)
}
