return {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = function()
        -- Call the configuration file here
        require("neocord").setup({
            logo = "https://styles.redditmedia.com/t5_30kix/styles/communityIcon_n2hvyn96zwk81.png",
            global_timer = true,
        }) -- Setup will be explained below.
    end,
}
