# Copies asset and map files into Portal 2, and runs game
# Directories can be manually specified using the -matDirPath, -mapDirPath, and -mdlDirPath arguments. Paths can be absolute or relative
# The path to the steamapps/common/Portal 2 directory can be specified using the -portal2Path argument
# Launch arguments for Portal 2 can be specified using the -portal2Args argument. See https://developer.valvesoftware.com/wiki/Command_line_options for a list of arguments
# Launching Portal 2 after copying can be disabled with the -noLaunchGame flag

param(

  [string]$matDirPath = '\materials',
  [string]$mapDirPath = '\maps',
  [string]$mdlDirPath = '\models',
  [string]$portal2Path = 'C:\Program Files (x86)\Steam\steamapps\common\Portal 2\',
  [string]$portal2Args = '-novid',
  [switch]$noLaunchGame

)

# Utility for converting paths to absolute paths
# If an absolute path is passed, the same path is returned
# If a relative path is passed, the script's path is prepended to the realtive path
function resolveSourcePath{

  param(
    [string]$path
  )

  # If input path is absolute, return as-is
  if([System.IO.Path]::IsPathRooted($path)){

    Write-Host "Resolved absolute path: $path" -ForegroundColor Black
    return $path

  }

  # Else, prepend script's path before input path
    $resolvedPath =  Join-Path -Path $PSScriptRoot -ChildPath $path
    Write-Host "Resolved relative path: $path as $resolvedPath" -ForegroundColor Cyan
    return $resolvedPath

}

# Resolve asset folder paths
$CopyMatPath = resolveSourcePath -path $matDirPath
$CopyMapPath = resolveSourcePath -path $mapDirPath
$CopyMdlPath = resolveSourcePath -path $mdlDirPath

Write-Host "Portal 2 directory path set to: $portal2Path"

if(-not $noLaunchGame){

  $execPath = Join-Path -Path $portal2Path -ChildPath "portal2.exe"
  Write-Host "Launching Portal 2 at: $execPath with arguments: $portal2Args" -ForegroundColor Green
  & $ExecPath $portal2Args

}