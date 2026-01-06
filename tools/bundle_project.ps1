# bundle_project.ps1
$excludeNames = @(
    ".git",
    "build",
    "bin",
    "out",
    "*.exe",
    "*.pdb",
    "*.obj",
    "*.ilk",
    "*.zip",
    "*.ps1"
)

$items = Get-ChildItem -Force | Where-Object {
    $name = $_.Name
    -not ($excludeNames | Where-Object { $name -like $_ })
}

Compress-Archive `
    -Path $items.FullName `
    -DestinationPath project_bundle.zip `
    -Force
