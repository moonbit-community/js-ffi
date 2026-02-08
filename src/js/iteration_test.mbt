///|
extern "js" fn generator() -> Iterable[String] =
  #|function*() {
  #|  try {
  #|    yield "a";
  #|    yield "b";
  #|    if (yield "c") {
  #|      yield "d";
  #|    }
  #|  } catch (e) {
  #|    yield "caught " + e;
  #|  }
  #|}

///|
test "Iterable::might_be_iterable" {
  let it = generator()
  inspect(Iterable::might_be_iterable(Value::cast_from(it)), content="true")
  inspect(Iterable::might_be_iterable(Value::cast_from(42)), content="false")
}

///|
test "Iterable::iter" {
  let it = generator()
  let iter = it.iter()
  inspect(
    iter.collect(),
    content=(
      #|["a", "b", "c"]
    ),
  )
}

///|
test "Iterator::next" {
  let it = generator()
  let iter = it.iterator()
  inspect(
    iter.next(),
    content=(
      #|Some("a")
    ),
  )
  inspect(
    iter.next(),
    content=(
      #|Some("b")
    ),
  )
  inspect(
    iter.next(),
    content=(
      #|Some("c")
    ),
  )
  inspect(iter.next() is None, content="true")
}

///|
test "Iterator::next with conditional yield" {
  let it = generator()
  let iter = it.iterator()
  for _ in 0..<3 {
    iter.next() |> ignore
  }
  inspect(
    iter.next_with(true),
    content=(
      #|Some("d")
    ),
  )
}

///|
test "Iterator::can_stop and Iterator::stop" {
  let it = generator()
  let iter = it.iterator()
  inspect(iter.can_stop(), content="true")
  iter.stop()
  inspect(iter.next() is None, content="true")
}

///|
test "Iterator::stop_with" {
  let it = generator()
  let iter = it.iterator()
  inspect(iter.can_stop(), content="true")
  inspect(iter.stop_with("stopped"), content="None")
}

///|
test "Iterator::can_throw and Iterator::throw_" {
  let it = generator()
  let iter = it.iterator()
  inspect(iter.can_throw(), content="true")
  iter.next() |> ignore
  inspect(
    iter.throw_(),
    content=(
      #|Some("caught undefined")
    ),
  )
  inspect(iter.next() is None, content="true")
}

///|
test "Iterator::throw_with" {
  let it = generator()
  let iter = it.iterator()
  inspect(iter.can_throw(), content="true")
  iter.next() |> ignore
  inspect(
    iter.throw_with("error"),
    content=(
      #|Some("caught error")
    ),
  )
  inspect(iter.next() is None, content="true")
}

test "Iterator::from_iter" {
  let arr = [1, 1, 4]
  let it = Iterator::from_iter(arr.iter())
  inspect(it.iter().collect(), content="[1, 1, 4]")
}

test "Iterable::from_iter" {
  let arr = [5, 1, 4]
  let iterable = Iterable::from_iter(arr.iter())
  inspect(iterable.iter().collect(), content="[5, 1, 4]")
}
