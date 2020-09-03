[CmdletBinding()]
param(
    $badParam
)
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
# Powershell2-compatible way of forcing named-parameters
if ($badParam)
{
    throw "Only named parameters are allowed"
}

try
{
    $scriptsDir = split-path -parent $script:MyInvocation.MyCommand.Definition
    $rootDir = split-path -parent $scriptsDir

    $arguments = @{
        Distro = "foxy"
        Version = "foxy/2020-08-27"
        Packages = @(
            'navigation2',
            'desktop',
            'random_numbers',
            'joint_state_publisher',
            'octomap_msgs',
            'urdf_parser_py',
            'object_recognition_msgs',
            'turtlebot3_msgs',
            'gazebo_ros_pkgs'
        )
    }

    & (Join-Path $rootDir "generateRepos.ps1") @arguments
}
catch
{
  Write-Warning "Failed to generate Foxy repos."
  throw
}