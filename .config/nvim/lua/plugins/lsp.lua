return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                diagnosticSeverityOverrides = {
                  reportUnusedVariable = "warning",
                  reportUnusedImport = "warning",
                },
              },
            },
          },
        },
      },
    },
  },
}
