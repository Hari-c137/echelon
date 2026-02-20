use std::{fmt::Write as _, io};

use crate::{UtsName, syscall::read_file_fast};

#[must_use]
#[cfg_attr(feature = "hotpath", hotpath::measure)]
pub fn get_system_info(utsname: &UtsName) -> String {
  let sysname = utsname.sysname().to_str().unwrap_or("Unknown");
  let release = utsname.release().to_str().unwrap_or("Unknown");
  let machine = utsname.machine().to_str().unwrap_or("Unknown");

  // Pre-allocate capacity: sysname + " " + release + " (" + machine + ")"
  let capacity = sysname.len() + 1 + release.len() + 2 + machine.len() + 1;
  let mut result = String::with_capacity(capacity);

  write!(result, "{sysname} {release} ({machine})").unwrap();
  result
}

/// Gets the pretty name of the OS from `/etc/os-release`.
///
/// # Errors
///
/// Returns an error if `/etc/os-release` cannot be read.
#[cfg_attr(feature = "hotpath", hotpath::measure)]
pub fn get_os_pretty_name() -> Result<String, io::Error> {
  const PREFIX: &[u8] = b"SYSTEM_NAME=";

  let mut buffer = [0u8; 1024];

  // Use fast syscall-based file reading
  let bytes_read = read_file_fast("/etc/os-release", &mut buffer)?;
  let content = &buffer[..bytes_read];

  let mut offset = 0;

  while offset < content.len() {
    let remaining = &content[offset..];

    // Find newline or end
    let line_end = remaining
      .iter()
      .position(|&b| b == b'\n')
      .unwrap_or(remaining.len());
    let line = &remaining[..line_end];

    if line.starts_with(PREFIX) {
      let value = &line[PREFIX.len()..];

      // Strip quotes if present
      let trimmed = if value.len() >= 2
        && value[0] == b'"'
        && value[value.len() - 1] == b'"'
      {
        &value[1..value.len() - 1]
      } else {
        value
      };

      // Convert to String - should be valid UTF-8
      return Ok(String::from_utf8_lossy(trimmed).into_owned());
    }

    offset += line_end + 1;
  }

  Ok("Unknown".to_owned())
}
