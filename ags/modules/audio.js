const audio = await Service.import("audio");
function VolumeButton() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    };

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find((threshold) => threshold <= audio.speaker.volume * 100);

        return `audio-volume-${icons[icon]}-symbolic`;
    }

    const button = Widget.Button({
        //on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
        on_clicked: () => toggleVolumePanel(),
        child: Widget.Icon({
            icon: Utils.watch(getIcon(), audio.speaker, getIcon),
        }),
    });

    return Widget.Box({
        class_name: "volume-panel",
        //css: "min-width: 180px",
        child: button,
    });
}

function AppVolumeSlider(stream) {
    return Widget.Box({
        children: [
            Widget.Icon({ icon: stream.bind("icon_name") }),
            Widget.Label({ label: stream.bind("name") }),
            Widget.Slider({
                hexpand: true,
                draw_value: false,
                value: stream.volume,
                on_change: ({ value }) => (stream.volume = value),
            }),
        ],
    });
}

function VolumePanel() {
    const streams = audio.bind("apps").as((apps) => apps.map((stream) => AppVolumeSlider(stream)));

    return Widget.Window({
        name: "volume-panel",
        visible: false,
        layer: "overlay",
        anchor: ["right", "top"],
        child: Widget.Box({
            vertical: true,
            children: [
                Widget.Label({ label: "Application Volumes" }),
                Widget.Box({
                    class_name: "volume-sliders",
                    vertical: true,
                    children: streams,
                }),
            ],
        }),
    });
}

let volumePanelVisible = false;

function toggleVolumePanel() {
    volumePanelVisible = !volumePanelVisible;
    App.getWindow("volume-panel").visible = volumePanelVisible;
}

export { VolumeButton, VolumePanel };

/* function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    };

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find((threshold) => threshold <= audio.speaker.volume * 100);

        return `audio-volume-${icons[icon]}-symbolic`;
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    });

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => (audio.speaker.volume = value),
        setup: (self) =>
            self.hook(audio.speaker, () => {
                self.value = audio.speaker.volume || 0;
            }),
    });

    return Widget.Box({
        class_name: "volume",
        css: "min-width: 180px",
        children: [icon, slider],
    });
}
 */