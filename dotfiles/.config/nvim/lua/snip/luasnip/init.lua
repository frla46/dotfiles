local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local func = ls.function_node

ls.add_snippets(nil, {
	all = {},
	python = {
		-- input
		s("Is", {
			i(1),
			t(" = input()"),
			i(0),
		}),
		s("Ii", {
			i(1),
			t(" = int(input())"),
			i(0),
		}),
		s("Isn", {
			i(1),
			t(" = input().split()"),
			i(0),
		}),
		s("Iin", {
			i(1),
			t(" = [int(i) for i in input().split()]"),
			i(0),
		}),
		s("Isl", {
			i(1),
			t(" = [input() for _ in range("),
			i(2, "n"),
			t(")]"),
			i(0),
		}),
		s("Iil", {
			i(1),
			t(" = [int(input()) for _ in range("),
			i(2, "n"),
			t(")]"),
			i(0),
			i(0),
		}),
		s("Isnl", {
			i(1),
			t(" = [input().split() for _ in range("),
			i(2, "n"),
			t(")]"),
			i(0),
			i(0),
		}),
		s("Iinl", {
			i(1),
			t(" = [[int(i) for i in input().split()] for _ in range("),
			i(2, "n"),
			t(")]"),
			i(0),
			i(0),
		}),
		-- output
		s("O", {
			t("print("),
			i(1),
			t(")"),
			i(0),
		}),
		s("Oyl", {
			t([[print('yes']]),
			i(0),
		}),
		s("Oyu", {
			t([[print('Yes')]]),
			i(0),
		}),
		s("Onl", {
			t([[print('no']]),
			i(0),
		}),
		s("Onu", {
			t([[print('No')]]),
			i(0),
		}),
		-- const
		s("Inf", {
			t("float('inf')", "hoge"),
			i(0),
		}),
		-- misc
		s("exec_main", {
			t({ "if __name__ == '__main__':", "\tmain()" }),
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
