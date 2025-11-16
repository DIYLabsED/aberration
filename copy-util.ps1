param(

  [string]$modDirPath = 'aberration',
  [string]$sourceDirPath = 'src',
  [string]$gamePath = 'C:\Program Files (x86)\Steam\steamapps\common\Portal 2\',
  [string]$steamPath = 'C:\Program Files (x86)\Steam\steam.exe',

  [switch]$copyVMFIntoRepo,
  [switch]$copyBSPIntoRepo, 
  [string]$mapName,
  [switch]$copyAssetsIntoGame,

  [switch]$runGame,
  [string]$gameArgs = '',
  [string]$gameID = 620

)

# Utility for converting paths to absolute paths
# If an absolute path is passed, the same path is returned
# If a relative path is passed, the script's path is prepended to the relative path
function Resolve-Source-Path{

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

function Conflict-Check(){

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

function Copy-VMF-Into-Repo(){

  # TODO: Look into why -AdditionalChildPath argument is throwing NamedParameterNotFound error
  $mapNameVMF = $mapName + ".vmf"
  $mapsDir = Join-Path -Path $gamePath -ChildPath "sdk_content/maps"
  $vmfPath = Join-Path -Path $mapsDir -ChildPath $mapNameVMF

  $resolvedSourcedDirPath = Resolve-Source-Path -path $sourceDirPath

  $repoPath = Join-Path $resolvedSourcedDirPath -ChildPath "mapsrc"

  Write-Host "Copying VMF file from $vmfPath to $repoPath" -ForegroundColor Green

  Copy-Item -Path $vmfPath -Destination $repoPath -Force

}

function Copy-BSP-Into-Repo(){

  $mapNameBSP = $mapName + ".bsp"
  $mapsDir = Join-Path -Path $gamePath -ChildPath "portal2/maps"
  $bspPath = Join-Path -Path $mapsDir -ChildPath $mapNameBSP

  $resolvedModDirPath = Resolve-Source-Path -path $modDirPath

  $repoPath = Join-Path $resolvedModDirPath -ChildPath "maps"

  Write-Host "Copying BSP file from $bspPath to $repoPath" -ForegroundColor Green

  Copy-Item -Path $bspPath -Destination $repoPath -Force

}

function Copy-Assets-Into-Game(){

  $resolvedModDirPath = Resolve-Source-Path -path $modDirPath
  $p2Path = Join-Path -Path $gamePath -ChildPath "portal2"

  Write-Host "Copying assets from $resolvedModDirPath to $p2Path" -ForegroundColor Green

  Copy-Item -Path $resolvedModDirPath -Destination $p2Path -Recurse -Force

}

function Launch-Game(){

  Write-Host "Launching game ID $gameID with arguments $gameArgs using Steam at $steamPath" -ForegroundColor Yellow

  & $steamPath -applaunch $gameID $gameArgs

}

Conflict-Check

if($copyVMFIntoRepo){
  Copy-VMF-Into-Repo
}

if($copyBSPIntoRepo){
  Copy-BSP-Into-Repo
}

if($copyAssetsIntoGame){
  Copy-Assets-Into-Game
}

if($runGame){
  Launch-Game
}

Read-Host -Prompt "Press ENTER to close this window"