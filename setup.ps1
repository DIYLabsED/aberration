param(

  [string]$matDirPath = 'aberration\materials',
  [string]$mapDirPath = 'aberration\maps',
  [string]$mdlDirPath = 'aberration\models',
  [string]$portal2Path = 'C:\Program Files (x86)\Steam\steamapps\common\Portal 2\portal2'

)

# Utility for converting paths to absolute paths
# If an absolute path is proved to the -path argument, the same path is returned
# If a relative path is provided to the -path argument, the script's path is prepended to the realtive path
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

Write-Host "Portal 2/portal2 directory path set to: $portal2Path"