const hyprland = await Service.import("hyprland");

function Workspaces(monitor) {
    const activeId = hyprland.active.workspace.bind("id");

    const workspaces = hyprland.bind("workspaces").as((ws) =>
        ws
            .filter(({ id, monitorID }) => id >= 0 && monitorID === monitor)
            .map(({ id }) =>
                Widget.Button({
                    on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
                    child: Widget.Label(`${id}`),
                    class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
                })
            )
    );
    console.log(monitor);

    return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
    });
}

export default Workspaces;
