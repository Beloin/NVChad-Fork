require ('mason-nvim-lint').setup({
    ensure_installed = {'cmakelang', 'cpplint', 'markdownlint'},
    automatic_installation = true
})

-- TODO: Check if is necessary since we are using TreeSitter