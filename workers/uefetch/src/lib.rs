pub mod colors;
pub mod desktop;
pub mod release;
pub mod syscall;
pub mod system;
pub mod uptime;

use std::mem::MaybeUninit;

/// Wrapper for `libc::utsname` with safe accessor methods
pub struct UtsName(libc::utsname);

impl UtsName {
  /// Calls `uname` syscall and returns a `UtsName` wrapper
  ///
  /// # Errors
  ///
  /// Returns an error if the `uname` syscall fails
  pub fn uname() -> Result<Self, std::io::Error> {
    let mut uts = MaybeUninit::uninit();
    if unsafe { libc::uname(uts.as_mut_ptr()) } != 0 {
      return Err(std::io::Error::last_os_error());
    }
    Ok(Self(unsafe { uts.assume_init() }))
  }

  #[must_use]
  pub const fn nodename(&self) -> &std::ffi::CStr {
    unsafe { std::ffi::CStr::from_ptr(self.0.nodename.as_ptr()) }
  }

  #[must_use]
  pub const fn sysname(&self) -> &std::ffi::CStr {
    unsafe { std::ffi::CStr::from_ptr(self.0.sysname.as_ptr()) }
  }

  #[must_use]
  pub const fn release(&self) -> &std::ffi::CStr {
    unsafe { std::ffi::CStr::from_ptr(self.0.release.as_ptr()) }
  }

  #[must_use]
  pub const fn machine(&self) -> &std::ffi::CStr {
    unsafe { std::ffi::CStr::from_ptr(self.0.machine.as_ptr()) }
  }
}
