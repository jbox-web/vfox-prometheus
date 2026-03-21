--- Performs additional setup after installation
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#postinstall-hook
--- @param ctx {rootPath: string, runtimeVersion: string, sdkInfo: table} Context

require("util")

function PLUGIN:PostInstall(ctx)
  local sdkInfo = ctx.sdkInfo[PLUGIN.name]
  local path = sdkInfo.path

  local binaries = {PLUGIN.name, "promtool"}
  install_from_list(path, binaries)

  -- Verify installation works
  local destFile = path .. "/bin/" .. PLUGIN.name
  local result = os.execute(destFile .. " --version > /dev/null 2>&1")
  if result ~= 0 then
    error(PLUGIN.name .. " installation appears to be broken")
  end
end
