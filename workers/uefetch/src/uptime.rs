use std::{io, mem::MaybeUninit};

/// Faster integer to string conversion without the formatting overhead.
#[inline]
fn itoa(mut n: u64, buf: &mut [u8]) -> &str {
  if n == 0 {
    return "0";
  }

  let mut i = buf.len();
  while n > 0 {
    i -= 1;
    buf[i] = b'0' + (n % 10) as u8;
    n /= 10;
  }

  unsafe { std::str::from_utf8_unchecked(&buf[i..]) }
}

/// Direct `sysinfo` syscall using inline assembly
///
/// # Safety
///
/// This function uses inline assembly to make a direct syscall.
/// The caller must ensure the sysinfo pointer is valid.
#[inline]
unsafe fn sys_sysinfo(info: *mut libc::sysinfo) -> i64 {
  #[cfg(target_arch = "x86_64")]
  {
    let ret: i64;
    unsafe {
      std::arch::asm!(
        "syscall",
        in("rax") 99_i64, // __NR_sysinfo
        in("rdi") info,
        out("rcx") _,
        out("r11") _,
        lateout("rax") ret,
        options(nostack)
      );
    }
    ret
  }

  #[cfg(target_arch = "aarch64")]
  {
    let ret: i64;
    unsafe {
      std::arch::asm!(
        "svc #0",
        in("x8") 179_i64, // __NR_sysinfo
        in("x0") info,
        lateout("x0") ret,
        options(nostack)
      );
    }
    ret
  }

  #[cfg(not(any(target_arch = "x86_64", target_arch = "aarch64")))]
  {
    unsafe { libc::sysinfo(info) as i64 }
  }
}

/// Gets the current system uptime.
///
/// # Errors
///
/// Returns an error if the system uptime cannot be retrieved.
#[cfg_attr(feature = "hotpath", hotpath::measure)]
pub fn get_current() -> Result<String, io::Error> {
  let uptime_seconds = {
    let mut info = MaybeUninit::uninit();
    if unsafe { sys_sysinfo(info.as_mut_ptr()) } != 0 {
      return Err(io::Error::last_os_error());
    }
    #[allow(clippy::cast_sign_loss)]
    unsafe {
      info.assume_init().uptime as u64
    }
  };

  let days = uptime_seconds / 86400;
  let hours = (uptime_seconds / 3600) % 24;
  let minutes = (uptime_seconds / 60) % 60;

  let mut result = String::with_capacity(32);
  let mut buf = [0u8; 20]; // Enough for u64::MAX

  if days > 0 {
    result.push_str(itoa(days, &mut buf));
    result.push_str(if days == 1 { " day" } else { " days" });
  }
  if hours > 0 {
    if !result.is_empty() {
      result.push_str(", ");
    }
    result.push_str(itoa(hours, &mut buf));
    result.push_str(if hours == 1 { " hour" } else { " hours" });
  }
  if minutes > 0 {
    if !result.is_empty() {
      result.push_str(", ");
    }
    result.push_str(itoa(minutes, &mut buf));
    result.push_str(if minutes == 1 { " minute" } else { " minutes" });
  }
  if result.is_empty() {
    result.push_str("less than a minute");
  }

  Ok(result)
}
