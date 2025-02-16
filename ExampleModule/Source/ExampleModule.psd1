@{
    RootModule        = 'ExampleModule.psm1'
    ModuleVersion     = '1.0.1'
    GUID              = '8a8cf5bf-94ff-488a-ab31-0cbf950fb36b'
    Author            = 'Your Name'
    Description       = 'Description of ExampleModule module.'
    FunctionsToExport = @('*')
    PrivateData       = @{
        PSData = @{
            Tags       = @('PowerShell', 'Module')
            ProjectUri = 'https://your.project.repo'
        }
    }
}
