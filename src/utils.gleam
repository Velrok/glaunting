import gleam/int
import gleam/list
import gleam/option.{Some}
import gleam/regexp
import gleam/result
import gleam/string
import gleam/time/calendar.{type Date}

pub fn parse_labeled_argument(arg_string: String) {
  let pattern = "--([\\w_-]+)=(.*)"
  let assert Ok(compiled_regex) = regexp.from_string(pattern)
  case regexp.scan(compiled_regex, arg_string) {
    [match] ->
      case match.submatches {
        [Some(label), Some(value)] -> #(label, value)
        _ -> panic
      }
    _ -> panic as "invalid labled argumen"
  }
}

pub fn parse_date(s: String) -> Result(Date, String) {
  let pattern = "\\d{4}-\\d{2}-\\d{2}"
  let assert Ok(re) = regexp.from_string(pattern)

  case regexp.check(re, s) {
    False ->
      Error("Given string " <> s <> " cant be parsed by date re: " <> pattern)
    True -> {
      case string.split(s, "-") {
        [year_str, month_str, day_str] -> {
          let assert [Ok(year), Ok(month_no), Ok(day)] =
            [year_str, month_str, day_str] |> list.map(int.parse)
          let month = parse_month(month_no)
          case month {
            Error(_) -> Error("Invalid month no " <> month_str)
            Ok(month) -> Ok(calendar.Date(year, month, day))
          }
        }
        _ -> panic
      }
    }
  }
}

fn parse_month(month_no: Int) -> Result(calendar.Month, String) {
  case month_no {
    1 -> Ok(calendar.January)
    2 -> Ok(calendar.February)
    3 -> Ok(calendar.March)
    4 -> Ok(calendar.April)
    5 -> Ok(calendar.May)
    6 -> Ok(calendar.June)
    7 -> Ok(calendar.July)
    8 -> Ok(calendar.August)
    9 -> Ok(calendar.September)
    10 -> Ok(calendar.October)
    11 -> Ok(calendar.November)
    12 -> Ok(calendar.December)
    _ -> Error("Invalid month")
  }
}
