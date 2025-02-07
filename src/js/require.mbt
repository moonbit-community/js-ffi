///|
extern "js" fn require_ffi(path : String) -> Value = "(path) => require(path)"

///|
pub fn require(path : String, keys~ : Array[String] = []) -> Value {
  keys.fold(init=require_ffi(path), fn {
    acc, key => get_ffi(acc, Value::cast_from(key))
  })
}
