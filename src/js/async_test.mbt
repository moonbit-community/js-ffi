///|
fn op1() -> String? noraise {
  Some("Hello")
}

///|
fn op2() -> String? noraise {
  guard op1() is Some(prefix)
  Some(prefix + ", World")
}

///|
fn op3() -> String? noraise {
  None
}

///|
test "Promise::wait" {
  @js.async_test(fn() raise {
    // Promise::unsafe_new + Promise::wait is a noop.
    let res = @js.Promise::unsafe_new(fn() { op1() }).wait()
    assert_eq(res.cast(), Some("Hello"))
  })
}

///|
test "async_all" {
  @js.async_test(fn() raise {
    assert_eq(@js.async_all([fn() { op2() }, fn() { op1() }, fn() { op3() }]), [
      Some("Hello, World"),
      Some("Hello"),
      None,
    ])
  })
}

///|
test "async_all returns a growable empty array" {
  @js.async_test(async fn() {
    let ops : Array[async () -> Int] = []
    let values = @js.async_all(ops)
    assert_eq(values.length(), 0)
    values.push(7)
    assert_eq(values, [7])
  })
}

///|
test "async_all preserves nested MoonBit values and ordering" {
  @js.async_test(async fn() {
    let values = @js.async_all([fn() { [1, 2] }, fn() { [] }, fn() { [3] }])
    assert_eq(values, [[1, 2], [], [3]])
    values.push([4])
    assert_eq(values, [[1, 2], [], [3], [4]])
  })
}
