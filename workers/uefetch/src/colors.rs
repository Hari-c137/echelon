use std::sync::LazyLock;

pub struct Colors {
  pub reset:   &'static str,
  pub blue:    &'static str,
  pub cyan:    &'static str,
  pub green:   &'static str,
  pub yellow:  &'static str,
  pub red:     &'static str,
  pub magenta: &'static str,
}

impl Colors {
  const fn new(is_no_color: bool) -> Self {
    if is_no_color {
      Self {
        reset:   "",
        blue:    "",
        cyan:    "",
        green:   "",
        yellow:  "",
        red:     "",
        magenta: "",
      }
    } else {
      Self {
        reset:   "\x1b[0m",
        blue:    "\x1b[34m",
        cyan:    "\x1b[36m",
        green:   "\x1b[32m",
        yellow:  "\x1b[33m",
        red:     "\x1b[31m",
        magenta: "\x1b[35m",
      }
    }
  }
}

pub static COLORS: LazyLock<Colors> = LazyLock::new(|| {
  const NO_COLOR: *const libc::c_char = c"NO_COLOR".as_ptr();
  let is_no_color = unsafe { !libc::getenv(NO_COLOR).is_null() };
  Colors::new(is_no_color)
});

#[must_use]
#[cfg_attr(feature = "hotpath", hotpath::measure)]
pub fn print_dots() -> String {
  // Pre-calculate capacity: 6 color codes + "  " (glyph + 2 spaces) per color
  const GLYPH: &str = "";
  let capacity = COLORS.blue.len()
    + COLORS.cyan.len()
    + COLORS.green.len()
    + COLORS.yellow.len()
    + COLORS.red.len()
    + COLORS.magenta.len()
    + COLORS.reset.len()
    + (GLYPH.len() + 2) * 6;

  let mut result = String::with_capacity(capacity);
  result.push_str(COLORS.blue);
  result.push_str(GLYPH);
  result.push_str("  ");
  result.push_str(COLORS.cyan);
  result.push_str(GLYPH);
  result.push_str("  ");
  result.push_str(COLORS.green);
  result.push_str(GLYPH);
  result.push_str("  ");
  result.push_str(COLORS.yellow);
  result.push_str(GLYPH);
  result.push_str("  ");
  result.push_str(COLORS.red);
  result.push_str(GLYPH);
  result.push_str("  ");
  result.push_str(COLORS.magenta);
  result.push_str(GLYPH);
  result.push_str("  ");
  result.push_str(COLORS.reset);

  result
}
