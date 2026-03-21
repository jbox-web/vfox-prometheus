function fetch_checksum(github_repo, version)
  local url      = github_checksum_url(github_repo, version)
  local filename = get_filename(version)
  local response = download_checksum(url)
  local checksum = extract_checksum(response, filename)
  return checksum
end

function download_checksum(url)
  local http = require("http")

  local resp, err = http.get({
    url = url,
  })

  if err ~= nil then
    error("Failed to fetch checksum: " .. err)
  end

  if resp.status_code ~= 200 then
    error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
  end

  return resp.body
end

function extract_checksum(string, filename)
  local checksum = nil
  local list = split(string, "\n")

  for _, val in ipairs(list) do
    local data = split(val, " ")
    if data[3] == filename then
      checksum = data[1]
      break
    end
  end

  return checksum
end

function split(pString, pPattern)
  local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
  local fpat = "(.-)" .. pPattern
  local last_end = 1
  local s, e, cap = pString:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
    end
    last_end = e+1
    s, e, cap = pString:find(fpat, last_end)
  end
  if last_end <= #pString then
    cap = pString:sub(last_end)
    table.insert(Table, cap)
  end
  return Table
end
