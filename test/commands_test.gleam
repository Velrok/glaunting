import commands.{parse_labeled_argument}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn parse_labeled_argument_test() {
  parse_labeled_argument("--name=loan1")
  |> should.equal(#("name", "loan1"))
}
