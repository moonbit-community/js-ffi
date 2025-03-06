///|
async fn op1() -> String? {
  Some("Hello")
}

///|
async fn op2() -> String? {
  guard op1!!() is Some(prefix)
  Some(prefix + ", World")
}

///|
async fn op3() -> String? {
  None
}

///|
test "Promise::wait" {
  @js.async_test(fn!() {
    let res = @js.Promise::new(fn() { op1!!() }).wait!!()
    assert_eq!(res.cast(), Some("Hello"))
  })
}

///|
test "async_all" {
  @js.async_test(fn!() {
    assert_eq!(
      @js.async_all!!([fn() { op2!!() }, fn() { op1!!() }, fn() { op3!!() }]),
      [Some("Hello, World"), Some("Hello"), None],
    )
  })
}

///|
test "with_resolvers" {
  async_test(fn() {
    let (op, k) = with_resolvers_()
    println("before")
    set_timeout(fn() { (k.val)(42) }, 1000)
    let a = op!!()
    println(a)
  })
}
