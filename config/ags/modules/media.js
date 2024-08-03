const mpris = await Service.import("mpris");

function Media() {
    const label = Utils.watch("", mpris, "player-changed", () => {
        if (mpris.players[0]) {
            const { track_artists, track_title } = mpris.players[0];
            if (mpris.players[0]["play-back-status"] == "Playing") {
                return `Now playing: ${track_artists.join(", ")} - ${track_title}`;
            } else if (mpris.players[0]["play-back-status"] == "Paused") {
                return `Paused: ${track_artists.join(", ")} - ${track_title}`;
            }
        } else {
            return "Nothing is playing";
        }
    });

    return Widget.Button({
        class_name: "media",
        on_primary_click: () => mpris.getPlayer("")?.playPause(),
        on_scroll_up: () => mpris.getPlayer("")?.next(),
        on_scroll_down: () => mpris.getPlayer("")?.previous(),
        child: Widget.Label({ label }),
    });
}

export default Media;
