///| Union type `A | B` for JavaScript values.
type Union2[_, _]

///|
pub fn Union2::to1[A : Cast, B](self : Union2[A, B]) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union2::to2[A, B : Cast](self : Union2[A, B]) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union2::from1[A : Cast, B](value : A) -> Union2[A, B] {
  Cast::from(value).cast()
}

///|
pub fn Union2::from2[A, B : Cast](value : B) -> Union2[A, B] {
  Cast::from(value).cast()
}

///| Union type `A | B | C` for JavaScript values.
type Union3[_, _, _]

///|
pub fn Union3::to1[A : Cast, B, C](self : Union3[A, B, C]) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union3::to2[A, B : Cast, C](self : Union3[A, B, C]) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union3::to3[A, B, C : Cast](self : Union3[A, B, C]) -> C? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union3::from1[A : Cast, B, C](value : A) -> Union3[A, B, C] {
  Cast::from(value).cast()
}

///|
pub fn Union3::from2[A, B : Cast, C](value : B) -> Union3[A, B, C] {
  Cast::from(value).cast()
}

///|
pub fn Union3::from3[A, B, C : Cast](value : C) -> Union3[A, B, C] {
  Cast::from(value).cast()
}

///| Union type `A | B | C | D` for JavaScript values.
type Union4[_, _, _, _]

///|
pub fn Union4::to1[A : Cast, B, C, D](self : Union4[A, B, C, D]) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union4::to2[A, B : Cast, C, D](self : Union4[A, B, C, D]) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union4::to3[A, B, C : Cast, D](self : Union4[A, B, C, D]) -> C? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union4::to4[A, B, C, D : Cast](self : Union4[A, B, C, D]) -> D? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union4::from1[A : Cast, B, C, D](value : A) -> Union4[A, B, C, D] {
  Cast::from(value).cast()
}

///|
pub fn Union4::from2[A, B : Cast, C, D](value : B) -> Union4[A, B, C, D] {
  Cast::from(value).cast()
}

///|
pub fn Union4::from3[A, B, C : Cast, D](value : C) -> Union4[A, B, C, D] {
  Cast::from(value).cast()
}

///|
pub fn Union4::from4[A, B, C, D : Cast](value : D) -> Union4[A, B, C, D] {
  Cast::from(value).cast()
}

///| Union type `A | B | C | D | E` for JavaScript values.
type Union5[_, _, _, _, _]

///|
pub fn Union5::to1[A : Cast, B, C, D, E](self : Union5[A, B, C, D, E]) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union5::to2[A, B : Cast, C, D, E](self : Union5[A, B, C, D, E]) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union5::to3[A, B, C : Cast, D, E](self : Union5[A, B, C, D, E]) -> C? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union5::to4[A, B, C, D : Cast, E](self : Union5[A, B, C, D, E]) -> D? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union5::to5[A, B, C, D, E : Cast](self : Union5[A, B, C, D, E]) -> E? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union5::from1[A : Cast, B, C, D, E](value : A) -> Union5[A, B, C, D, E] {
  Cast::from(value).cast()
}

///|
pub fn Union5::from2[A, B : Cast, C, D, E](value : B) -> Union5[A, B, C, D, E] {
  Cast::from(value).cast()
}

///|
pub fn Union5::from3[A, B, C : Cast, D, E](value : C) -> Union5[A, B, C, D, E] {
  Cast::from(value).cast()
}

///|
pub fn Union5::from4[A, B, C, D : Cast, E](value : D) -> Union5[A, B, C, D, E] {
  Cast::from(value).cast()
}

///|
pub fn Union5::from5[A, B, C, D, E : Cast](value : E) -> Union5[A, B, C, D, E] {
  Cast::from(value).cast()
}

///| Union type `A | B | C | D | E | F` for JavaScript values.
type Union6[_, _, _, _, _, _]

///|
pub fn Union6::to1[A : Cast, B, C, D, E, F](
  self : Union6[A, B, C, D, E, F]
) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union6::to2[A, B : Cast, C, D, E, F](
  self : Union6[A, B, C, D, E, F]
) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union6::to3[A, B, C : Cast, D, E, F](
  self : Union6[A, B, C, D, E, F]
) -> C? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union6::to4[A, B, C, D : Cast, E, F](
  self : Union6[A, B, C, D, E, F]
) -> D? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union6::to5[A, B, C, D, E : Cast, F](
  self : Union6[A, B, C, D, E, F]
) -> E? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union6::to6[A, B, C, D, E, F : Cast](
  self : Union6[A, B, C, D, E, F]
) -> F? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union6::from1[A : Cast, B, C, D, E, F](
  value : A
) -> Union6[A, B, C, D, E, F] {
  Cast::from(value).cast()
}

///|
pub fn Union6::from2[A, B : Cast, C, D, E, F](
  value : B
) -> Union6[A, B, C, D, E, F] {
  Cast::from(value).cast()
}

///|
pub fn Union6::from3[A, B, C : Cast, D, E, F](
  value : C
) -> Union6[A, B, C, D, E, F] {
  Cast::from(value).cast()
}

///|
pub fn Union6::from4[A, B, C, D : Cast, E, F](
  value : D
) -> Union6[A, B, C, D, E, F] {
  Cast::from(value).cast()
}

///|
pub fn Union6::from5[A, B, C, D, E : Cast, F](
  value : E
) -> Union6[A, B, C, D, E, F] {
  Cast::from(value).cast()
}

///|
pub fn Union6::from6[A, B, C, D, E, F : Cast](
  value : F
) -> Union6[A, B, C, D, E, F] {
  Cast::from(value).cast()
}

///| Union type `A | B | C | D | E | F | G` for JavaScript values.
type Union7[_, _, _, _, _, _, _]

///|
pub fn Union7::to1[A : Cast, B, C, D, E, F, G](
  self : Union7[A, B, C, D, E, F, G]
) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::to2[A, B : Cast, C, D, E, F, G](
  self : Union7[A, B, C, D, E, F, G]
) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::to3[A, B, C : Cast, D, E, F, G](
  self : Union7[A, B, C, D, E, F, G]
) -> C? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::to4[A, B, C, D : Cast, E, F, G](
  self : Union7[A, B, C, D, E, F, G]
) -> D? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::to5[A, B, C, D, E : Cast, F, G](
  self : Union7[A, B, C, D, E, F, G]
) -> E? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::to6[A, B, C, D, E, F : Cast, G](
  self : Union7[A, B, C, D, E, F, G]
) -> F? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::to7[A, B, C, D, E, F, G : Cast](
  self : Union7[A, B, C, D, E, F, G]
) -> G? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union7::from1[A : Cast, B, C, D, E, F, G](
  value : A
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///|
pub fn Union7::from2[A, B : Cast, C, D, E, F, G](
  value : B
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///|
pub fn Union7::from3[A, B, C : Cast, D, E, F, G](
  value : C
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///|
pub fn Union7::from4[A, B, C, D : Cast, E, F, G](
  value : D
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///|
pub fn Union7::from5[A, B, C, D, E : Cast, F, G](
  value : E
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///|
pub fn Union7::from6[A, B, C, D, E, F : Cast, G](
  value : F
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///|
pub fn Union7::from7[A, B, C, D, E, F, G : Cast](
  value : G
) -> Union7[A, B, C, D, E, F, G] {
  Cast::from(value).cast()
}

///| Union type `A | B | C | D | E | F | G | H` for JavaScript values.
type Union8[_, _, _, _, _, _, _, _]

///|
pub fn Union8::to1[A : Cast, B, C, D, E, F, G, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> A? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to2[A, B : Cast, C, D, E, F, G, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> B? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to3[A, B, C : Cast, D, E, F, G, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> C? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to4[A, B, C, D : Cast, E, F, G, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> D? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to5[A, B, C, D, E : Cast, F, G, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> E? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to6[A, B, C, D, E, F : Cast, G, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> F? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to7[A, B, C, D, E, F, G : Cast, H](
  self : Union8[A, B, C, D, E, F, G, H]
) -> G? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::to8[A, B, C, D, E, F, G, H : Cast](
  self : Union8[A, B, C, D, E, F, G, H]
) -> H? {
  Cast::into(Value::cast_from(self))
}

///|
pub fn Union8::from1[A : Cast, B, C, D, E, F, G, H](
  value : A
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from2[A, B : Cast, C, D, E, F, G, H](
  value : B
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from3[A, B, C : Cast, D, E, F, G, H](
  value : C
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from4[A, B, C, D : Cast, E, F, G, H](
  value : D
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from5[A, B, C, D, E : Cast, F, G, H](
  value : E
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from6[A, B, C, D, E, F : Cast, G, H](
  value : F
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from7[A, B, C, D, E, F, G : Cast, H](
  value : G
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}

///|
pub fn Union8::from8[A, B, C, D, E, F, G, H : Cast](
  value : H
) -> Union8[A, B, C, D, E, F, G, H] {
  Cast::from(value).cast()
}
