--- Returns a list of available versions for the tool
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook
--- @param ctx {args: string[]} Context (args = user arguments)
--- @return table[] List of available versions

require("versions")

function PLUGIN:Available(ctx)
  local github_repo = "prometheus/prometheus"
  local url         = github_tags_url(github_repo)
  local result      = list_available_versions(url)

  return result
end
