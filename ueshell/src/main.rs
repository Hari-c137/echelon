use amane::*;
use std::time::Duration;

struct Clock {
    time: String,
}

impl Service for Clock {
    fn new() -> Self {
        Self {
            time: amane::output("date +%H:%M"),
        }
    }

    fn interval() -> Duration {
        Duration::from_secs(1)
    }

    fn update(&mut self) -> bool {
        let time = amane::output("date +%H:%M");
        let changed = time != self.time;
        changed
    }
}

fn main() {
    App::new().window(view).run();
}

fn view() -> LayerWindow {
    let bat = Battery::read();
    let clock = Clock::read();
    let cpu = Cpu::read();
    let mem = Memory::read();

    let label = format!(
        "time: {}  bat:{:#?}%  cpu:{}%   memory:{}%",
        clock.time,
        if bat.present() == true {
            bat.percent()
        } else {
            0
        },
        cpu.percent(),
        mem.percent(),
    );

    LayerWindow::new()
        .width(Full)
        .height(30.0)
        .anchor_vertical(Vertical::Top)
        .layer(Layer::Top)
        .space(amane::Zone::Reserve)
        .child(Text::new(&clock.time))
        .child(
            Rectangle::new()
                .width(Parent)
                .height(Parent)
                .fill(Color::BLACK)
                .child(Text::new(label).size(20.0).color(Color::WHITE)),
        )
}
