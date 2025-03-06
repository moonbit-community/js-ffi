///|
fn main {
  @js.async_test(fn() {
    let (op, k) = @js.with_resolvers_()
    println("before")
    @js.set_timeout(fn() { (k.val)(42) }, 1000)
    let a = op!!()
    // let b = op!!()
    // (k.val)(42)
    println(a)
    // println(b)
  })
}
