local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local func = ls.function_node

ls.add_snippets(nil, {
	all = {},
	lua = {
		s("luasnip_newsnip", {
			t('s("'),
			i(1, "snip name"),
			t({ '", {', "" }),
			i(2),
			t({ "\ti(0),", "})," }),
			i(0),
		}),
	},
	tex = {
		s("frac", {
			t("\\frac{"),
			i(1),
			t("}{"),
			i(2),
			t("}"),
			i(0),
		}),
	},
})
