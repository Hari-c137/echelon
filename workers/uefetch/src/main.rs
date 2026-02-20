mod colors;
mod desktop;
mod release;
mod syscall;
mod system;
mod uptime;

use std::io::{self, Cursor, Write};

pub use microfetch_lib::UtsName;

use crate::{
  colors::print_dots,
  desktop::get_desktop_info,
  release::{get_os_pretty_name, get_system_info},
  system::{
    get_memory_usage,
    get_root_disk_usage,
    get_shell,
    get_username_and_hostname,
  },
  uptime::get_current,
};

#[cfg_attr(feature = "hotpath", hotpath::main)]
fn main() -> Result<(), Box<dyn std::error::Error>> {
  if Some("--version") == std::env::args().nth(1).as_deref() {
    println!("Microfetch {}", env!("CARGO_PKG_VERSION"));
  } else {
    let utsname = UtsName::uname()?;
    let fields = Fields {
      user_info:      get_username_and_hostname(&utsname),
      os_name:        get_os_pretty_name()?,
      kernel_version: get_system_info(&utsname),
      shell:          get_shell(),
      desktop:        get_desktop_info(),
      uptime:         get_current()?,
      memory_usage:   get_memory_usage()?,
      storage:        get_root_disk_usage()?,
      colors:         print_dots(),
    };
    print_system_info(&fields)?;
  }

  Ok(())
}

// Struct to hold all the fields we need in order to print the fetch. This
// helps avoid Clippy warnings about argument count, and makes it slightly
// easier to pass data around. Though, it is not like we really need to.
struct Fields {
  user_info:      String,
  os_name:        String,
  kernel_version: String,
  shell:          String,
  uptime:         String,
  desktop:        String,
  memory_usage:   String,
  storage:        String,
  colors:         String,
}

#[cfg_attr(feature = "hotpath", hotpath::measure)]
fn print_system_info(
  fields: &Fields,
) -> Result<(), Box<dyn std::error::Error>> {
  use crate::colors::COLORS;

  let Fields {
    user_info,
    os_name,
    kernel_version,
    shell,
    uptime,
    desktop,
    memory_usage,
    storage,
    colors,
  } = fields;

  let cyan = COLORS.cyan;
  let blue = COLORS.blue;
  let reset = COLORS.reset;

  let mut buf = [0u8; 2048];
  let mut cursor = Cursor::new(&mut buf[..]);

  write!(
    cursor,
    "
    {blue}     ▟█▖    {cyan}▝█▙ ▗█▛         {user_info} ~{reset}
    {blue}  ▗▄▄▟██▄▄▄▄▄{cyan}▝█▙█▛  {blue}▖       {cyan}  {blue}System{reset}        {os_name}
    {blue}  ▀▀▀▀▀▀▀▀▀▀▀▘{cyan}▝██  {blue}▟█▖      {cyan}  {blue}Kernel{reset}        {kernel_version}
    {cyan}     ▟█▛       {cyan}▝█▘{blue}▟█▛       {cyan}  {blue}Shell{reset}         {shell}
    {cyan}▟█████▛          {blue}▟█████▛    {cyan}  {blue}Uptime{reset}        {uptime}
    {cyan}   ▟█▛{blue}▗█▖       {blue}▟█▛         {cyan}  {blue}Desktop{reset}       {desktop}
    {cyan}  ▝█▛  {blue}██▖{cyan}▗▄▄▄▄▄▄▄▄▄▄▄      {cyan}󰍛  {blue}Memory{reset}        {memory_usage}
    {cyan}   ▝  {blue}▟█▜█▖{cyan}▀▀▀▀▀██▛▀▀▘      {cyan}󱥎  {blue}Storage (/){reset}   {storage}
    {blue}     ▟█▘ ▜█▖    {cyan}▝█▛         {cyan}  {blue}Colors{reset}        {colors}\n\n"
  )?;

  let len = cursor.position() as usize;
  // Direct syscall to avoid stdout buffering allocation
  let written = unsafe { libc::write(libc::STDOUT_FILENO, buf.as_ptr().cast(), len) };
  if written < 0 {
    return Err(io::Error::last_os_error().into());
  }
  if written as usize != len {
    return Err(io::Error::new(io::ErrorKind::WriteZero, "partial write to stdout").into());
  }
  Ok(())
}
