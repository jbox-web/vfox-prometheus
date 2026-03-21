function github_tags_url(github_repo)
  local repo_url = "https://api.github.com/repos/" .. github_repo .. "/tags"
  return repo_url
end

function list_available_versions(repo_url)
  local http = require("http")
  local json = require("json")

  local github_token = os.getenv("MISE_GITHUB_TOKEN") or os.getenv("GITHUB_API_TOKEN") or os.getenv("GITHUB_TOKEN") or ""

  if github_token ~= "" then
    local headers = {
      ["Authorization"] = "Bearer " .. github_token
    }
  else
    local headers = {}
  end

  local resp, err = http.get({
    headers = headers,
    url = repo_url,
  })

  if err ~= nil then
    error("Failed to fetch versions: " .. err)
  end

  if resp.status_code ~= 200 then
    error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
  end

  local tags = json.decode(resp.body)
  local result = {}

  -- Process tags/releases
  for _, tag_info in ipairs(tags) do
    local version = tag_info.name

    -- Clean up version string (remove 'v' prefix if present)
    version = version:gsub("^v", "")

    table.insert(result, {
      version = version,
      note = nil,
    })
  end

  return result
end
