Write-Host "Removing HELIX_RUNTIME environment variable"
Uninstall-ChocolateyEnvironmentVariable `
  -VariableName "HELIX_RUNTIME" `
  -VariableType Machine
