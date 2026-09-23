///|
test "Cast arrays accepts empty and populated JavaScript arrays" {
  let empty : Array[Int]? = @js.Cast::into(@js.Value::from_json_string("[]"))
  assert_eq(empty, Some([]))
  let values : Array[Int]? = @js.Cast::into(
    @js.Value::from_json_string("[1, 2, 3]"),
  )
  assert_eq(values, Some([1, 2, 3]))
}

///|
test "Cast arrays rejects non-arrays and invalid elements" {
  for input in ["null", "{}", "42", "[1, false]", "[1, 1.5]"] {
    let values : Array[Int]? = @js.Cast::into(
      @js.Value::from_json_string(input),
    )
    assert_eq(values, None)
  }
}

///|
test "Cast nested arrays converts in both directions" {
  let values : Array[Array[Int]] = [[1, 2], [], [3]]
  let raw = @js.Cast::from(values)
  assert_eq(raw.to_json_string(), "[[1,2],[],[3]]")
  let decoded : Array[Array[Int]]? = @js.Cast::into(raw)
  assert_eq(decoded, Some(values))
  let invalid : Array[Array[Int]]? = @js.Cast::into(
    @js.Value::from_json_string("[[1], [false]]"),
  )
  assert_eq(invalid, None)
}

///|
priv struct DecodedInt {
  value : Int
}

///|
impl @js.Cast for DecodedInt with fn into(raw) {
  let value : Int? = @js.Cast::into(raw)
  value.map(fn(value) { { value, } })
}

///|
impl @js.Cast for DecodedInt with fn from(value) {
  @js.Cast::from(value.value)
}

///|
test "Cast arrays applies element conversions" {
  let values : Array[DecodedInt]? = @js.Cast::into(
    @js.Value::from_json_string("[7, 11]"),
  )
  let decoded = values.unwrap()
  assert_eq(decoded.length(), 2)
  assert_eq(decoded[0].value, 7)
  assert_eq(decoded[1].value, 11)
}

///|
test "Cast arrays encodes converted elements" {
  let values : Array[DecodedInt] = [{ value: 7, }, { value: 11, }]
  assert_eq(@js.Cast::from(values).to_json_string(), "[7,11]")
}
