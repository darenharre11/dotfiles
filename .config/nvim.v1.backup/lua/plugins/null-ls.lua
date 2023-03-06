local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {

	-- webdev stuff
	-- b.formatting.deno_fmt,
	b.formatting.prettierd.with({
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
			"json",
			"jsonc",
			"yaml",
			"markdown",
			"graphql",
			"handlebars",
		},
	}),

	-- Lua
	b.formatting.stylua,
	b.formatting.stylua.with({ extra_args = { indent_width = 2, indent_type="Spaces" } }),
	-- b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

	-- Shell
	b.formatting.shfmt,
	-- b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
}

null_ls.setup({
	debug = true,
	sources = sources,
})
