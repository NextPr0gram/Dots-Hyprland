const hyprland = await Service.import("hyprland");
function ClientTitle() {
    const activeClientTitle = hyprland.active.client.bind("title");

    function showClientTitle() {
        if (activeClientTitle.emitter.title == "") {
            clientTitleLabel.hide();
        } else {
            clientTitleLabel.show();
        }
    }
    const clientTitleLabel = Widget.Label({
        class_name: "client-title",
        label: activeClientTitle,
    });
    activeClientTitle.emitter.connect("notify::title", showClientTitle);
    return clientTitleLabel;
}

export default ClientTitle;
