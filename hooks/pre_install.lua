--- Returns download information for a specific version
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook
--- @param ctx {version: string, runtimeVersion: string} Context
--- @return table Version and download information

require("base")
require("checksum")

function PLUGIN:PreInstall(ctx)
  local github_repo = "prometheus/prometheus"
  local version     = ctx.version
  local url         = github_download_url(github_repo, version)
  local sha256      = fetch_checksum(github_repo, version)

  return {
    version = version,
    url     = url,
    sha256  = sha256,
    note    = "Downloading " .. PLUGIN.name .. " " .. version,
  }
end
