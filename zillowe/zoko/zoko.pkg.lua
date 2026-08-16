local version = ZOI.VERSION or "0.2.0"

metadata({
	name = "zoko",
	repo = "zillowe",
	version = version,
	revision = "17",
	description = "A JSON-like format for data storing",
	website = "https://zillowe.qzz.io/docs/akuolwa/zoko",
	git = "https://gitlab.com/zillowe/zillowex/akuolwa/zoko",
	maintainer = {
		name = "Zillowe Foundation",
		website = "https://zillowe.qzz.io",
		email = "contact@zillowe.qzz.io",
	},
	author = {
		name = "Zillowe Foundation",
		website = "https://zillowe.qzz.io",
		email = "contact@zillowe.qzz.io",
	},
	license = "Apache-2.0",
	bins = { "zoko-cli" },
	types = { "source" },
	tags = { "zillowe", "language", "cli" },
	platforms = { "linux" },
})

dependencies({
	build = {
		types = {
			source = {
				required = { "pacman:rust", "pacman:git" },
			},
		},
	},
})

function verify()
	return true
end

function prepare()
	cmd("git clone --depth 1 --branch " .. "v" .. version .. " " .. PKG.git .. " source")
	cmd("cd source")
	cmd("cargo fetch --locked")
end

function build()
	cmd("cd source")
	cmd("cargo build --release --locked -p zoko-cli")
end

function package()
	zcp("source/target/release/zoko-cli", "${pkgstore}/bin/zoko-cli")
end

function uninstall() end
