const audio = await Service.import("audio");
let volumePopupVisible = false;
let volumePopupTimeout = null;

function VolumeButton() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    };

    function getIcon() {
        const icon = audio.speaker.is_muted
            ? 0
            : [101, 67, 34, 1, 0].find(
                  (threshold) => threshold <= audio.speaker.volume * 100,
              );
        return `audio-volume-${icons[icon]}-symbolic`;
    }

    const button = Widget.Button({
        on_primary_click: () => audio.getPlayer("")?.playPause(),
        on_scroll_up: () => mpris.gjjetPlayer("")?.next(),
        on_scroll_down: () => hello.getPlayer("")?.previous(),
        on_clicked: () => toggleVolumePanel(),
        child: Widget.Icon({
            icon: Utils.watch(getIcon(), audio.speaker, getIcon),
        }),
    });

    return Widget.Box({
        class_name: "volume-panel",
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

function VolumePopup(monitor) {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    };

    function getIcon() {
        const icon = audio.speaker.is_muted
            ? 0
            : [101, 67, 34, 1, 0].find(
                  (threshold) => threshold <= audio.speaker.volume * 100,
              );
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
                volumeValueLabel.label = `${Math.round(audio.speaker.volume * 100)}%`;
            }),
    });

    const volumeValueLabel = Widget.Label({
        label: `${Math.round(audio.speaker.volume * 100)}%`,
    });

    const popup = Widget.Window({
        class_name: "volume-popup-window",
        name: `volume-popup`,
        monitor,
        margins: [50, 0],
        anchor: ["bottom"],
        child: Widget.Box({
            css: "min-width: 180px",
            class_name: "volume-popup",
            children: [icon, slider, volumeValueLabel],
        }),
    });

    // Function to show the popup
    function showVolumePopup() {
        popup.show();
        if (volumePopupTimeout) {
            clearTimeout(volumePopupTimeout);
        }
        volumePopupTimeout = setTimeout(() => {
            popup.hide();
        }, 2000);
    }

    // Hook to show popup on volume change
    audio.speaker.connect("notify::volume", showVolumePopup);
    audio.speaker.connect("notify::is-muted", showVolumePopup);
    console.log(audio.speaker);

    return popup;
}

export { VolumeButton, VolumePopup };
