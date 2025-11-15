param(

  [string]$modDirPath = 'aberration',
  [string]$sourceDirPath = 'src',
  [string]$gamePath = 'C:\Program Files (x86)\Steam\steamapps\common\Portal 2\',

  [switch]$copyVMFIntoRepo,
  [switch]$copyBSPIntoRepo, 
  [string]$mapName,
  [switch]$copyAssetsIntoGame,

  [switch]$runGameAfterAssetCopy,
  [string]$gameArgs = ''

)

# Utility for converting paths to absolute paths
# If an absolute path is passed, the same path is returned
# If a relative path is passed, the script's path is prepended to the relative path
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

function conflictCheck(){

  # Throw error if no map name is passed for copyVMF and copyBSP
  if(-not $mapName){

    if($copyVMFIntoRepo){
      Write-Error "copyVMFIntoRepo needs a map name!"
    }

    if($copyBSPIntoRepo){
      Write-Error "copyBSPIntoRepo needs a map name!"
    }

  }

  # Throw error if copyVMF/copyBSP *and* copyAssets is called 
  # (Lazy solution to avoid file conflicts)
  if($copyAssetsIntoGame){

    if($copyVMFIntoRepo -or $copyBSPIntoRepo){
      Write-Error "Cannot copy assets into game and repo at the same time!"
    }

  }

}

function vmfIntoRepo(){

  # TODO: Look into why -AdditionalChildPath argument is throwing NamedParameterNotFound error
  $mapNameVMF = $mapName + ".vmf"
  $mapsDir = Join-Path -Path $gamePath -ChildPath "sdk_content/maps"
  $vmfPath = Join-Path -Path $mapsDir -ChildPath $mapNameVMF

  $resolvedSourcedDirPath = resolveSourcePath -path $sourceDirPath

  $repoPath = Join-Path $resolvedSourcedDirPath -ChildPath "mapsrc"

  Write-Host "Absolute path of VMF file to be copied: $vmfPath"
  Write-Host "Absolute path in repo where VMF file will be copied: $repoPath"

  Copy-Item -Path $vmfPath -Destination $repoPath -Force

}

function bspIntoRepo(){

  $mapNameBSP = $mapName + ".bsp"
  $mapsDir = Join-Path -Path $gamePath -ChildPath "portal2/maps"
  $vmfPath = Join-Path -Path $mapsDir -ChildPath $mapNameBSP

  $resolvedModDirPath = resolveSourcePath -path $modDirPath

  $repoPath = Join-Path $resolvedModDirPath -ChildPath "maps"

  Write-Host "Absolute path of BSP file to be copied: $vmfPath"
  Write-Host "Absolute path in repo where BSP file will be copied: $repoPath"

  Copy-Item -Path $vmfPath -Destination $repoPath -Force

}

function assetsIntoGame(){

  $resolvedModDirPath = resolveSourcePath -path $modDirPath
  $p2Path = Join-Path -Path $gamePath -ChildPath "portal2"

  Write-Host "Copying assets from $resolvedModDirPath to $p2Path"

  Copy-Item -Path $resolvedModDirPath -Destination $p2Path -Recurse -Force

}


conflictCheck

if($copyVMFIntoRepo){
  vmfIntoRepo
}

if($copyBSPIntoRepo){
  bspIntoRepo
}

if($copyAssetsIntoGame){
  AssetsIntoGame
}