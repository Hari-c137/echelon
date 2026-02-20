use std::{ffi::CStr, fmt::Write};

#[must_use]
#[cfg_attr(feature = "hotpath", hotpath::measure)]
pub fn get_desktop_info() -> String {
  // Retrieve the environment variables and handle Result types
  let desktop_str = unsafe {
    let ptr = libc::getenv(c"XDG_CURRENT_DESKTOP".as_ptr());
    if ptr.is_null() {
      "Unknown"
    } else {
      let s = CStr::from_ptr(ptr).to_str().unwrap_or("Unknown");
      s.strip_prefix("none+").unwrap_or(s)
    }
  };

  let backend_str = unsafe {
    let ptr = libc::getenv(c"XDG_SESSION_TYPE".as_ptr());
    if ptr.is_null() {
      "Unknown"
    } else {
      let s = CStr::from_ptr(ptr).to_str().unwrap_or("Unknown");
      if s.is_empty() { "Unknown" } else { s }
    }
  };

  // Pre-calculate capacity: desktop_len + " (" + backend_len + ")"
  // Capitalize first char needs temporary allocation only if backend exists
  let mut result =
    String::with_capacity(desktop_str.len() + backend_str.len() + 3);
  result.push_str(desktop_str);
  result.push_str(" (");

  // Capitalize first character of backend
  if let Some(first_char) = backend_str.chars().next() {
    let _ = write!(result, "{}", first_char.to_ascii_uppercase());
    result.push_str(&backend_str[first_char.len_utf8()..]);
  }

  result.push(')');
  result
}
