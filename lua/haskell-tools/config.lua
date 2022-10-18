local deps = require('haskell-tools.deps')

local M = {}

local ht_capabilities = {}
local cmp_capabilities = deps.if_available(
  'cmp_nvim_lsp', 
  function(cmp_nvim_lsp)
    return cmp_nvim_lsp.default_capabilities() 
  end, 
  {}
)
local capabilities = vim.tbl_deep_extend('keep', ht_capabilities, cmp_capabilities)

local defaults = {
  -- haskell-language-server config
  hls = {
    on_attach = function(...) end,
    capabilities = capabilities,
    haskell = {
      -- The formatting provider.
      formattingProvider = 'ormolu',
      -- Maximum number of completions sent to the LSP client.
      maxCompletions = 40,
      -- Whether to typecheck the entire project on initial load. 
      -- Could drive to bad performance in large projects, if set to true.
      checkProject = true,
      -- When to typecheck reverse dependencies of a file; 
      -- one of NeverCheck, CheckOnSave (means dependent/parent modules will only be checked when you save), 
      -- or AlwaysCheck (means re-typechecking them on every change).
      checkParents = 'CheckOnSave',
      plugin = {
        alternateNumberFormat = {globalOn = true,},
        callHierarchy = {globalOn = true,},
        changeTypeSignature = {globalOn = true,},
        class = {
          codeActionsOn = true,
          codeLensOn = true,
        },
        eval = {
          globalOn = true,
          config = {
            diff = true,
            exception = true,
          },
        },
        excplicitFixity = {globalOn = true,},
        gadt = {globalOn = true,},
        ['ghcide-code-actions-bindings'] = {globalOn = true,},
        ['ghcide-code-actions-fill-holes'] = {globalOn = true,},
        ['ghcide-code-actions-imports-exports'] = {globalOn = true,},
        ['ghcide-code-actions-type-signatures'] = {globalOn = true,},
        ['ghcide-completions'] = {
          globalOn = true,
          config = {
            autoExtendOn = true,
            snippetsOn = true,
          },
        },
        ['ghcide-hover-and-symbols'] = {
          hoverOn = true,
          symbolsOn = true,
        },
        ['ghcide-type-lenses'] = {
          globalOn = true,
          config = {
            mode = 'always',
          },
        },
        haddockComments = {globalOn = true,},
        hlint = {
          codeActionsOn = true,
          diagnosticsOn = true,
        },
        importLens = {
          globalOn = true,
          codeActionsOn = true,
          codeLensOn = true,
        },
        moduleName = {globalOn = true,},
        pragmas = {
          codeActionsOn = true,
          completionOn = true,
        },
        qualifyImportedNames = {globalOn = true,},
        refineImports = {
          codeActionsOn = true,
          codeLensOn = true,
        },
        rename = {
          globalOn = true,
          config = {crossModule = true,},
        },
        retrie = {globalOn = true,},
        splice = {globalOn = true,},
        tactics = {
          codeActionsOn = true,
          codeLensOn = true,
          config = {
            auto_gas = 4,
            hole_severity = nil,
            max_use_ctor_actions = 5,
            proofstate_styling = true,
            timeout_duration = 2,
          },
          hoverOn = true,
        },
      },
    },
  }
}

M.options = {
  hls = {},
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend('force', {}, defaults, opts or {})
end

return M
