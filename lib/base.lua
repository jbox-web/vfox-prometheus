require("util")

function get_filename(version)
  local platform = get_platform()
  local filename = PLUGIN.name .. "-" .. version .. "." .. platform .. ".tar.gz"
  return filename
end

function github_base_url(github_repo, version)
  local url = "https://github.com/" .. github_repo .. "/releases/download/v" .. version
  return url
end

function github_download_url(github_repo, version)
  local filename = get_filename(version)
  local url = github_base_url(github_repo, version) .. "/" .. filename
  return url
end

function github_checksum_url(github_repo, version)
  local filename = "sha256sums.txt"
  local url = github_base_url(github_repo, version) .. "/" .. filename
  return url
end
