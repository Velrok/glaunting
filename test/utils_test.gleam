import gleeunit
import gleeunit/should
import utils.{parse_labeled_argument}

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn parse_labeled_argument_test() {
  parse_labeled_argument("--name=loan1")
  |> should.equal(#("name", "loan1"))
}
