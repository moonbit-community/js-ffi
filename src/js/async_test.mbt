///|
async fn op1() -> String? {
  Some("Hello")
}

///|
async fn op2() -> String? {
  guard let Some(prefix) = op1!!()
  Some(prefix + ", World")
}

///|
async fn op3() -> String? {
  None
}

///|
test "async_unwrap" {
  @js.async_test(async fn!() {
    let res = @js.async_wrap!!(fn() { @js.async_unwrap(async fn() { op1!!() }) })
    assert_eq!(res.cast(), Some("Hello"))
  })
}

///|
test "async_all" {
  @js.async_test(async fn!() {
    assert_eq!(
      @js.async_all!!([
        async fn() { op2!!() },
        async fn() { op1!!() },
        async fn() { op3!!() },
      ]),
      [Some("Hello, World"), Some("Hello"), None],
    )
  })
}
