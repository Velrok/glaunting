import gleam/time/calendar
import gleeunit
import gleeunit/should
import utils.{parse_date, parse_labeled_argument}

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn parse_labeled_argument_test() {
  parse_labeled_argument("--name=loan1")
  |> should.equal(#("name", "loan1"))
}

// gleeunit test functions end in `_test`
pub fn parse_date_test() {
  parse_date("2015-02-12")
  |> should.equal(Ok(calendar.Date(2015, calendar.February, 12)))
  parse_date("2015-13-12")
  |> should.equal(Error("Invalid month no 13"))
  // :( Dates does not provide validation
  parse_date("2015-12-44")
  |> should.equal(Ok(calendar.Date(2015, calendar.December, 44)))
}
