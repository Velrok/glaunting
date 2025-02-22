import gleam/option.{Some}
import gleam/regexp

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
