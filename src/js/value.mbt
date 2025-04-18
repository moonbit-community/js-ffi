///|
pub extern type Value

///|
#deprecated("Use `Value::from` or `Value::unsafe_into` instead.")
pub fn Value::cast_from[T](value : T) -> Value = "%identity"

///| 
#deprecated("Use `Value::into` or `Value::unsafe_into` instead.")
pub fn Value::cast[T](self : Value) -> T = "%identity"

///| Create a `Value` from any type, without checking for null or undefined.
pub fn Value::unsafe_from[T](value : T) -> Value = "%identity"

///| Cast a `Value` to any type, without checking for null or undefined.
pub fn Value::unsafe_into[T](self : Value) -> T = "%identity"

///| Create a `Value` from any type, checking for null or undefined.
/// 
/// If the value is null or undefined, it will abort the program.
pub fn Value::from[T](self : Value) -> T {
  if self.is_null() {
    abort("Value::from on null")
  }
  if self.is_undefined() {
    abort("Value::from on undefined")
  }
  self.unsafe_into()
}

///| Convert a `Value` to any type, checking for null or undefined.
/// 
/// If the value is null or undefined, it will abort the program.
pub fn Value::into[T](self : Value) -> T {
  if self.is_null() {
    abort("Value::cast on null")
  }
  if self.is_undefined() {
    abort("Value::cast on undefined")
  }
  self.unsafe_into()
}

///|
pub extern "js" fn Value::to_string(self : Value) -> String = "(self) => self.toString()"

///|
pub impl Show for Value with output(self, logger) {
  logger.write_string(self.to_string())
}

///|
pub let globalThis : Value = get_globalThis()

///|
pub fn get_with_string[T](self : Value, key : String) -> T {
  self.get_ffi(Value::cast_from(key)).cast()
}

///|
pub fn get_with_symbol[T](self : Value, key : Symbol) -> T {
  self.get_ffi(Value::cast_from(key)).cast()
}

///|
pub fn get_with_index[T](self : Value, index : Int) -> T {
  self.get_ffi(Value::cast_from(index)).cast()
}

///|
pub fn set_with_string[T](self : Value, key : String, value : T) -> Unit {
  self.set_ffi(Value::cast_from(key), Value::cast_from(value))
}

///|
pub fn set_with_symbol[T](self : Value, key : Symbol, value : T) -> Unit {
  self.set_ffi(Value::cast_from(key), Value::cast_from(value))
}

///|
pub fn set_with_index[T](self : Value, index : Int, value : T) -> Unit {
  self.set_ffi(Value::cast_from(index), Value::cast_from(value))
}

///|
/// `self(...args)`
pub fn Value::apply[Arg, Result](self : Value, args : Array[Arg]) -> Result {
  self.apply_self_ffi(Value::cast_from(args)).cast()
}

///|
/// `self[key](...args)`
pub fn Value::apply_with_string[Arg, Result](
  self : Value,
  key : String,
  args : Array[Arg]
) -> Result {
  self.apply_ffi(Value::cast_from(key), Value::cast_from(args)).cast()
}

///|
/// `self[key](...args)`
pub fn Value::apply_with_symbol[Arg, Result](
  self : Value,
  key : Symbol,
  args : Array[Arg]
) -> Result {
  self.apply_ffi(Value::cast_from(key), Value::cast_from(args)).cast()
}

///|
/// `self[index](...args)`
pub fn Value::apply_with_index[Arg, Result](
  self : Value,
  index : Int,
  args : Array[Arg]
) -> Result {
  self.apply_ffi(Value::cast_from(index), Value::cast_from(args)).cast()
}

///|
/// `new self(...args)`
pub fn Value::new[Arg, Result](self : Value, args : Array[Arg]) -> Result {
  self.new_self_ffi(Value::cast_from(args)).cast()
}

///|
/// `new self[key](...args)`
pub fn Value::new_with_string[Arg, Result](
  self : Value,
  key : String,
  args : Array[Arg]
) -> Result {
  self.new_ffi(Value::cast_from(key), Value::cast_from(args)).cast()
}

///|
/// `new self[key](...args)`
pub fn Value::new_with_symbol[Arg, Result](
  self : Value,
  key : Symbol,
  args : Array[Arg]
) -> Result {
  self.new_ffi(Value::cast_from(key), Value::cast_from(args)).cast()
}

///|
/// `new self[index](...args)`
pub fn Value::new_with_index[Arg, Result](
  self : Value,
  index : Int,
  args : Array[Arg]
) -> Result {
  self.new_ffi(Value::cast_from(index), Value::cast_from(args)).cast()
}

///|
pub fn Value::from_json!(json : Json) -> Value {
  @json.from_json!(json)
}

///|
pub impl @json.FromJson for Value with from_json(json : Json, path) {
  match json {
    String(s) => Value::cast_from(s)
    Number(n) => Value::cast_from(n)
    False => Value::cast_from(false)
    True => Value::cast_from(true)
    Null => Value::null()
    Array(xs) => {
      let acc = Array::new(capacity=xs.length())
      for x in xs {
        acc.push((@json.from_json!(x, path~) : Value))
      }
      Value::cast_from(acc)
    }
    Object(kvs) => {
      let acc = Object::new()
      for k, v in kvs {
        acc._.set_with_string(k, (@json.from_json!(v, path~) : Value))
      }
      acc._
    }
  }
}

///|
pub fn Value::from_json_string!(str : String) -> Value {
  Error_::wrap!(fn() { Value::from_json_string_ffi(str) })
}

///|
extern "js" fn Value::from_json_string_ffi(str : String) -> Value = "JSON.parse"

///|
pub fn Value::to_json_string!(self : Value) -> String {
  Error_::wrap!(fn() { self.to_json_string_ffi() })
}

///|
pub fn Value::to_json!(self : Value) -> Json {
  @json.parse!(self.to_json_string!())
}

///|
extern "js" fn Value::to_json_string_ffi(self : Value) -> Value =
  #| (self) => JSON.stringify(self)

///|
pub extern "js" fn is_bool(self : Value) -> Bool =
  #| (value) => Object.is(typeof value, 'boolean')

///|
pub extern "js" fn is_null(self : Value) -> Bool =
  #| (n) => Object.is(n, null)

///|
pub extern "js" fn is_undefined(self : Value) -> Bool =
  #| (n) => Object.is(n, undefined)

///|
pub extern "js" fn is_number(self : Value) -> Bool =
  #| (n) => Object.is(typeof n, "number")

///|
pub extern "js" fn is_string(self : Value) -> Bool =
  #| (n) => Object.is(typeof n, "string")

///|
pub extern "js" fn is_object(self : Value) -> Bool =
  #| (n) => Object.is(typeof n, "object")

///|
pub extern "js" fn is_symbol(self : Value) -> Bool =
  #| (n) => Object.is(typeof n, "symbol")

///|
extern "js" fn get_globalThis() -> Value =
  #| () => globalThis

///|
extern "js" fn get_ffi(self : Value, key : Value) -> Value =
  #| (obj, key) => obj[key]

///|
extern "js" fn set_ffi(self : Value, key : Value, value : Value) =
  #| (obj, key, value) => { obj[key] = value }

///|
extern "js" fn apply_ffi(self : Value, key : Value, args : Value) -> Value =
  #| (self, key, args) => self[key](...args)

///|
extern "js" fn apply_self_ffi(self : Value, args : Value) -> Value =
  #| (self, args) => self(...args)

///|
extern "js" fn new_ffi(self : Value, key : Value, args : Value) -> Value =
  #| (self, key, args) => new self[key](...args)

///|
extern "js" fn new_self_ffi(self : Value, args : Value) -> Value =
  #| (self, args) => new self(...args)

///|
extern "js" fn Value::null() -> Value =
  #| () => null

///|
extern "js" fn Value::undefined() -> Value =
  #| () => undefined

///| @param self The constructor function that accepts this as the first argument
pub extern "js" fn extends(self : Value, parent_constructor : Value) -> Value =
  #|(f, parent) => {
  #|  return class extends parent {
  #|    constructor(...args) {
  #|      super();
  #|      f(this, ...args);
  #|    }
  #|  }
  #|}
