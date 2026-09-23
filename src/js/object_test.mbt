///|
test "Object::extend_object" {
  let obj = @js.Object::from_value_unchecked(
    @json.from_json({ "a": 1, "b": 2, "c": 3 }),
  )
  let obj1 = @js.Object::from_value_unchecked(
    @json.from_json({ "b": [6, 7], "d": 44, "a": 55 }),
  )
  json_inspect(obj.extend_object(obj1).0.to_json(), content={
    "a": 55,
    "b": [6, 7],
    "c": 3,
    "d": 44,
  })
}

///|
test "Object indexing preserves named accessors" {
  let obj = @js.Object::new()
  obj["value"] = 42
  let indexed : Int = obj["value"]
  let named : Int = obj.get("value")
  assert_eq(indexed, 42)
  assert_eq(named, 42)
  obj.set("value", 7)
  let updated : Int = obj["value"]
  assert_eq(updated, 7)
}

///|
test "Object constructors preserve iterator entries" {
  let from_iter = @js.Object::from_iter([("first", 1), ("second", 2)].iter())
  let entries : Map[String, Int] = { "first": 1, "second": 2 }
  let from_iter2 = @js.Object::from_iter2(entries.iter2())
  for obj in [from_iter, from_iter2] {
    let first : Int = obj["first"]
    let second : Int = obj["second"]
    assert_eq(first, 1)
    assert_eq(second, 2)
  }
}

///|
extern "js" fn throw_show_test_value() -> @js.Value =
  #| () => { throw "message"; }

///|
test "Show methods remain callable on Value and Error_" {
  let value = @js.Value::cast_from("message")
  let value_output = StringBuilder()
  value.output(value_output)
  assert_eq(value_output.to_string(), "message")
  try
    @js.Error_::wrap(throw_show_test_value, map_ok=fn(value) { value })
  catch {
    error => {
      let error_output = StringBuilder()
      error.output(error_output)
      assert_eq(error_output.to_string(), "@js.Error: message")
      assert_eq(error.to_string(), "@js.Error: message")
      assert_true(error.cause() is None)
    }
  } noraise {
    _ => fail("expected the JavaScript value to be thrown")
  }
}
