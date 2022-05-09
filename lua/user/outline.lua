vim.g.lightline = {
    colorscheme = 'wombat',
    active = {
        left = {'mode', 'paste'},
    },
    component_function = {
        method = 'NearestMethodOrFunction',
    },
}
