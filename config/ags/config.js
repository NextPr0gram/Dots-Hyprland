import { VolumeButton, VolumePopup } from "./modules/audio.js";
import ClientTitle from "./modules/client-title.js";
import Notification from "./modules/notification.js";
import Clock from "./modules/clock.js";
import SysTray from "./modules/systray.js";
import BatteryLabel from "./modules/battery-label.js";
import Workspaces from "./modules/workspaces.js";
import Media from "./modules/media.js";

function Left(monitor) {
    return Widget.Box({
        spacing: 8,
        children: [Workspaces(monitor), ClientTitle()],
    });
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [Media(), Notification()],
    });
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [SysTray(), VolumeButton(), BatteryLabel(), Clock()],
    });
}

function Bar(monitor) {
    return Widget.Window({
        name: `bar-${monitor}`,
        class_name: "bar",
        margins: [10, 10, 0, 10],
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(monitor),
            center_widget: Center(),
            end_widget: Right(),
        }),
    });
}

App.config({
    style: "./style.css",
    windows: [Bar(0), VolumePopup(0)],
});

export {};
